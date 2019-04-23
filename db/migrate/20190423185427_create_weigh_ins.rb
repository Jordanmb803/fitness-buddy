class CreateWeighIns < ActiveRecord::Migration
  def change
    create_table :weigh_ins do |t|
      t.belongs_to :user
      t.integer :weight_in_lbs
      t.date   :date

      t.timestamps null: false
    end
  end
end
