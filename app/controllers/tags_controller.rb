class TagsController < ApplicationController
  def index
    @tags = Snippet.all_tags(params[:tag])
    render :json => @tags.map{|t|t}.to_json
  end

end
