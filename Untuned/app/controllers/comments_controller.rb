class CommentsController < ApplicationController
    
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
        @comment = current_user.comments.find(params[:id])
        @comment.destoy
        redirect_to post_path(params[:post_id]), notice: "comment was successfully destroyed."
    end

    private
    def comment_params
        params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    end
end
