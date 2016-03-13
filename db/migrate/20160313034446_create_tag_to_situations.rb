class CreateTagToSituations < ActiveRecord::Migration
  def change
    create_table :tag_to_situations do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :situation, index: true
      t.integer :score, default: 100

      t.timestamps null: false
    end
  end
end
