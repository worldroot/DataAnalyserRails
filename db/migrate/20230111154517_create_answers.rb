class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :description
      t.integer :astre_points
      t.integer :ips_points
      t.references :student, null: true, foreign_key: true
      t.references :question, null: true, foreign_key: true
      t.timestamps
    end
  end
end
