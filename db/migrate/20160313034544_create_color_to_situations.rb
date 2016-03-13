class CreateColorToSituations < ActiveRecord::Migration
  def change
    create_table :color_to_situations do |t|
      t.belongs_to :color, index: true
      t.belongs_to :situation, index: true
      t.integer :score, default: 100

      t.timestamps null: false
    end
  end
end
