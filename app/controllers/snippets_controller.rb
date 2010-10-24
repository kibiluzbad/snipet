class SnippetsController < ApplicationController
  before_filter :load_snippet, :only => [:update,:edit]
  before_filter :authenticate_user!, :except => [:index]
  
  # Get /snippets
  def index
    @snippets = Snippet.all
  end
  
  # Get /snippets/mine
  def mine
    @snippets = Snippet.where(:user_id => current_user.id)
    render :action => "index"
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
      redirect_to snippets_path, :notice=>t(:snippet_created_notice)
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
      redirect_to snippets_path, :notice=>t(:snippet_edited_notice)
    else
      render :action => "edit"
    end
  end
  
  # Delete /snippets/[:id]
  def destroy
    @snippet = Snippet.find(params[:id])
    @snippet.destroy
    
    redirect_to snippets_url, :notice=>t(:snippet_deleted_notice)
  end
  
  private
  def load_snippet
    @snippet = Snippet.find(params[:id])
    render :file => "public/401.html", :status => :unauthorized and return unless @snippet.user_id == current_user.id
  end

end
