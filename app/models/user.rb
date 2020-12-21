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

  def last_punch_date
    #(Time.at(self.last_time)).strftime("%b %-d %Y, %l:%M%p")
    time = self.last_time.to_i
  end

  def weekly_hours
    r = 0
    self.punches.where(created_at: Date.today.beginning_of_week.in_time_zone(self.time_zone)..Date.today.beginning_of_week.in_time_zone(self.time_zone) + 1.week).each do |p|
      r = r + p.duration
    end
    return "%.2f" % r
  end

  def self.search(search)
    if search 
        where(["lower(f_name) LIKE ?","%#{search.downcase}%"]).or(where(["lower(l_name) LIKE ?","%#{search.downcase}%"])).or(where(id: search.to_i))
    else
        all
    end
  end
  
end
