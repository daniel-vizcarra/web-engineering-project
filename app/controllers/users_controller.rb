class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :check_user_permission, only: [:edit, :update, :destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    redirect_to new_user_registration_path
  end

  # GET /users/1/edit
  def edit
    redirect_to edit_user_registration_path
  end

  # POST /users or /users.json
  def create
    redirect_to new_user_registration_path
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Usuario actualizado correctamente." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    redirect_to edit_user_registration_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email)
    end

    def check_user_permission
      unless @user == current_user
        redirect_to users_path, alert: "No tienes permiso para realizar esta acción."
      end
    end
end
