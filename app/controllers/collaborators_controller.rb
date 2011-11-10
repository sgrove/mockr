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

  def destroy
    user = User.find(params[:id])
    Bushido::User.remove(user.ido_id)
    flash[:notice] = "Access to #{user.name} has been revoked!"
    user.destroy
    redirect_to collaborators_path
  end

end
