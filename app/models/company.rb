require 'digest'
class Company < ApplicationRecord
    before_create :generate_registration_token

    has_many :users, dependent: :destroy

    def generate_registration_token
        self.registration_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
 
end
