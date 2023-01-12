class AnswerResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :description
  attribute :astre_points
  attribute :ips_points
  attribute :created_at, form: false, index: false
  attribute :updated_at, form: false, index: false

  # Associations
  attribute :student
  attribute :question

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
     record.description
  end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
