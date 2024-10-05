class CreatePublications < ActiveRecord::Migration[7.1]
  def change
    create_table :publications, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :published_at, null: true
      t.datetime :deleted_at, null: true
      t.integer :status, null: false, default: 0
      t.references :author, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
