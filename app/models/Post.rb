class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning

  field :title
  field :content
  field :posted_at, :type => Date
  field :is_draft, :type => Boolean

  index :posted_at
  index :title
end
