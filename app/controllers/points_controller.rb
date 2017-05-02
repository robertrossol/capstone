
class PointsController < ApplicationController
  def create
    if current_user
      @user = current_user
      @data = File.open("/Users/apple/Downloads/BgData/export20170501-192317.csv","r")
      if @data
        @data.drop(1).each do |line|   
          x=line.split(';') 
          time = ((x[0] + " " + x[1]).to_time)
          if @user.entries[-1].created_at < Time.now-24.hours 
            entry=Entry.new(bg: x[2], user_id: current_user.id, created_at: time)
            if time+24.hours >= Time.now
              entry.save 
            end 
          end
        end 
      end 
      @bgs = @user.entries.where(created_at: (Time.now - 24.hours)..Time.now)
      @daychart = {}
      @daychart[:low]=@bgs.where("bg <= #{@user.blood_sugar_lower}").count
      @daychart[:med]=@bgs.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
      @daychart[:high]=@bgs.where("bg >= #{@user.blood_sugar_upper}").count
      point = Point.new(
        value: (@daychart[:med].to_f/@bgs.count)*10,
        user_id: current_user.id
        )
      if @user.points.length == 0 || @user.points[-1].created_at < Time.now-24.hours
        point.save
        flash[:success] = 'Points Added Successfully'
        redirect_to "/users/#{current_user.id}"
      else
        flash[:warning] = 'Points Already Added Today'
        redirect_to "/users/#{current_user.id}"
      end
    end
  end
end
