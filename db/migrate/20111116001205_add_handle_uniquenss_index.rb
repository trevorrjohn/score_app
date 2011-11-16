class AddHandleUniquenssIndex < ActiveRecord::Migration
  def up
    add_index :users, :handle, :unique => true
  end

  def down
    remove_index :users, :handle
  end
end
