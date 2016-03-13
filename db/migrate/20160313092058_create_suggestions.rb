class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :response
      t.belongs_to :situation, index: true
      t.timestamps null: false
    end
  end
end
