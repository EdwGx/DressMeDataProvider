class CreateArticlesCombinations < ActiveRecord::Migration
  def change
    create_table :articles_combinations do |t|
        t.belongs_to :article, index: true
        t.belongs_to :combination, index: true
    end
  end
end
