class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      t.integer :message_id, index: true
      t.integer :user_id, index: true
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
