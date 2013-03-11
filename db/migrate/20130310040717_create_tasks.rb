class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :project_id
      t.string :name
      t.boolean--skip-migration :completed

      t.timestamps
    end
  end
end
