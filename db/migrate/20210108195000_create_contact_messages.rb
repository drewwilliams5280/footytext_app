class CreateContactMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_messages do |t|
      t.string :text
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
