class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :lastname
      t.string :firstname
      t.string :email
      t.references :schedule
      t.references :group

      t.timestamps
    end
    add_index :users, :schedule_id
    add_index :users, :group_id
  end
end
