class User < ActiveRecord::Base
  include Sluggable
  validates_presence_of :email, :display_name, :role
  validates :password, length: { minimum: 6 }, presence: true, on: :create
  validates :email, uniqueness: true
  has_many :posts

  has_secure_password
  sluggable_column :display_name

  scope :admin, -> { where role: 'admin'}
  scope :author, -> { where role: 'author'}
  scope :editor, -> { where role: 'editor'}
  scope :contributor, -> { where role: 'contributor'}

  def admin?
    role == "admin"
  end

  def author?
    role == "author"
  end

  def editor?
    role == "editor"
  end

  def contributor?
    role == "contributor"
  end
end
