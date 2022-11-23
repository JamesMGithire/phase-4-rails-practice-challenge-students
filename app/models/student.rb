class Student < ApplicationRecord
    belongs_to :instructor
    validates :name, presence: true
    validates :instructor_id, presence: true
    validate :age_range
    def age_range
        if age < 18
            errors.add(:age, "must be at least 18")
        end
    end
end
