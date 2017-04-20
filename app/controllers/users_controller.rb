class UsersController < ApplicationController
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    low=@user.entries.where("bg < #{@user.blood_sugar_lower}").count
    med=@user.entries.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
    high=@user.entries.where("bg > #{@user.blood_sugar_upper}").count
    @chart = {}
    @chart[:low]=low
    @chart[:med]=med
    @chart[:high]=high
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      device_id: params[:device_id],
      blood_sugar_lower: params[:blood_sugar_lower],
      blood_sugar_upper: params[:blood_sugar_upper]
    )
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end

end
