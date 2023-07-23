class PersonController < ApplicationController
   def index
    @person = Person.new
    permit_params = params.permit(:search)
    binding.pry
    if permit_params[:search].present?
      @pagy, @people = pagy(Person.where"LOWER(first_name) LIKE ?", "%#{params[:search]}%")
    else
      @pagy, @people = pagy(Person.all, items: 10) 
    end
  end

  def import_csv
    permit_params = params.require(:person).permit(:file)
    if !permit_params
      flash[:alert] = 'Please upload a valid Excel file.'
    else
      file = permit_params[:file]
      if (file.present? && File.extname(file.original_filename) == ".csv")
          people_attrbutes = []
            begin
              ActiveRecord::Base.transaction do
                CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8') do |row| 
                  first_name, last_name = get_first_last_name(row['Name'])
                  location = row['Location']
                  affiliation = row['Affiliations']
                  locations = insert_locations(location)
                  affiliations = insert_affilations(affiliation)
                  if affiliations.length == 0 
                    next
                  end
                  person_attrbutes = {
                    first_name: first_name,
                    last_name: last_name,
                    species: row['Species'],
                    gender: row['Gender'],
                    weapon: row['Weapon'],
                    vehicle: row['Vehicle'],
                    locations: locations,
                    affilations: affiliations
                  }
                  people_attrbutes << person_attrbutes
                end
                Person.create!(people_attrbutes)
                flash[:notice] = 'Successfully added record.'
              end
            rescue Exception => e
              # flash[:alert] = "Unable to add records from csv"
              flash[:alert] = e
            end
      else 
        flash[:alert] = 'Please upload a valid Excel file.'
      end
    end
    redirect_back(fallback_location: root_path)
  end
  

  private
  def insert_locations(location)
    if !location 
        return []
    end
    locations = location.split(',')
    records = []
    locations.each do |l| 
      record = Location.find_or_create_by(name: l.strip)
      records << record
    end
    return records
  end

  def insert_affilations(affiliation)
    if !affiliation 
      return []
    end
    affiliations = affiliation.split(',')
    records = []
    affiliations.each do |a| 
      record = Affilation.find_or_create_by(name: a.strip)
      records << record
    end
    return records
  end

  
  def get_first_last_name(full_name) 
    if !full_name 
      return
    end
    names = full_name.split(' ')
    if names.length == 1 
      return names[0]
    end
    return names[0..-2].join(" ") , names[-1]
  end
end

