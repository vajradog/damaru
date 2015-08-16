class Page < ActiveRecord::Base
  include Sluggable

  validates :title, presence: true
  validate :check_url_or_body

  #status
  scope :published, -> { where status: 'published'}
  scope :draft, -> { where status: 'draft'}

  #navigation
  scope :header, -> { where nav: 'header'}
  scope :footer, -> { where nav: 'footer'}
  scope :menu_undefined, -> { where nav: 'none'}

  sluggable_column :title

  def published?
    self.status == 'published'
  end

  private

  def check_url_or_body
    if external_url.blank? && body.blank?
      errors[:base] << "Specify external_url or body"
    end
  end
end
