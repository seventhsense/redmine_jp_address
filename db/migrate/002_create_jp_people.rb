class CreateJpPeople < ActiveRecord::Migration
  def change
    create_table :jp_people do |t|
      t.string :name
      t.string :kana
      t.string :katagaki
      t.string :keishou
      t.boolean :is_corporate
      t.string :represent
      t.string :represent_katagaki
      t.text :memo
    end
  end
end
