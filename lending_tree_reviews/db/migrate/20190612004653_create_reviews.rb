class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
    	t.string :company
    	t.string :title
    	t.string :body
    	

    	t.index :company
    	t.timestamps
    end
  end
end
