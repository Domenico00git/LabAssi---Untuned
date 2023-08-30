class VotesCommentController < ApplicationController
    before_action :authenticate_user!

    def createlike
        comment = Comment.find(params[:id])
        comment.liked_by current_user
        redirect_to post_path(comment.post_id), notice: "You successfully liked a comment"
    end

    def destroylike
        comment = Comment.find(params[:id])
        comment.unliked_by current_user
        redirect_to post_path(comment.post_id), notice: "You successfully unliked a comment"
    end

    def createdislike
        comment = Comment.find(params[:id])
        comment.disliked_by current_user
        redirect_to post_path(comment.post_id), notice: "You successfully disliked a comment"
    end

    def destroydislike
        comment = Comment.find(params[:id])
        comment.undisliked_by current_user
        redirect_to post_path(comment.post_id), notice: "You successfully undisliked a comment"
    end
  end
  