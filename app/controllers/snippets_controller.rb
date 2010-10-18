class SnippetsController < ApplicationController
  # Get /snippets
  def index
    @snippets = Snippet.all(:include => [:tags])
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
    @snippet = Snippet.find_by_id_and_user_id(params[:id],current_user.id)
  end

  # Put /snippets/[:id]  
  def update
    @snippet = Snippet.find_by_id_and_user_id(params[:id],current_user.id)
    
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

end
