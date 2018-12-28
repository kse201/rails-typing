class CreateTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :texts do |t|
      t.text :word
      t.text :mean

      t.timestamps
    end
  end
end
