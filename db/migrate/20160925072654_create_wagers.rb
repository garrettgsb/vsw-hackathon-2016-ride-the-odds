class CreateWagers < ActiveRecord::Migration[5.0]
  def change
    create_table :wagers do |t|
      t.text :bet_type
      t.text :payout
      t.text :amount
      t.text :route_number
      t.text :stop_number
      t.text :scheduled_time
      t.text :average_time
      t.text :actual_time
      t.text :over_under
      t.timestamps
    end
  end
end
