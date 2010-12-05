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
end
