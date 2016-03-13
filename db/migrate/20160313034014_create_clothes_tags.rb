class CreateClothesTags < ActiveRecord::Migration
  def change
    create_table :clothes_tags do |t|
        t.belongs_to :clothe, index: true
        t.belongs_to :tag, index: true
    end
  end
end
