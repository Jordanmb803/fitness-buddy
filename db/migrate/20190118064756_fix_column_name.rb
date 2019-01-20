class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :exercises, :jounal_entry_id, :journal_entry_id
  end
end
