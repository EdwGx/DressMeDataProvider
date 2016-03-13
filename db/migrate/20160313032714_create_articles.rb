class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :position
      t.string :name
      t.integer :score, default: 100

      t.integer :temp_max
      t.integer :temp_min

      t.timestamps null: false
    end
  end
end
