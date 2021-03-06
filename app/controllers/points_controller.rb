
class PointsController < ApplicationController
  def create
    current_time = Time.zone.now

    if current_user
      @user = current_user
      # @data = File.open("/Users/apple/Downloads/export20170503-180101.csv","r")
      if params[:file]
        @data = params[:file].tempfile
      end
      total=0
      lines=0
      if @data
        @data.drop(1).each do |line| 
          x=line.split(';')
          if x[2].length != 0
            total+=x[2].to_i
            lines+=1
            time = ((x[0] + " " + x[1]).to_time)
            if @user.entries.length==0 || @user.entries[-1].created_at < current_time-24.hours
              if time+24.hours >= current_time
                Entry.create(bg: x[2], user_id: current_user.id, created_at: time)
              end 
            end
          end
        end 
        @a1c=total/lines
      end 
      @bgs = @user.entries.where(created_at: (current_time - 24.hours)..current_time)
      if @bgs.length != 0 
        @daychart = {}
        @daychart[:low]=@bgs.where("bg <= #{@user.blood_sugar_lower}").count
        @daychart[:med]=@bgs.where("bg > #{@user.blood_sugar_lower} and bg < #{@user.blood_sugar_upper}").count
        @daychart[:high]=@bgs.where("bg >= #{@user.blood_sugar_upper}").count
        point = Point.new(
          value: (@daychart[:med].to_f/@bgs.count)*10,
          user_id: current_user.id
          )

        if @user.points.length == 0 || @user.points[-1].created_at < current_time-24.hours
          point.save
          flash[:success] = 'Points Added Successfully'
          redirect_to "/users/#{current_user.id}"
        else
          flash[:warning] = 'Points Already Added Today or File Not Selected'
          redirect_to "/users/#{current_user.id}"
        end
      else
        flash[:warning] = 'Points Already Added Today or File Not Selected'
        redirect_to "/users/#{current_user.id}"
      end
    end
  end
end
