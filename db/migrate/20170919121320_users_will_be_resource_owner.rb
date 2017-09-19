class UsersWillBeResourceOwner < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :resource_owner_id, :integer
    add_foreign_key :oauth_access_grants, :users, column: :resource_owner_id
    add_foreign_key :oauth_access_tokens, :users, column: :resource_owner_id
  end
end
