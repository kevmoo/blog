class Post < ActiveRecord::Base
  validates :title, :length => {:minimum => 1, :maximum => 100}
  validates :content, :length => {:minimum => 1}
  validates :slug, :length => {:minimum => 1}, :uniqueness => true
  before_validation :ensure_slug

  default_scope limit(10).order('created_at DESC')
  scope :month, lambda { |year, month| where('created_at >= ?', Time.utc(year, month)).where('created_at <= ?' , Time.utc(year, month).end_of_month) }
  scope :year, lambda { |year| where('created_at >= ?', Time.utc(year)).where('created_at <= ?' , Time.utc(year).end_of_year) }

  def get_options
    if persisted?
      {:year => created_at.year, :month => created_at.month, :slug => slug}
    else
      {:id => id}
    end
  end

  def to_html
    Haml::Engine.new(content).render
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
