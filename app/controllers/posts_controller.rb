class PostsController < ApplicationController
  respond_to :atom, :html, :xml, :json

  def index
    respond_with(@posts = Post.all)
  end

  def show
    respond_with(@post = Post.find(params[:id]))
  end

  def new_scratch
  end

  def scratch
    # make sure there is a scratch.haml file, right?
    render :file => File.join(Rails.root, 'tmp', 'scratch', 'scratch.haml')
  end

end