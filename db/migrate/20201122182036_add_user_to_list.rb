class AddUserToList < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :list, foreign_key: true
  end
end
