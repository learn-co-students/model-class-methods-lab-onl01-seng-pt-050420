class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # all.limit(5) 
    select(:name).limit(5) # returns the first five Boats 
  end

  def self.dinghy
     where("length < 20") # returns boats shorter than 20 feet
  end

  def self.ship
     where("length >= ?", 20) # returns boats 20 feet or longer
  end

  def self.last_three_alphabetically
    select(:name).order(name: :desc).limit(3) # returns last three boats in alphabetical order
  end

  def self.without_a_captain
     where("captain_id IS ?", nil) # returns boats without a captain
  end

  def self.sailboats
    joins(:classifications).where("classifications.name" => "Sailboat" )
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    
    joins(:classifications).group("boats.name").having("count(boat_id) = 3") # returns boats with three classifications 
  
  end

  def self.non_sailboats
    # where("id NOT IN (?)", self.sailboats.pluck(:id)) 
    where.not("id IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    # order('length DESC').first 
    order("length DESC").first
    
  end
end
