class EntriesController < ApplicationController
  def create
    entry = Entry.new(
      bg: params[:bg],
      user_id: current_user.id
      )
    if entry.save
      flash[:success] = 'BG Added Successfully'
      redirect_to "/users/#{current_user.id}" 
    end
  end
end
