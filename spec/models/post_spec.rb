require 'spec_helper'

describe Post do
  describe "for a new post" do
    it 'fails validation when empty' do
      post = Post.new
      post.should have(1).error_on(:content)
      post.should have(1).error_on(:title)
      post.should have(1).error_on(:slug)

      post = Post.new(:title => '', :content => '', :slug => '')
      post.should have(1).error_on(:content)
      post.should have(1).error_on(:title)
      post.should have(1).error_on(:slug)
    end

    it 'fails whe trying to save an empty post' do
      Post.new.save.should be_false
    end

    it "should create a slug and save correctly" do
      post = Post.new(:title => 'This is a new day @ our house!', :content => 'bar')
      
      post.save!
      
      post.save.should be_true
      post.slug.should_not be_nil
    end
  end
end
