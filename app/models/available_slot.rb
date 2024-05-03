class AvailableSlot < ActiveRecord::Base
  belongs_to :festival
  belongs_to :love_pod
end
