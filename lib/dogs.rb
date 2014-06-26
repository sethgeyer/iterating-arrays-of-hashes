class Dogs
  attr_accessor :dogs
  POOR      = (0..5).to_a.sample
  AVERAGE   = (6..10).to_a.sample
  EXCELLENT = (11..15).to_a.sample

  def initialize
    @joe   = {
      :name => {:first => "Joe", :last=> "Smith"},
      :owner_quality => EXCELLENT
    }
    @sarah = {
      :name => {:first => "Sarah", :last => "Darnum"},
      :owner_quality => AVERAGE
    }
    @andrew = {
      :name => {:first => "Andrew", :last => "Beter"},
      :owner_quality => AVERAGE
    }


    @dogs = [
      {name: "Fido",     size: :large,  owner: @joe},
      {name: "Yapper",   size: :small,  owner: @joe},
      {name: "Bruiser",  size: :large,  owner: @joe},
      {name: "Tank",     size: :huge,   owner: @sarah},
      {name: "Beast",    size: :large,  owner: @sarah},
      {name: "Harleigh", size: :medium, owner: @andrew},
      {name: "Trixie",   size: :small,  owner: @andrew}
    ]


  end

  def full_name(dog)
    "#{dog[:owner][:name][:first].capitalize} #{dog[:owner][:name][:last].capitalize}"
  end

  # only edit below this line


  def change_owners(dog_name, new_owner)
    dog_hash = @dogs.find { |dog| dog[:name] == dog_name }
    dog_hash[:owner] = if new_owner == "Sarah"
                         @sarah
                       elsif new_owner == "Joe"
                         @joe

                       elsif new_owner == "Andrew"
                         @andrew
                       end
    return dog_hash

  end

  def find_by_owner(owner)
   @dogs.select { |dog|  ("#{dog[:owner][:name][:first]} #{dog[:owner][:name][:last]}").include?(owner) }

  end

  def to_s
    dogs_grouped_by_owner = @dogs.group_by { |dog| dog[:owner][:name][:first] }
    array_of_owners_and_dogs = []

    dogs_grouped_by_owner.each do |owner, array_of_hashes_of_dogs|
        array_of_owners_dogs = []
        array_of_hashes_of_dogs.each do |dog|
        array_of_owners_dogs << dog[:name]
        end

        string = if array_of_owners_dogs.count >= 3
                    "#{owner} owns: #{array_of_owners_dogs[0..-2].join(", ")}, and #{array_of_owners_dogs[-1]}"
                  else
                    "#{owner} owns: #{array_of_owners_dogs.join( " and ")}"
                  end
        array_of_owners_and_dogs << string
    end
    array_of_owners_and_dogs.join("\n")
  end

  def average_owners
    average_owners = []
    @dogs.each do |dog|
      full_name = full_name(dog)
      average_owners << full_name if dog[:owner][:owner_quality] == AVERAGE && !average_owners.include?(full_name)
    end
    average_owners
  end

  def owners
    @dogs.each do |dog|
      @owner_array ||= []
      full_name = full_name(dog)
      #full_name = "#{dog[:owner][:name][:first].capitalize} #{dog[:owner][:name][:last].capitalize}"
      @owner_array << full_name if !@owner_array.include?(full_name)
    end
    @owner_array
  end

  def sizes
    @dogs.each do |dog|
      @sizes_array ||= []
      @sizes_array << dog[:size] if !@sizes_array.include?(dog[:size])
    end
    @sizes_array
  end

  def joes_large_dogs
    array_of_joes_large_dogs = []
    @dogs.each do |dog|
      array_of_joes_large_dogs << dog[:name] if dog[:size] == :large && dog[:owner][:name][:first] == "Joe"
    end
    array_of_joes_large_dogs
  end

  def large_dog_names
    large_dogs = @dogs.collect { |dog| dog[:name] if dog[:size] == :large }.compact
  end

  def huge_dog
    dogs = @dogs.select { |dog| dog[:size] == :huge }.first
  end

  def small_dogs
    @dogs.select { |dog| dog[:size] == :small }
  end

end
