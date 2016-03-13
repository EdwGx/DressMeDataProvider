class CreateClothesSuggestions < ActiveRecord::Migration
  def change
    create_table :clothes_suggestions do |t|
        t.belongs_to :clothe, index: true
        t.belongs_to :suggestion, index: true
    end
  end
end
