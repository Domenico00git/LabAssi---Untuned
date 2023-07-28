class TopicsController < ApplicationController

  def index
    @topics = topics
  end

  def topics
    query = Post.ransack(label_cont: search_query)
    @topics = query.result(distince: true)
  end

  def search_query
    params[:query]
  end

end
