class Answer < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :question, optional: true
end
