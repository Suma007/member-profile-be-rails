class CreateHeadings < ActiveRecord::Migration[7.1]
  def change
    create_table :headings do |t|
      t.references :member, null: false, foreign_key: true
      t.integer :level
      t.string :content_value

      t.timestamps
    end
  end
end
