class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :song
      t.string :artist

      t.timestamps
    end
  end
end
