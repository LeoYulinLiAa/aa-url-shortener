class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :shortened_urls, :long_url, unique: true
  end
end
