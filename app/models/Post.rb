class Post
  include Mongoid::Document  
  include Mongoid::Versioning  
  
  field :title  
  field :content  
end
