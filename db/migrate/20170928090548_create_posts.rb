class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      
      t.integer :user_id
      t.string :user_name

      t.timestamps
    end
  end
end
