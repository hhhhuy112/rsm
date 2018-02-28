class BookmarkLikesController < BaseNotificationsController
  load_and_authorize_resource param_method: :bookmark_like_params
  before_action :authenticate_user!
  before_action :load_bookmarks, only: :index
  before_action :load_applies, only: :index
  before_action :load_notifications, only: :index

  def create
    respond_to do |format|
      if @bookmark_like.save
        format.js{@success = t "bookmark_likes.create"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @bookmark_like.really_destroy!
        @bookmark_like.like? ? load_like : load_bookmark
        format.js{@success = t "bookmark_likes.destroy_success"}
      else
        format.js
      end
    end
  end

  private

  def load_applies
    @q = current_user.applies.includes(:job, :company).ransack params[:q]
    @applies = @q.result(distinct: true).newest_apply.page(params[:page]).per(Settings.apply.page)
  end

  def load_bookmarks
    @bookmark_likes = current_user.bookmark_likes.is_bookmark.page(params[:page])
      .per Settings.bookmark.page
  end

  def load_like
    return unless user_signed_in?
    @like = current_user.bookmark_likes.build
    @like.job_id = @bookmark_like.job_id
    @like.bookmark = BookmarkLike.bookmarks.keys[Settings.bookmark.liked]
  end

  def load_bookmark
    return unless user_signed_in?
    @bookmark = current_user.bookmark_likes.build
    @bookmark.job_id = @bookmark_like.job_id
    @bookmark.bookmark = BookmarkLike.bookmarks.keys[Settings.bookmark.bookmarked]
  end

  def bookmark_like_params
    params.require(:bookmark_like).permit :user_id, :job_id, :bookmark
  end
end
