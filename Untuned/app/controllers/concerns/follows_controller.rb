class FollowsController < ApplicationController
    before_action :authenticate_user!

    def create1
        user = User.find_by(username: params[:username])
        Follow.create(followable: user, follower: current_user)
        redirect_to user_path(user.username), notice: "Successfully followed user"
    end

    def destroy1
        user = User.find_by(username: params[:username])
        Follow.find_by(followable: user, follower: current_user).destroy
        redirect_to user_path(user.username), notice: "Successfully unfollowed user"
    end

    def create2
        post = Post.find_by(id: params[:id])
        Follow.create(followable: post, follower: current_user)
        redirect_to post_path(params[:id]), notice: "Successfully followed this post"
    end

    def destroy2
        post = Post.find_by(id: params[:id])
        Follow.find_by(followable: post, follower: current_user).destroy
        redirect_to post_path(params[:id]), notice: "Successfully unfollowed this post"
    end
  end
  