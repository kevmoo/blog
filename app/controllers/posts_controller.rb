class PostsController < ApplicationController
  respond_to :atom, :html, :xml, :json

  def index
    respond_with(@posts = Post.all)
  end

  def show
    respond_with(@post = Post.find(params[:id]))
  end

  def new_scratch
    @file_path = Scratch.haml_path
  end

  def scratch
    render :file => Scratch.haml_path
  end

end