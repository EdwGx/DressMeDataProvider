class Combination < ActiveRecord::Base
    has_and_belongs_to_many :articles
    before_save do
        unless self.articles.empty?
            self.khash = self.article_ids.sort.map(&:to_s).join("-")
        end
    end
end
