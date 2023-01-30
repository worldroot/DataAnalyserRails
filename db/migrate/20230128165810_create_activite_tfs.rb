class CreateActiviteTfs < ActiveRecord::Migration[7.0]
  def change
    create_table :activite_tfs do |t|
      t.string :titre
      t.integer :typeAct
      t.references :categorie_tf, null: false, foreign_key: true

      t.timestamps
    end
  end
end
