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
    case format
    when 'html'
      content.html_safe
    when 'haml'
      Haml::Engine.new(content).to_html.html_safe
    else
      throw 'bad format'
    end
  end

  def convert_to_haml
    self.version = Version.convert_to_haml(self.version)
  end

  def content
    unless @content
      if version
        # there must be a blob
        @content = version.blob.value
        @format = version.format
      end
    end
    @content
  end

  def format
    unless @format
      if version
        # there must be a blob
        @content = version.blob.value
        @format = version.format
      end
    end
    @format
  end

  def content= value
    @content = value
  end

  def format= value
    @format = value
  end

  private

  def ensure_version
    if @content
      if version
        if @content != version.blob.value
          self.version = Version.new(:blob => Blob.get(@content), :previous => version, :format => format)
        end
      else
        self.version = Version.new(:blob => Blob.get(@content), :format => format)
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
