class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates_presence_of :file_name
end
