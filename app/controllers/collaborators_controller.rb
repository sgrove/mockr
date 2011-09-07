class CollaboratorsController < ApplicationController
  def create
    begin
      Bushido::User.invite(params[:email])
    rescue => ex
      flash[:notice] = "That user could not be added."
    end
    redirect_to collaborators_path
  end

  def index
    @users = User.all
  end

  def remove_user
    # TODO call Bushido::User.remove_user    
  end

end
