class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
      t.integer :score, default: 100

      t.timestamps null: false
    end
  end
end
