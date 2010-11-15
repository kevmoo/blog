class Post < ActiveRecord::Base
  validates :title, :length => {:minimum => 1, :maximum => 100}
  validates :content, :length => {:minimum => 1}
  validates :slug, :length => {:minimum => 1}
  before_validation :ensure_slug

  def get_options
    if persisted?
      {:year => created_at.year.to_s, :month => "%02d" % created_at.month, :slug => slug}
    else
      {:id => id}
    end
  end


  private

  def ensure_slug
    unless self.slug
      if self.title
        self.slug = self.title.to_identifier.normalize!(:separator => '_')
      end
    end
  end
end
