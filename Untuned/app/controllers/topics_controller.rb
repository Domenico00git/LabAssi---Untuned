class TopicsController < ApplicationController

  def index
    @topics = topics
  end

  def topics
    query1 = Post.ransack(label_cont: search_query)
    query2 = Post.ransack(content_cont: search_query)
    @topics = (query1.result(distince: true) + query2.result(distince: true)).uniq

  end

  def search_query
    params[:query]
  end

end
