class UserForum < ApplicationRecord

  default_scope { order('user_forums.kpi_a DESC') }

  jsonb_accessor :kpis,
  nbr_msgs_posted: [:integer, default: 0],
  nbr_files_uploaded: [:integer, default: 0],
  nbr_msgs_quoted: [:integer, default: 0],
  nbr_msgs_replied: [:integer, default: 0],
  time_spent: [:integer, default: 0.0]
end
