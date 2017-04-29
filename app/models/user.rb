class User < ApplicationRecord
  has_secure_password
  has_many :entries
  has_many :points

  def total_points(user)
    total=0
    user.points.each do |point|
      total+=point.value
    end
    return total
  end

  def calc_level(user)
    @user = User.find_by(id: user.id)
    @level_up=10
    temp_points=user.total_points(user)
    level=user.level
    (level-1).times do
      @level_up += @level_up
    end
    if temp_points > @level_up
      while temp_points >= @level_up
        level+=1
        @level_up+=@level_up
      end
    end
    @user.level=level
    @user.save
    level
  end


  def points_left
    @level_up-@user.total_points(@user)
  end
end
