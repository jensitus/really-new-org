class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.select(:name).order(:created_at)
  end

  def show
  end

  private

  def set_user
    begin
      @user = User.find_by_name(params[:name])
      @user_posts = @user.microposts.paginate(page: params[:page], per_page: 10).order('updated_at desc')
    rescue => e
      redirect_to :root
    end
  end

end
