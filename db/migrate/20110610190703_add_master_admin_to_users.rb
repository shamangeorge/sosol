class AddMasterAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_master_admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_master_admin
  end
end