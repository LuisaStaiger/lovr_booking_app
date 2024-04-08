class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :love_pod
end
