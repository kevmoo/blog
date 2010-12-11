class Post < ActiveRecord::Base
  validates :title, :length => {:minimum => 1, :maximum => 100}, :allow_nil => true
  validates :slug, :length => {:minimum => 1, :maximum => 100}, :uniqueness => true, :allow_nil => true
  validates :version, :presence => true
  before_validation :ensure_slug, :ensure_version
  belongs_to :version

  default_scope includes([:version => :blob])
  scope :active, limit(10).order('created_at DESC')
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
    content.html_safe
  end

  def content
    unless @content
      if version
        # there must be a blob
        @content = version.blob.value
      end
    end
    @content
  end

  def content= value
    @content = value
  end

  private

  def ensure_version
    if @content
      if version
        if @content != version.blob.value
          self.version = Version.new(:blob => Blob.get(@content), :previous => version)
        end
      else
        self.version = Version.new(:blob => Blob.get(@content))
      end
    end
  end

  def ensure_slug
    unless self.slug
      if self.title
        self.slug = self.title.to_identifier.normalize!(:separator => '_')
      end
    end
  end
end
