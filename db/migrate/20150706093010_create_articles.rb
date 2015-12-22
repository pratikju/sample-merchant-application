class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :order_id
      t.decimal :amount, :precision =>10, :scale => 2
      t.string :currency
      t.text :user_email
      t.string :product_desc
      t.boolean :send_email_check_box, :default => false
      t.timestamps null: false
    end
  end
end
