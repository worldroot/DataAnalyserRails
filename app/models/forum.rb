class Forum < ApplicationRecord
  jsonb_accessor :kpis,
  nbr_msgs: [:integer, default: 0],
  nbr_affich_structure: [:integer, default: 0],
  nbr_affich_msgs: [:integer, default: 0],
  time_spent: [:integer, default: 0.0]
end
