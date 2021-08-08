class AddActivateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean,null:false,default: false
    add_column :users, :activation_token,:integer,null:false
  end
end
