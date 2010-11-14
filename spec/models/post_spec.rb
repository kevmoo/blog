require 'spec_helper'

describe Post do
  describe "for a new post" do
    it 'fails validation on no title' do
      Post.new.should have(1).error_on(:title)
    end

    it 'fails validation on no content' do
      Post.new.should have(1).error_on(:content)
    end

    it 'fails whe trying to save an empty post' do
      Post.new.save.should be_false
    end

    it "should create a slug and save correctly" do
      post = Post.new(:title => 'This is a new day @ our house!', :content => 'bar')
      
      post.save.should be_true
    end
  end
end
