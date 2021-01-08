class AddAttributesToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :carrier, :string
    add_column :contacts, :line_type, :string
  end
end
