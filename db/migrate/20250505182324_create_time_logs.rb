class CreateTimeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :time_logs do |t|
      t.references :task, null: false, foreign_key: true
      t.date :recorded_at
      t.integer :duration_in_minutes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
