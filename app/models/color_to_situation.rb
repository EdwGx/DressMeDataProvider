class ColorToSituation < ActiveRecord::Base
  belongs_to :color
  belongs_to :situation
end
