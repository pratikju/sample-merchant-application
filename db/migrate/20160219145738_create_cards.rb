class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :card_number
      t.string :card_holder_name
      t.string :cvv_2
      t.string :expiry
      t.timestamps null: false
    end
  end
end
