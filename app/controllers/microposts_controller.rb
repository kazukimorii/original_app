class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "ユーザー登録完了"
      redirect_to root_url
    else
      render 'microposts/index'
    end
  end
  
  def edit
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(user_params)
    else
      render 'edit'
    end
  end
  
  def destroy
  end
  
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  

  private
  
  def logged_in_user
  end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

  def micropost_params
    params.require(:micropost).permit(:content)
  end
  

end