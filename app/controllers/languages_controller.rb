class LanguagesController < ApplicationController
  def index
    @snippets = Snippet.select("DISTINCT language").where(["language like ?","#{params[:q]}%"])
    render :json => @snippets.map{|s| s.language}.to_json
  end
end
