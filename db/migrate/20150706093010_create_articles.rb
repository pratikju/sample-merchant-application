class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :order_id
      t.decimal :amount
      t.string :currency
      t.text :user_email
      t.string :product_desc

      t.timestamps null: false
    end
  end
end
