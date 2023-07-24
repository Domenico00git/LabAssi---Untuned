class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post), notice: "Post was successfully created." 
    else
        render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post), notice: "Post was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed." 
  end

  private
    def post_params
      params.require(:post).permit(:content, :label)
    end
end
