class StudentResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :identifier
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :scoreIps
  attribute :scoreAstre
  attribute :predictedPath

  # Associations

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
     record.identifier
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
