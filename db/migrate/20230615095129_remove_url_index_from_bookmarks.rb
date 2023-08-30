class RemoveUrlIndexFromBookmarks < ActiveRecord::Migration[6.1]
  def change
    remove_index :bookmarks, name: "index_bookmarks_on_url"
  end
end
