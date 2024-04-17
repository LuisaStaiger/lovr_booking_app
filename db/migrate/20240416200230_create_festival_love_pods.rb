class CreateFestivalLovePods < ActiveRecord::Migration[7.1]
  def change
    create_table :festival_love_pods do |t|
      t.references :festival, null: false, foreign_key: true
      t.references :love_pod, null: false, foreign_key: true

      t.timestamps
    end
  end
end
