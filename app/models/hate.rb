class Hate < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  
  after_create :post
  
  attr_accessible :user, :subject_name, :because
  validates_associated :user, :on => :create
  validates_associated :subject
  
  def subject_name=(subj)
    self.subject = Subject.find_or_create_by_name(subj)
  end
  
  def subject_name
    self.subject.try(:name)
  end
  
  def build_message
    "I just hate #{subject_name}" + ( because.blank? ? "" : " because #{because}" )
  end
  
private
  def post
    self.user.post(build_message)
  end
end
