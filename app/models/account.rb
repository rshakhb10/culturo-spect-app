class Account < ActiveRecord::Base

	geocoded_by :zipcode
	after_validation :geocode, :if => :zipcode_changed?
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :date_of_birth, presence: true
	validates :city, presence: true
	validates :country, presence: true
	validates :zipcode, presence: true, numericality: { only_integer: true}
    validates_inclusion_of :new_arrival, in: [true, false]
	validates :story, length: { minimum: 100, 
		too_short: ": Tell about yourself in at least %{count} characters."},
		presence: true 
	belongs_to :user


    def age
    	now = Time.now.utc.to_date
    	now.year - self.date_of_birth.year - ((now.month > self.date_of_birth.month || (now.month == self.date_of_birth.month && now.day >= self.date_of_birth.day)) ? 0 : 1)
    end

end
