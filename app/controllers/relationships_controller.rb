class RelationshipsController < ApplicationController
  def create #フォローする 
    current_user.follow(params[:user_id])
    redirect_to request.referer 
  end
  
  def destroy #フォローを外す　
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  def follower 
    user = User.find(params[:user_id])
    @users = user.following_user #自分がフォローしているユーザー
  end
  
  def followed 
    user = User.find(params[:user_id])
    @users = user.follower_user #自分をフォローしているユーザー
  end
end
