class AddScoresToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :scoreIps, :integer
    add_column :students, :scoreAstre, :integer
    add_column :students, :predictedPath, :string
  end
end
