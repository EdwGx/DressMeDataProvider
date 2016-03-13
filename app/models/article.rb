class Article < ActiveRecord::Base
    has_many :clothes
    has_and_belongs_to_many :combinations
end
