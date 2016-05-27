class CollaborationsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
  	@collaboration = @wiki.collaborations.build(user_id: @user.id)
  	if @collaboration.save
      redirect_to root_path, notice: "Collaborator added"
    else
      flash[:alert] = "There was an error with your request"
      render :new
    end
  end


    def destroy
      @collaboration = Collaboration.find_by(wiki_id: params[:wiki_id], user_id: params[:user_id])

      if @collaboration.destroy
  	    flash[:notice] = "Collaboratoion was deleted"
      else
        flash.now[:alert] = "There was an error with your request"
      end
      redirect_to :back
    end	
end
