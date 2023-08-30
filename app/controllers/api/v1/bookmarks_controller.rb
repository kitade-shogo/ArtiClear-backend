require 'nokogiri'
require 'mechanize'

class Api::V1::BookmarksController < Api::V1::BaseController
  before_action :set_bookmark, only: %i[destroy]

  def index
    bookmarks = current_user.bookmarks.order(created_at: :desc)
    json_string = BookmarkSerializer.new(bookmarks).serializable_hash.to_json
    render json: json_string
  end

  def create
    bookmark = current_user.bookmarks.build(bookmark_params)
    bookmark.description = fetch_og_description(bookmark.url)
    if bookmark.save
      json_string = BookmarkSerializer.new(bookmark).serializable_hash.to_json
      render json: json_string
    else
      render json: { errors: bookmark.errors.full_messages }, status: 400
    end
  end

  def destroy
    if @bookmark.destroy
      render json: { message: "Bookmark deleted successfully" }
    else
      render json: { error: "Failed to destroy" }, status: 422
    end
  end

  private

  def set_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :title, :description, :folder_id)
  end

  def fetch_og_description(url)
    begin
      agent = Mechanize.new
      page = agent.get(url)
      og_description = page.at('meta[property="og:description"]')&.attributes&.[]("content")&.value
      if og_description && og_description.length > 255
        og_description = og_description[0..251] + '...' # 252文字を切り取り、'...'を追加
      end
      og_description unless og_description.blank?
    rescue => e
      Rails.logger.info "#{e}"
      nil
    end
  end
end
