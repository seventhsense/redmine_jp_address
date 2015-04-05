class CreateJpPhoneNumbers < ActiveRecord::Migration
  def change
    create_table :jp_phone_numbers do |t|
      t.string :label
      t.string :number
      t.integer :jp_person_id

      t.index :jp_person_id
    end
  end
end
