class JpPerson < ActiveRecord::Base
  # unloadable
  attr_accessible :name, :kana, :is_corporate, :katagaki, :keishou, 
    :represent, :represent_katagaki, :memo,
    :jp_addresses_attributes, :jp_e_mails_attributes, :jp_phone_numbers_attributes,
    :projects_jp_people_attributes

  # relationship
  has_many :jp_addresses
  accepts_nested_attributes_for :jp_addresses, allow_destroy: true
  has_many :jp_e_mails
  accepts_nested_attributes_for :jp_e_mails, allow_destroy: true
  has_many :jp_phone_numbers
  accepts_nested_attributes_for :jp_phone_numbers, allow_destroy: true
  has_many :projects_jp_people
  has_many :projects, through: :projects_jp_people
  accepts_nested_attributes_for :projects_jp_people, allow_destroy: true

  # validation
  validates :name, presence: true 
  validates :kana, :format => {:with => /\A[\p{hiragana}ー－ ]+\z/, :message =>'はひらがなで入力して下さい。', allow_blank: true}
  before_validation do
    self.name.gsub!('　', ' ')
    unless self.kana == nil
      self.kana.gsub!('　', ' ')
    end
  end

  #scope
  def self.search(q)
    where('jp_people.name LIKE :q OR jp_people.kana LIKE :q', q: "%#{q}%")
  end

  def self.phone_search(q)
    joins(:jp_phone_numbers)
      .where('jp_phone_numbers.number LIKE :q', q: "%#{q}%")
  end

  def self.mail_search(q)
    joins(:jp_e_mails)
      .where('jp_e_mails.mail_address LIKE :q', q: "%#{q}%")
  end

  def self.tel_and_mail_search(q)
      joins(:jp_e_mails, :jp_phone_numbers)
        .where('jp_e_mails.mail_address LIKE :q OR jp_phone_numbers.number LIKE :q', q: "%#{q}%")
  end

  def self.search_by_project_id(project)
    if project
      includes(:projects).where('projects.id' => project.id)
    else
      where(nil)
    end
  end

  # scope :search_by_project_id ,
    # -> (project_id){includes(:projects).where('projects.id' => project_id)}
end
