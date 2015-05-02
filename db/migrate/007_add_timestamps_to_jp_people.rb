class AddTimestampsToJpPeople < ActiveRecord::Migration
  def change
    add_timestamps(:jp_people)
  end
end
