# Menu
class Program
  def initialize
    @routes = []
    @stations = []
    @trains = []
  end
  
  def run
    loop do
      puts 'Enter q for quit'
      puts 'Menu:'
      puts '1. Create a train'
      puts '2. Create a route, station management'
      puts '3. Assign a route'
      puts '4. Add wagon to train'
      puts '5. Remove wagon from train'
      puts '6. Move train on the road'
      puts '7. Show station list'
      puts '8. Show train list on station'
      puts '9. Show wagon list by train'
      puts '10. Take the place in train wagon'
      input = gets.chomp
      
      case input
        when '1'
          create_train_interface
        when '2'
          create_route_and_station_management_interface
        when '3'
          assign_route_to_train_interface
        when '4'
          add_wagon_to_train_interface
        when '5'
          remove_wagon_from_train_interface
        when '6'
          move_train_on_the_route_interface
        when '7'
          show_station_list_interface
        when '8'
          show_trains_on_station_by_type_interface
        when '9'
          show_wagon_list_by_train
        when '10'
          take_the_place_in_train_wagon
      end
      break if input == 'q'
    end
  end
  
  private
  
  def take_the_place_in_train_wagon
    if @trains.any?
      show_list(@trains)
      train_index = gets.chomp.to_i
      train = @trains[train_index]
      if train.wagons.any?
        puts "In train #{train.number} #{train.wagons.count} wagons, choose number of wagon:"
        wagon_index = gets.chomp.to_i
        wagon = train.wagons[wagon_index-1]
        if wagon.type == PassengerTrain
          wagon.take_a_place
        else
          puts 'Enter the volume occupied:'
          volume = gets.chomp.to_f
          wagon.take_a_place(volume)
        end
      else
        puts 'First add wagon to this train.'
        add_wagon_to_train_interface
      end
    else
      puts 'First create a train.'
      create_train_interface
    end
  end
  
  def show_wagon_list_by_train
    if @trains.any?
      show_list(@trains)
      train_index = gets.chomp.to_i
      train = @trains[train_index]
      show_wagon_list(train)
    else
      puts "First create train, trains: #{@trains.count}"
    end
  end
  
  def show_trains_on_station_by_type_interface
    if @stations.any? && @trains.any?
      show_list(@stations)
      station_index = gets.chomp.to_i
      show_trains_on_station(station_index)
    else
      puts "First create a stations and train, stations: #{@stations.count}, trains: #{@trains.count}"
    end
  end
  
  def show_station_list_interface
    if @stations.any?
      @stations.each do |station|
        puts "Station: #{station.name}"
        station.each_train do |train|
          "Train number #{train.number}, type: #{train.class}, wagons count: #{train.wagons.count}"
        end
      end
    else
      puts "First create a stations, stations count: #{@stations.count}"
    end
  end
  
  def move_train_on_the_route_interface
    if @trains.any?
      show_list(@trains)
      train_index = gets.chomp.to_i
      train = @trains[train_index]
      if train.route.stations.any?
        puts 'Where we go?'
        puts 'forward movement: 1, backward movement: 2'
        input = gets.chomp.to_i
        move_train_to_the_next_station(train_index) if input.eql? 1
        move_train_to_the_previous_station(train_index) if input.eql? 2
      else
        puts 'First assign route for this train'
      end
    else
      puts "First create a train, trains count: #{@trains.count}"
    end
  end
  
  def remove_wagon_from_train_interface
    if @trains.any?
      show_list(@trains)
      train_index = gets.chomp.to_i
      remove_wagon_from_train(train_index)
    else
      puts "First create a train, trains count: #{@trains.count}"
    end
  end
  
  def add_wagon_to_train_interface
    if @trains.any?
      show_list(@trains)
      train_index = gets.chomp.to_i
      puts 'Input amount of free space in wagon:'
      capacity = gets.chomp
      add_wagon_to_train(train_index, capacity)
    else
      puts 'First create a train'
      create_train_interface
    end
  end
  
  def assign_route_to_train_interface
    if @trains.any? && @routes.any?
      show_list(@routes)
      route_index = gets.chomp.to_i
      show_list(@trains)
      train_index = gets.chomp.to_i
      assign_train_on_route(route_index, train_index)
    else
      puts "First create a train or route; trains: #{@trains.count}, routes: #{@routes.count}"
    end
  end
  
  def create_route_and_station_management_interface
    puts '1. Create a route'
    puts '2. Delete a route'
    puts '3. Add station'
    puts '4. Remove station'
    puts '5. Create station'
    input = gets.chomp.to_i
    
    case input
      when 1
        create_route_interface
      when 2
        delete_route_interface
      when 3
        add_station_to_route_interface
      when 4
        remove_station_from_route_interface
      when 5
        create_station_interface
    end
  end
  
  def create_station_interface
    name = get_station_name
    create_station(name)
    show_list(@stations)
  end
  
  def remove_station_from_route_interface
    if @routes.any? && @stations.any?
      show_list(@routes)
      route_index = gets.chomp.to_i
      show_list(@routes[route_index].stations)
      station_index = gets.chomp.to_i
      remove_station_from_route(route_index, station_index)
      show_list(@routes[route_index].stations)
    else
      puts "Do not enough routes or stations; routes: #{@routes.count}, stations: #{@stations.count}"
    end
  end
  
  def add_station_to_route_interface
    if @routes.any?
      if @stations.count.zero?
        puts 'Do not enough stations'
        puts 'Enter the name of station.'
        name = gets.chomp
        create_station(name)
        show_list(@stations)
      else
        show_list(@routes)
        route_index = gets.chomp.to_i
        show_list(@stations)
        station_index = gets.chomp.to_i
        add_station_to_route(route_index, station_index)
        show_list(@routes[route_index].stations)
      end
    else
      puts 'First create a route'
    end
  end
  
  def delete_route_interface
    if @routes.any?
      show_list(@routes)
      puts ''
      puts 'Select the route index to delete'
      number = gets.chomp.to_i
      delete_route(number)
      show_list(@routes)
    else
      puts 'Nothing to delete'
    end
  end
  
  def create_route_interface
    while @stations.count < 2
      puts 'There are not enough stations'
      name = get_station_name
      create_station(name)
    end
    show_list(@stations)
    puts 'Select the start station'
    start = gets.chomp.to_i
    puts 'Select the end station'
    _end = gets.chomp.to_i
    create_route(@stations[start], @stations[_end])
    show_list(@routes)
  end
  
  def create_train_interface
    puts 'Enter the train number(format: 123-AA or QWE12):'
    number = gets.chomp
    puts 'Choose type: 1 for cargo, 2 for passenger:'
    type = gets.chomp.to_i
    train = create_train(number, type)
    unless train.nil?
      puts "Train number #{train.number} was successfully created."
    end
  end
  
  def get_station_name
    puts 'Enter the name of station.'
    gets.chomp
  end
  
  def show_list(array)
    puts ''
    array.each.with_index { |element, i| puts "#{i}: #{element}" }
    puts ''
  end
  
  def create_train(number, type)
    @trains << CargoTrain.new(number) if type == 1
    @trains << PassengerTrain.new(number) if type == 2
  rescue ValidationError => e
    puts "#{e.message}: #{e.obj}"
  end
  
  def create_station(name)
    @stations << Station.new(name)
  rescue ValidationError => e
    puts "#{e.message}: #{e.obj}"
  end
  
  def create_route(start, _end)
    @routes << Route.new(start, _end)
  rescue ValidationError => e
    puts "#{e.message}: #{e.obj}"
  end
  
  def delete_route(number)
    route = @routes[number]
    @routes.delete(route)
  end
  
  def add_station_to_route(route_index, station_index)
    route = @routes[route_index]
    station = @stations[station_index]
    route.add_station(station)
  end
  
  def remove_station_from_route(route_index, station_index)
    route = @routes[route_index]
    station = @routes[route_index].stations[station_index]
    route.delete_station(station)
  end
  
  def assign_train_on_route(route_index, train_index)
    train = @trains[train_index]
    train.route = @routes[route_index]
    route = train.route
    station_number = train.station_index
    station = route.stations[station_number]
    station.add_train(train)
    puts "Train #{train} was assign on the station #{station} from route #{route}"
  end
  
  def add_wagon_to_train(train_index, capacity)
    train = @trains[train_index]
    wagon = create_wagon(train, capacity)
    train.add_wagon(wagon)
    puts "Added wagon with #{wagon.free_space} space."
  end
  
  def create_wagon(train, capacity)
    wagon = CargoWagon.new(capacity) if train.class == CargoTrain
    wagon = PassengerWagon.new(capacity) if train.class == PassengerTrain
    wagon
  end
  
  def remove_wagon_from_train(train_index)
    train = @trains[train_index]
    train.remove_wagon
    puts 'Wagon removed' if train.wagons.count > 0
  end
  
  def remove_train_from_station(train_index)
    train = @trains[train_index]
    station = train.current_station
    station.move train
  end
  
  def move_train_to_the_next_station(train_index)
    train = @trains[train_index]
    next_station = train.next_station
    if next_station.nil?
      puts 'There is nowhere to go'
    else
      remove_train_from_station(train_index)
      next_station.add_train train
      train.go_to_the_next_station
      puts "Train: #{train} goes from: #{train.current_station} to: #{next_station}"
    end
  end
  
  def move_train_to_the_previous_station(train_index)
    train = @trains[train_index]
    previous_station = train.previous_station
    if previous_station.nil?
      puts 'There is nowhere to go'
    else
      remove_train_from_station(train_index)
      previous_station.add_train train
      train.go_to_the_previous_station
      puts "Train: #{train} goes from: #{train.current_station} to: #{previous_station}"
    end
  end
  
  def show_trains_on_station(station_index)
    station = @stations[station_index]
    station.each_train.with_index(1) do |train, index|
      puts "Train number #{index}, train: #{train.number}"
      show_wagon_list(train)
    end
  end
  
  def show_wagon_list(train)
    train.each_wagon.with_index(1) do |wagon, index|
      puts "wagon number: #{index}, type: #{wagon.type}, free space: #{wagon.free_space}"
    end
  end
end
