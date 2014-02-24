class Users::RegistrationsController < Devise::RegistrationsController

  def update
      # required for setting form to submit when password is left blank.
    if params[:user][:password].blank?
      params[:user].delete("passoword")
      params[:user].delete("passoword_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "devise/registrations/edit"
    end
  end
end