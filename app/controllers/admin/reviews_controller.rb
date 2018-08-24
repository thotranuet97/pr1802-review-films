class Admin::ReviewsController < AdminController
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :find_film, only: [:show, :new, :create, :edit, :update,
    :destroy]

  def index
    @reviews = Review.paginate page: params[:page], per_page: 20
  end

  def show
  end

  def new
    if @film.review.present?
      flash[:danger] = t ".review_exist"
      redirect_to admin_reviews_path
    else
      @review = @film.build_review
    end
  end

  def create
    @review = @film.build_review review_params.merge(user_id: current_user.id)
    if @review.save
      flash[:info] = t ".review_created"
      redirect_to admin_reviews_path
    else
      flash[:danger] = t ".review_created_error"
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update review_params
      flash[:info] = t ".review_updated"
      redirect_to edit_admin_film_review_path @review.film
    else
      flash[:danger] = t ".review_updated_error"
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review)
      .permit :title, :content, :banner, :thumbnail,
        :banner_cache, :thumbnail_cache
  end

  def find_review
    @review = find_film.review
  end

  def find_film
    @film = Film.find_by id: params[:film_id]
  end
end
