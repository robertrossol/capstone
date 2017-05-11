class UsersController < ApplicationController
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    now = Time.now
    #@data={}
    # @data = File.open("/Users/apple/Downloads/BgData/exportCSV20170501-192317.zip","r")
    


    low=@user.entries.where("bg < #{@user.blood_sugar_lower}").count
    med=@user.entries.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
    high=@user.entries.where("bg > #{@user.blood_sugar_upper}").count
    @bgs = @user.entries.where(created_at: (now - 24.hours)..Time.now)
    @chart = {}
    @daychart = {}
    @daychart[:low]=@bgs.where("bg <= #{@user.blood_sugar_lower}").count
    @daychart[:med]=@bgs.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
    @daychart[:high]=@bgs.where("bg >= #{@user.blood_sugar_upper}").count
    @chart[:low]=low
    @chart[:med]=med
    @chart[:high]=high
    if @user.entries.length != 0
      @total_bg = 0
      @user.entries.where(created_at: (Time.now - 30.days)..Time.now).each do |entry|
        @total_bg+= entry.bg
      end
      @number=@user.entries.length
      @avgbg = @total_bg/@number
      @a1c = (((46.7 + @avgbg) / 28.7).round(1))
    end
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
