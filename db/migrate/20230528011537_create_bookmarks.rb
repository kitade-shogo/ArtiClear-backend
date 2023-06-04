class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.text :url, null: false
      t.string :title, null: false
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :folder, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookmarks, :url, unique: true
  end
end
