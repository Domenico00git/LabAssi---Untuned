class CommentsController < ApplicationController

    before_action :set_post, only: [:destroy, :update, :edit]
    before_action :set_comment, only: [:destroy, :update, :edit]
    
    def index
        @comments = Comment.all
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save 
            redirect_to post_path(params[:post_id]), notice: "comment was successfully created."
        end
    end

    def destroy
        @comment.destroy
        redirect_to post_path(params[:post_id]), notice: "comment was successfully destroyed."
    end

    def edit
    end

    def update
        if @comment.update(comment_params)
            redirect_to post_path(params[:post_id]), notice: "comment was successfully updated"
            
        else
            render :edit
        end
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_comment
        @comment = @post.comments.find(params[:id])

    end

    private
    def comment_params
        params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    end
end
