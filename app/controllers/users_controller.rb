class UsersController < ApplicationController
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    now = Time.zone.now
    #@data={}
    # @data = File.open("/Users/apple/Downloads/BgData/exportCSV20170501-192317.zip","r")

    low=@user.entries.where("bg < #{@user.blood_sugar_lower}").count
    med=@user.entries.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
    high=@user.entries.where("bg > #{@user.blood_sugar_upper}").count
    @bgs = @user.entries.where(created_at: (now - 24.hours)..Time.zone.now)
    @most_recent = @user.entries.where(created_at: (@user.entries[-1].created_at - 24.hours)..@user.entries[-1].created_at)
    @daily_chart_data=Hash[(@most_recent.map(&:created_at)).zip @most_recent.map(&:bg)]
    @all_time_data=Hash[(@user.entries.map(&:created_at)).zip @user.entries.map(&:bg)]
    @chart = {}
    @daychart = {}
    @daychart[:low]=@most_recent.where("bg <= #{@user.blood_sugar_lower}").count
    @daychart[:med]=@most_recent.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
    @daychart[:high]=@most_recent.where("bg >= #{@user.blood_sugar_upper}").count
    @chart[:low]=low
    @chart[:med]=med
    @chart[:high]=high
    if @user.entries.length != 0
      @total_bg = 0
      # @user.entries.where(created_at: (Time.zone.now - 30.days)..Time.zone.now).each do |entry|
      @user.entries.each do |entry|
        @total_bg+= entry.bg
      end
      # @number=@user.entries.where(created_at: (Time.zone.now - 30.days)..Time.zone.now).length
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
      render '/first_time.html.erb'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(
    icon: params[:form_icon] || @user.icon,
    background: params[:form_background] || @user.background
    )
      redirect_to "/users/#{@user.id}"
    end
  end
  def spend
    @user = User.find_by(id: params[:id])
    render "spend.html.erb"
  end
  def index
    @user=User.find_by(id: current_user.id)
    render "index.html.erb"
  end
end
