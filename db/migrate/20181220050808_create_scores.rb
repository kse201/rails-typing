class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :point
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
