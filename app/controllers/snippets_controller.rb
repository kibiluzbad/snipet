class SnippetsController < ApplicationController
  before_filter :load_snippet, :only => [:update,:edit]
  before_filter :authenticate_user!, :except => [:index]
  
  # Get /snippets
  def index
    @snippets = Snippet.all
  end

  # Get /snippets/new
  def new
    @snippet = Snippet.new
  end
  
  # Post /snippets
  def create
    @snippet = Snippet.new(params[:snippet])
    @snippet.user = current_user
    
    if(@snippet.save())
      redirect_to snippets_path, :notice=>"Snippet criado com sucesso!"
    else
      render :action => "new"
    end
  end
  
  # Get /snippets/[:id]/edit
  def edit

  end

  # Put /snippets/[:id]  
  def update
    if(@snippet.update_attributes(params[:snippet]))    
      redirect_to snippets_path, :notice=>"Snippet alterado com sucesso!"
    else
      render :action => "edit"
    end
  end
  
  # Delete /snippets/[:id]
  def destroy
    @snippet = Snippet.find(params[:id])
    @snippet.destroy
    
    redirect_to snippets_url, :notice=>"Snippet excluido com sucesso!"
  end
  
  private
  def load_snippet
    @snippet = Snippet.find(params[:id])
    render :file => "public/401.html", :status => :unauthorized and return unless @snippet.user_id == current_user.id
  end

end
