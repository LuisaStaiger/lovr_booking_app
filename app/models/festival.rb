class Festival < ApplicationRecord
  has_many :festival_love_pods
  has_many :love_pods, through: :festival_love_pods
end
