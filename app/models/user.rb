class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    has_one_attached :business_verification_document
           
    def self.ransackable_associations(auth_object = nil)
      [
        "business_verification_document_attachment",
        "business_verification_document_blob",
        "businesses",
        "impressions",
        "reviews"
      ]
    end

    def self.ransackable_attributes(auth_object = nil)
      %w[
        id
        email
        role
        username
        home_location_cont
        home_location_eq
        home_location_start
        home_location_end
        business_verified
        created_at
        updated_at
        reset_password_token
        reset_password_sent_at
        remember_created_at
        encrypted_password
        # Add any other Devise or user fields you want searchable/filterable
      ]
    end
    
  
    has_many :businesses, dependent: :destroy
    has_many :impressions, dependent: :destroy
    has_many :reviews, dependent: :destroy
  
    def business?
      role == "business"
    end
  
    def viewer?
      role == "viewer"
    end

    after_initialize :set_default_role, if: :new_record?

    def set_default_role
      self.role ||= 'viewer'
    end
  
    def business_verified?
      self[:business_verified] # or read_attribute(:business_verified)
    end
  
    def verified_business?
      business? && business_verified?
    end

    after_update :create_business_if_verified

  private

  def create_business_if_verified
    # Only run if user is now a verified business, and didn't used to be,
    # and doesn't already have a business record
    if saved_change_to_business_verified? && business_verified? && role == "business" && businesses.empty?
      businesses.create!(name: "#{email}'s Business")
    end
  end
  
end
  