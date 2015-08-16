class Post < ActiveRecord::Base
  include Sluggable

  validates_presence_of :title, :body
  belongs_to :user

  scope :published, -> { where status: 'published'}
  scope :draft, -> { where status: 'draft'}

  sluggable_column :title

  def published?
    self.status == 'published'
  end
end
