class Subject < ActiveRecord::Base
  has_many :hates
  
  validates :name, :presence => true, :length => { :maximum => 255 }
  
  attr_accessible :name
end
