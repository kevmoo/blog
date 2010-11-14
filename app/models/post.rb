class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content
  before_save :ensure_slug


  def get_options
    if persisted?
      {:year => created_at.year.to_s, :month => "%02d" % created_at.month, :slug => slug}
    else
      {:id => id}
    end
  end


  private

  def ensure_slug
    self.slug ||= self.title.to_identifier.normalize!(:separator => '_')
  end
end
