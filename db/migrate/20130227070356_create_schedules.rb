class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :username
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday

      t.timestamps
    end
  end
end
