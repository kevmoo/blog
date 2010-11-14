class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content
  before_save :ensure_slug


  private

  def ensure_slug
    self.slug ||= Util.to_slug(self.title)
  end
end
