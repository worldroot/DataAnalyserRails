module Importers
  class DataImport
    include ActiveModel::Model
    require 'roo'
    require 'byebug'

    attr_accessor :file, :headers, :success_imported_data

    #REQUIRED_HEADERS = %w[name contact_name email telephone].freeze

    def initialize(attributes = {})
      attributes.each { |key, value| send("#{key}=", value) }
    end

    def persisted?
      false
    end

    def open_spreadsheet
      case File.extname(file.original_filename)
      when '.csv' then Roo::CSV.new(file.path)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

    def load_imported_data
      spreadsheet = open_spreadsheet
      @header = spreadsheet.row(1)

      (2..spreadsheet.last_row).map do |i|
        row = Hash[[@header, spreadsheet.row(i)].transpose]
        if row['identifiant'].nil?
          errors.add :base, "Row (#{i}) 'identifiant' must be present!"
          next
        end

        student = Student.find_by(identifier: row['identifiant']) || Student.new
        student.identifier = row['identifiant']
        student.scoreAstre = 0
        student.scoreIps = 0
        student.save
        student

        Question.all.each do |q|
          student_answer = Answer.find_by(description: row[q.title], question: q )
          student.scoreIps += student_answer.ips_points if !student_answer.nil?
          student.scoreAstre += student_answer.astre_points if !student_answer.nil?
        end
        student.prediction
        student

        
      end
    end

    def imported_data
      @imported_data ||= load_imported_data
    end

    def save
      @success_imported_data = 0
      load_imported_data.each_with_index do |student, index|
        if student&.save
          @success_imported_data += 1
        else
          next if student.nil?

          student.errors.full_messages.each do |msg|
            errors.add :base, "Row (#{index}) : #{msg}, #{student.name}"
          end
        end
      end
      return false if @success_imported_data.zero? || errors.any?

      true
    end
  end
end
