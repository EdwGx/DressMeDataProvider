class TagToSituation < ActiveRecord::Base
  belongs_to :tag
  belongs_to :situation
end
