class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates_presence_of :file_name
end
