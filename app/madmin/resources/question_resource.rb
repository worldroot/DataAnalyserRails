class QuestionResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :title
  attribute :answer, form: false, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :answer_id, form: false, index: false

  # Associations
  attribute :answers

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
     record.title
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
