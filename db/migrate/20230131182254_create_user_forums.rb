class CreateUserForums < ActiveRecord::Migration[7.0]
  def change
    create_table :user_forums do |t|
      t.string :name
      t.integer :nbr_activite, default: 0
      t.integer :kpi_a, default: 0
      t.integer :kpi_b, default: 0
      t.integer :kpi_c, default: 0
      t.jsonb :kpis

      t.timestamps
    end
  end
end
