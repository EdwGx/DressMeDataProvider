class CreateClothes < ActiveRecord::Migration
  def change
    create_table :clothes do |t|
      t.belongs_to :article, index: true
      t.belongs_to :color, index: true
      t.string :raw_description
      t.integer :score, default: 100
      t.integer :position

      t.timestamps null: false
    end
  end
end
