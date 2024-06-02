class AddPasswordToMember < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :password_digest, :string
  end
end
