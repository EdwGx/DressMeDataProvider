class CreateCombinations < ActiveRecord::Migration
  def change
    create_table :combinations do |t|
      t.integer :score, default: 100
      t.string :khash

      t.timestamps null: false
    end
  end
end
