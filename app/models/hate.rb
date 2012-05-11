class Hate < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  
  after_create :post
  
  attr_accessible :user, :subject_name, :because
  validates_associated :user, :on => :create
  validates_associated :subject
  
  scope :last, lambda { |cnt|
    order('created_at desc').limit(cnt.to_i)
  }
  
  def subject_name=(subj)
    self.subject = Subject.find_or_create_by_name(subj)
  end
  
  def subject_name
    self.subject.try(:name)
  end
  
  def user_name
    self.user.try(:name)
  end
  
  def build_message
    "I just hate #{subject_name}" + ( because.blank? ? "" : " because #{because}" )
  end
  
private
  def post
    self.user.post(build_message)
  end
end
