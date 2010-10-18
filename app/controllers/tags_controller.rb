class TagsController < ApplicationController
  def index
    @tags = Tag.where(["description like ?","#{params[:tag]}%"])
    render :json => @tags.map{|t|t.description}.to_json
  end

end
