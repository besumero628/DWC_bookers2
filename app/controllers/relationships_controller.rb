class RelationshipsController < ApplicationController

  def create
    @follow = Relationship.new(follower_id: current_user.id, followed_id: params[:user_id])
    @follow.follower_id = current_user.id
    @follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end

  def follower
    
  end

  def followed

  end

end
