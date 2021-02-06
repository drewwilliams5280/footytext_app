class AddSmsIdToContactMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_messages, :sms_id, :string
  end
end
