class AddClaimedToWagers < ActiveRecord::Migration[5.0]
  def change
    change_table :wagers do |t|
      t.boolean :claimed
    end
  end
end
