class PostsController < ApplicationController
  respond_to :atom, :html, :xml, :json

  def index
    respond_with(@posts = Post.all)
  end

  def show
    respond_with(@post = Post.find(params[:id]))
  end

  def new
    # handle errors...
  end

  def new_scratch
    @post = Post.new
    @file_path = Scratch.haml_path
  end

  def create
    @post = Post.new(params[:space])

    content = ''

    File.open(Scratch.haml_path, mode = 'r') do |file|
      content = file.read
      content = Haml::Engine.new(content).render
    end

    @post.content = content
    @post.save!

    redirect_to :root

  end

  def scratch
    render :file => Scratch.haml_path
  end

end