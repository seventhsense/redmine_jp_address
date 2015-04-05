class CreateJpEMails < ActiveRecord::Migration
  def change
    create_table :jp_e_mails do |t|
      t.string :label
      t.string :mail_address
      t.integer :jp_person_id

      t.index :jp_person_id
    end
  end
end
