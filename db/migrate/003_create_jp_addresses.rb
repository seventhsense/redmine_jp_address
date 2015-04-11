class CreateJpAddresses < ActiveRecord::Migration
  def change
    create_table :jp_addresses do |t|
      t.string :label
      t.string :zip_code
      t.string :todofuken
      t.string :address1
      t.string :address2
      t.string :building
      t.string :corporate
      t.integer :jp_person_id

      t.index :jp_person_id
    end
  end
end
