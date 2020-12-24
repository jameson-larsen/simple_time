require 'date'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum user_role: [:employee, :admin]
  enum status: [:is_in, :is_out]

  belongs_to :company
  has_many :punches, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :time_off_requests, dependent: :destroy

  def last_punch_date
    #(Time.at(self.last_time)).strftime("%b %-d %Y, %l:%M%p")
    time = self.last_time.to_i
  end

  def weekly_hours
    r = 0
    begin_week = Date.today.beginning_of_week.in_time_zone(self.time_zone) - 1.day
    end_week = Date.today.beginning_of_week.in_time_zone(self.time_zone) + 1.week - 1.day
    arr1 = self.punches.where(out: begin_week..end_week)
    arr2 = self.punches.where(in: begin_week..end_week).where("out > ?", end_week)
    arr3 = arr1 + arr2
    arr3.each do |p|
      if p.in < begin_week
        r = r + p.duration - ((p.out - begin_week.to_time).to_f / 3600.0)
      elsif p.out > end_week
        r = r + ((end_week).to_time - p.in).to_f / 3600.0
      else
        r = r + p.duration
      end
    end
    return "%.2f" % r
  end

  def hours_between(date1, date2)
    if !date1.nil? && !date2.nil? && date1 != "" && date2 != ""
      if date1.to_date > date2.to_date
        return 0
      else
        r = 0
        date1 = date1.to_date.in_time_zone(self.time_zone)
        date2 = date2.to_date.in_time_zone(self.time_zone).end_of_day
        arr1 = self.punches.where(out: date1..date2)
        arr2 = self.punches.where(in: date1..date2).where("out > ?", date2)
        arr3 = arr1 + arr2
        arr3.each do |p|
          if p.in < date1
            r = r + p.duration - ((p.out - date1.to_time).to_f / 3600.0)
          elsif p.out > date2
            r = r + ((date2).to_time - p.in).to_f / 3600.0
          else
            r = r + p.duration
          end
        end
        return "%.2f" % r
      end
    else
      return 0
    end
  end

  def self.search(search)
    if search 
        where(["lower(f_name) LIKE ?","%#{search.downcase}%"]).or(where(["lower(l_name) LIKE ?","%#{search.downcase}%"])).or(where(id: search.to_i))
    else
        all
    end
  end
  
end
