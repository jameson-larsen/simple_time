class TimeOffRequest < ApplicationRecord
    enum status: [:pending, :denied, :accepted]
    belongs_to :user

    validates_presence_of :start
    validates_presence_of :end
    validate :start_before_end

    def start_before_end
        if self.start.present? && self.end.present? && self.end.to_time < self.start.to_time
            errors.add(:end, "must be after start!")
        end
    end
end
