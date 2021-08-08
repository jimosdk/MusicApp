class RemoveActivationTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users,:activation_token
  end
end
