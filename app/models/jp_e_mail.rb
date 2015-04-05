class JpEMail < ActiveRecord::Base
  # unloadable
  attr_accessible :label, :mail_address
  belongs_to :jp_person
  validates :label, :mail_address, presence: true
end
