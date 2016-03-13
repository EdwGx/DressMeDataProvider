class ArticleToSituation < ActiveRecord::Base
  belongs_to :article
  belongs_to :situation
end
