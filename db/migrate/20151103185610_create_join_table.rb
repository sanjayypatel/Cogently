class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :events, :users do |t|
      # t.index [:event_id, :user_id]
      # t.index [:user_id, :event_id]
    end
    create_join_table :events, :summaries do |t|
      # t.index [:event_id, :summary_id]
      # t.index [:summary_id, :event_id]
    end
  end
end
