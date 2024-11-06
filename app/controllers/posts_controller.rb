class PostsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def admin
    session[:admin] = true
    redirect_to posts_path, notice: "Ви увійшли як адміністратор"
  end

  def logout_admin
    reset_session
    redirect_to posts_path, alert: "Ви вийшли з ролі адміністратора"
  end

  def index
    @posts = Post.all
  end

  def new
      @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if (@post.update(post_params))
      redirect_to @post, notice: "Публікацію оновлено успішно."
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy

    redirect_to posts_path, alert: "Публікацію видалено."
  end

  def create
    @post = Post.new(post_params)

    if (@post.save)
      redirect_to @post, notice: "Публікацію створено успішно."
    else
      render :new
    end
  end

  private def post_params
    params.require(:post).permit(:title, :price, :body, :image)
  end
end
