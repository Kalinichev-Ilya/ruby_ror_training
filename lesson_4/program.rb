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
        # Show station list
        when '7'
          show_station_list_interface
        when '8'
          show_trains_on_station_by_type_interface
      end
      break if input == 'q'
    end
  end
  
  private
  
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
      show_list(@stations)
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
      add_wagon_to_train(train_index)
    else
      puts 'First create a train'
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
      # Create a route
      when 1
        create_route_interface
      # Delete a route
      when 2
        delete_route_interface
      # Add station
      when 3
        add_station_to_route_interface
      # Remove station
      when 4
        remove_station_from_route_interface
      # Create station
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
    puts 'Enter the train number:'
    number = gets.chomp
    puts 'Choose type: 1 for cargo, 2 for passenger:'
    type = gets.chomp.to_i
    create_train(number, type)
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
  end
  
  def create_station(name)
    @stations << Station.new(name)
  end
  
  def create_route(start, _end)
    @routes << Route.new(start, _end)
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
  
  def add_wagon_to_train(train_index)
    train = @trains[train_index]
    train.add_wagon(CargoWagon.new) if train.class == CargoTrain
    train.add_wagon(PassengerWagon.new) if train.class == PassengerTrain
    puts 'Added wagon'
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
    cargo = station.trains_by_type(CargoTrain)
    passenger = station.trains_by_type(PassengerTrain)
    puts 'There are no cargo trains at this station.' unless cargo.any?
    puts 'There are no passenger trains at this station.' unless passenger.any?
    if cargo.any?
      puts "Cargo (#{cargo.count})"
      show_list(cargo)
    end
    if passenger.any?
      puts "Passenger (#{passenger.count})"
      show_list(passenger)
    end
  end
end
