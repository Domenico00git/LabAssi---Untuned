class VotesController < ApplicationController
    before_action :authenticate_user!

    def createlike
        post = Post.find(params[:id])
        post.liked_by current_user
        redirect_back_or_to root_path, notice: "You successfully liked a post"
    end

    def destroylike
        post = Post.find(params[:id])
        post.unliked_by current_user
        redirect_back_or_to root_path, notice: "You successfully unliked a post"
    end

    def createdislike
        post = Post.find(params[:id])
        post.disliked_by current_user
        redirect_back_or_to root_path, notice: "You successfully disliked a post"
    end

    def destroydislike
        post = Post.find(params[:id])
        post.undisliked_by current_user
        redirect_back_or_to root_path, notice: "You successfully undisliked a post"
    end
  end
  