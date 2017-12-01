class BookmarkLikesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :bookmark_like_params

  def index
    @bookmark_likes = current_user.bookmark_likes.is_bookmark.page(params[:page]).per Settings.bookmark.page
  end

  def create
    respond_to do |format|
      if @bookmark_like.save
        format.js{@success = t "bookmark_like.create"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @bookmark_like.destroy
        @bookmark_like.like? ? load_like : load_bookmark
        format.js{@success = t "achievements.destroy_success"}
      else
        format.js
      end
    end
  end

  private

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
