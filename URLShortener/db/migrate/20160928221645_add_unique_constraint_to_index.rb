class AddUniqueConstraintToIndex < ActiveRecord::Migration
  def change
    remove_index :shortened_urls, :long_url
    add_index :shortened_urls, :long_url, unique: true

    remove_index :shortened_urls, :short_url
    add_index :shortened_urls, :short_url, unique: true
  end
end
