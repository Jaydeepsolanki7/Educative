class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.references :product, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :difficulty

      t.timestamps
    end
  end
end
