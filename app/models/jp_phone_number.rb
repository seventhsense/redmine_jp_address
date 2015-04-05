class JpPhoneNumber < ActiveRecord::Base
  # unloadable
  attr_accessible :label, :number
  belongs_to :jp_person
  validates :label, :number, presence: true
end
