class BlogPostsController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog_post, except: %i[index new create]
  layout 'application'
  # except: [:index, :new, :create]    only: %i[show edit update destroy]

  def index
    @blog_posts = BlogPost.all
  end

  def show; end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @blog_post.destroy
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
    # @blog_post = BlogPost.find_by(id: params[:id])
    # logger.info(@blog_post)
    # logger.info(BlogPost.model_name)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
  # end
end
