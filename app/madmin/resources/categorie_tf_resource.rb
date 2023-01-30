class CategorieTfResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :titre
  attribute :created_at, form: false, index: false
  attribute :updated_at, form: false, index: false

  # Associations

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end
  def self.display_name(record)
    record.titre
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
