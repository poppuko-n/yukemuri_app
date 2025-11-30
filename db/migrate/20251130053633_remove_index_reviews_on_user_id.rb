class RemoveIndexReviewsOnUserId < ActiveRecord::Migration[8.0]
  def change
    remove_index :reviews, name: 'index_reviews_on_user_id"'
  end
end
