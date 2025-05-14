class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
           has_one_attached :business_verification_document
           
  
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
  end
  