class CreateCategorieTfs < ActiveRecord::Migration[7.0]
  def change
    create_table :categorie_tfs do |t|
      t.string :titre

      t.timestamps
    end
  end
end
