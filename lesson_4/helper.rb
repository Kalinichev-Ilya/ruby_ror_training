module Helper
  
  def self.show_station_list(stations)
    stations.each { |station| puts "#{stations.index(station)} : #{station.name}" }
  end
  
  def self.show_route_list(routes)
    routes.each { |route| puts "#{routes.index(route)} : \"#{route.stations[0].name} - #{route.stations[-1].name}\"" }
  end
  
  def self.show_train_list(trains)
    trains.each { |train| puts "#{trains.index(train)} : #{train.number}" }
  end
  
  def self.choose_a_route(routes)
    puts 'Select route:'
    routes.each { |route| puts "#{routes.index(route)} : \"#{route.stations[0].name} - #{route.stations[-1].name}\"" }
    puts ''
    route_index = gets.chomp.to_i
    route_index
  end
  
  def self.choose_a_station(stations)
    puts 'Select station:'
    stations.each { |station| puts "#{stations.index(station)} : #{station.name}" }
    puts ''
    station_index = gets.chomp.to_i
    station_index
  end
  
  def self.choose_a_train(trains)
    puts 'Select train:'
    trains.each { |train| puts "#{trains.index(train)} : #{train.number}" }
    puts ''
    train_index = gets.chomp.to_i
    train_index
  end
  
  def self.get_station_name
    puts 'Enter the name of station.'
    name = gets.chomp
    name
  end
end
