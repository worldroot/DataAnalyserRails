class CreateForums < ActiveRecord::Migration[7.0]
  def change
    create_table :forums do |t|
      t.integer :id_reference_tf
      t.jsonb :kpis

      t.timestamps
    end
  end
end
