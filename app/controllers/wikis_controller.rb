class WikisController < ApplicationController
  def index
  	@wikis = current_user.wikis
    #@wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
  	@wiki = Wiki.new
    authorize @wiki
  end

  def create
  	@wiki = Wiki.new(wiki_params)
  	@wiki.user = current_user
  	if @wiki.save
      redirect_to root_path, notice: "Wiki was saved"
    else
      flash[:alert] = "There was an error with your request"
      render :new
    end
  end

  def edit
  	@wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
  	@wiki = Wiki.find(params[:id])
    authorize @wiki

  	if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was successfully updated"
      redirect_to root_path, notice: "Wiki was updated"
    else
      flash.now[:alert] = "There was an error updated your wiki"
      render :edit
    end
  end


  def destroy
  	@wiki = Wiki.find(params[:id])

  	if @wiki.destroy
  	  flash[:notice] = "Wiki was deleted"
    else
      flash.now[:alert] = "There was an error with your request"
    end
    redirect_to wikis_path	
  end

  private

  def wiki_params
  	params.require(:wiki).permit(:title, :body)
  end
end
