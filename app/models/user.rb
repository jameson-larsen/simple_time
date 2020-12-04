require 'date'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum user_role: [:employee, :admin]
  enum status: [:is_in, :is_out]

  belongs_to :company
  has_many :punches

  def last_punch_date
    #(Time.at(self.last_time)).strftime("%b %-d %Y, %l:%M%p")
    time = self.last_time.to_i
  end
end
