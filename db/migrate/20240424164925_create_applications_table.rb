class CreateApplicationsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :access_token

      t.timestamps
    end
    add_index :applications, :access_token, unique: true
  end
end
