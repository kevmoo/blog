require 'spec_helper'

describe Post do
  describe "for a new post" do
    it 'fails validation when empty' do
      post = Post.new
      post.should have(1).error_on(:version)
      post.should have(0).error_on(:title)
      post.should have(0).error_on(:slug)

      post = Post.new(:title => '', :slug => '')
      post.should have(1).error_on(:version)
      post.should have(1).error_on(:title)
      post.should have(1).error_on(:slug)
    end

    it 'fails when trying to save an empty post' do
      Post.new.save.should be_false
    end

    it "should create a slug and save correctly" do
      v = Version.create(:blob => Blob.get('dude'))
      post = Post.new(:title => 'This is a new day @ our house!', :version => v)
      
      post.save!
      
      post.save.should be_true
      post.slug.should_not be_nil
    end

    it "should allow direct creation of content" do
      content = "foo"

      post = Post.new(:title => 'foo')
      post.content = content
      post.save!

      post.content.should eq(content)
      post.version.should_not be_nil
      last_version = post.version
      post.version.previous.should be_nil
      post.version.blob.value.should eq(content)

      content2 = "bar"
      post.content = content2
      post.save!

      post.content.should eq(content2)
      post.version.previous.should_not be_nil
      post.version.previous.should eq(last_version)
      post.version.blob.value.should eq(content2)
    end
  end
end
