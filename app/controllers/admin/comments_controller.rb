class Admin::CommentsController < AdminController
  before_action :find_comment, only: [:destroy]
  def index
    @comments = Comment.includes(:user, review: :film).all
    @comments = @comments.by_users params[:users] if params[:users]
    @comments = @comments.order_created_desc.paginate page: params[:page],
      per_page: Settings.admin.comments.per_page
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path
  end

  private
  def find_comment
    @comment = Comment.find_by id: params[:id]
  end
end
