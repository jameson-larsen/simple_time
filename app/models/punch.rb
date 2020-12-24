class Punch < ApplicationRecord
    belongs_to :user

    validates_presence_of :in
    validates_presence_of :out
    validate :start_before_end

    def start_before_end
        if self.in.present? && self.out.present? && self.out.to_time < self.in.to_time
            errors.add(:out, "must be after in!")
        end
    end
end