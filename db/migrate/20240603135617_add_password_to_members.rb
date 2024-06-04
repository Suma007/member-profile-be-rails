class AddPasswordToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :password, :string
  end
end
