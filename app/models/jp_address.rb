class JpAddress < ActiveRecord::Base
  # unloadable
  attr_accessible :label, :zip_code, :todofuken, :address1, :address2, :building, :corporate
  belongs_to :jp_person
  validates :label, :zip_code, presence: true
end
