class CombinationToSituation < ActiveRecord::Base
  belongs_to :combination
  belongs_to :situation
end
