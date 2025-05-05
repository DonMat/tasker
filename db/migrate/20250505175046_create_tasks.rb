class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :done, null: false, default: false
      t.datetime :done_at
      t.string :priority, index: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
