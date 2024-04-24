class CreateMessagesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true, null: false
      t.integer :number
      t.text :body
      t.timestamps
    end
  end
end