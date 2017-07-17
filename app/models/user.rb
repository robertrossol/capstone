class User < ApplicationRecord
  has_secure_password
  has_many :entries
  has_many :points

  def total_points(user)
    total=0
    if user.points.length != 0
      user.points.each do |point|
        total+=point.value
      end
    end
    return total
  end

  def calc_level(user)
    @user = User.find_by(id: user.id)
    @level_up=10
    @temp_points=user.total_points(user)
    level=user.level
    (level-1).times do
      @level_up += @level_up
    end
    if @temp_points > @level_up
      while @temp_points >= @level_up
        level+=1
        @level_up+=@level_up
      end
    end
    @user.level=level
    @user.save
    level
  end

  def time_left
    hours_left=0
    @time_left=(Time.now.minus_with_coercion(@user.points[-1].created_at+24.hour))
    minutes_left=((@time_left/60).to_i*-1)
    if @time_left < 0
      while minutes_left>60
        hours_left+=1
        minutes_left-=60
      end
      hours_left.to_s + " hour(s) and " + minutes_left.to_s + " minutes left"
    else
      "Time to Enter Your Data!"
    end
  end


  def points_left
    @level_up-@user.total_points(@user)
  end

  def progress
    ((@user.total_points(@user).to_f/@level_up).to_f*100).to_i
  end

  def avgbg(time)
    total_bg = 0
    applicable_entries = @user.entries.where(created_at: (Time.zone.now - time.days)..Time.zone.now)
    applicable_entries.each do |entry|
      total_bg+= entry.bg
    end
    number = applicable_entries.length
    if number != 0
      total_bg/number
    else
      "N/A"
    end
  end

  def daysinrow
    position=-1
    consecutive_days=0
    while @user.points[position] && @user.points[position].created_at.day == Time.zone.now.day-consecutive_days 
      consecutive_days+=1
      position-=1
    end
    consecutive_days
  end

  def days_logged(user)
    @days_logged=0
    month=Time.zone.now.strftime("%m").to_i
    from_date = Date.new(2017, month, 1)
    to_date = Date.new(2017, month, Time.zone.now.strftime("%d").to_i)
    (from_date..to_date).each do |date|
      user.points.each do |entry|
        if entry.created_at.day == date.day && entry.created_at.month == date.month 
          @days_logged += 1 
        end 
      end 
    end
    @days_logged
  end
  
  def best_day(user)
    if user.points.length != 0
      entry = user.points.order('value desc')
      entry[0].value.to_s + "0%"
    end
  end


end
