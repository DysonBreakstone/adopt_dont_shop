class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :status, presence: true


  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def update_status
    if pet_applications.pluck(:condition).all? { |condition| condition == "Approved" }
      self.update(status: "Approved")
      self.save
      pet_applications.map do |pet_app|
        pet_app.pet.pet_adopted
      end
    elsif
      pet_applications.pluck(:condition).include?("Pending") == true
    else
      pet_applications.pluck(:condition).any? { |condition| condition == "Denied" } 
      self.update(status: "Rejected")
      self.save
    end
  end

  def find_pet_apps
    pet_apps = PetApplication.where("application_id = #{self.id}")
  end
end

