require 'atom'

class PostsController < ApplicationController
  def index
    @posts = Post.active
    if params[:year] && params[:month]
      @posts = @posts.month(params[:year].to_i, params[:month].to_i)
    elsif params[:year]
      @posts = @posts.year(params[:year].to_i)
    end

    @posts = @posts.all
  end

  def show
    if params[:id]
      @post = Post.find(params[:id])
    else
      @post = Post.month(params[:year].to_i, params[:month].to_i).find_by_slug(params[:slug])
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to(posts_url)
  end

  def atom
    feed = Atom::Feed.new do |f|
      #f.title = "Example Feed"
      #f.links << Atom::Link.new(:href => "http://example.org/")
      #f.updated = Time.parse('2003-12-13T18:30:02Z')
      #f.authors << Atom::Person.new(:name => 'Kevin Moore')
      #f.id = "urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6"
      Post.active.each do |post|
        f.entries << Atom::Entry.new do |e|
          e.title = post.title
          #e.links << Atom::Link.new(:href => "http://example.org/2003/12/13/atom03")
          #e.id = "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a"
          #e.updated = Time.parse('2003-12-13T18:30:02Z')
          #e.summary = "Some text."
        end
      end
    end
    render :xml => feed.to_xml, :content_type => 'application/atom+xml'
  end
end
