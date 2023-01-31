module Importers
  class TraceforumImport
    include ActiveModel::Model
    require 'roo'
    require 'byebug'

    attr_accessor :file, :headers, :success_imported_data


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

      #reintialisation des données
      Forum.all.each do |f|
        f.nbr_affich_msgs = 0
        f.time_spent = 0
        f.nbr_affich_structure= 0
        f.nbr_msgs = 0
        f.save
      end
    
      UserForum.all.each do |u|
        u.nbr_activite = 0
        u.nbr_msgs_posted = 0
        u.nbr_msgs_replied = 0
        u.nbr_msgs_quoted = 0
        u.nbr_files_uploaded = 0
        u.time_spent = 0
        u.save
      end

      (2..spreadsheet.last_row).map do |i|
        row = Hash[[@header, spreadsheet.row(i)].transpose]

        if !row['Attribut'].include?("Forum")
          next
        end
        # id_forum = row['Attribut'].split(',').first
        forum = Forum.find_by(id_reference_tf: row['Attribut'].scan(/\d+/).first) || Forum.new
        user_forum = UserForum.find_by(name: row['Utilisateur']) || UserForum.new

        #calcul user_forum
        user_forum.name = row['Utilisateur']
        user_forum.nbr_activite += 1
        user_forum.nbr_msgs_posted += 1 if row['Titre'].eql?('Poster un nouveau message')
        user_forum.nbr_msgs_replied += 1 if row['Titre'].eql?("Repondre a un message")
        user_forum.nbr_msgs_quoted += 1 if row['Titre'].eql?("Citer un message")
        user_forum.nbr_files_uploaded += 1 if row['Titre'].eql?("Upload un ficher avec le message")
        user_forum.time_spent += row['Delai'] if !row['Delai'].eql?("NULL")
        user_forum.kpi_a =  user_forum.nbr_msgs_posted * 0.3 + ( user_forum.nbr_msgs_replied + user_forum.nbr_msgs_quoted ) * 0.3  + 
                          user_forum.nbr_activite * 0.1 + user_forum.nbr_files_uploaded * 0.1 
                          +  user_forum.time_spent * 0.2
        user_forum.save

        #calcul forum
        forum.id_reference_tf = row['Attribut'].scan(/\d+/).first
        forum.time_spent += row['Delai'] if !row['Delai'].eql?("NULL")
        forum.nbr_msgs += 1 if row['Titre'].eql?('Poster un nouveau message')
        forum.nbr_affich_structure += 1 if row['Titre'].eql?('Afficher une structure (cours/forum)')
        forum.nbr_affich_msgs += 1 if row['Titre'].eql?("Afficher le contenu d'un message")
        forum.kpi_a = forum.nbr_affich_msgs
        forum.kpi_b = forum.nbr_msgs * 0.4 + forum.nbr_affich_msgs * 0.2 + forum.nbr_affich_structure * 0.2
        forum.kpi_c = forum.nbr_affich_structure
        forum.kpi_d = forum.time_spent
        forum.save
        forum



        
      end
    end

    def imported_data
      @imported_data ||= load_imported_data
    end

    def save
      @success_imported_data = 0
      load_imported_data.each_with_index do |forum, index|
        if forum&.save
          @success_imported_data += 1
        else
          next if forum.nil?

          forum.errors.full_messages.each do |msg|
            errors.add :base, "Row (#{index}) : #{msg}, #{forum.id_reference_tf}"
          end
        end
      end
      return false if @success_imported_data.zero? || errors.any?

      true
    end
  end
end
