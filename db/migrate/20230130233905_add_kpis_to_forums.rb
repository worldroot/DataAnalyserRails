class AddKpisToForums < ActiveRecord::Migration[7.0]
  def change
    add_column :forums, :kpi_a, :integer
    add_column :forums, :kpi_b, :integer
    add_column :forums, :kpi_c, :integer
    add_column :forums, :kpi_d, :float
  end
end
