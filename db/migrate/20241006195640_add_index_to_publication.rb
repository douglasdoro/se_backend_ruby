class AddIndexToPublication < ActiveRecord::Migration[7.1]
  def change
    add_index :publications, :published_at
  end
end
