class LanguagesController < ApplicationController
  def index
    @snippets = Snippet.all_languages
    render :json => @snippets.to_json
  end
end
