class CommentsController < ApplicationController
    
    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save 
            redirect_to posts_path(params[:post_id]), notice: "comment was successfully created"
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    end
end
