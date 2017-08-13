require_relative 'app/cargo_train'
require_relative 'app/passenger_train'
require_relative 'app/cargo_wagon'
require_relative 'app/passenger_wagon'
require_relative 'app/route'
require_relative 'app/station'
require_relative 'app/wagon'
require_relative 'app/train'
require_relative 'helper'

# - Создавать станции
# - Создавать поезда
# - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# - Назначать маршрут поезду
# - Добавлять вагоны к поезду
# - Отцеплять вагоны от поезда
# - Перемещать поезд по маршруту вперед и назад
# - Просматривать список станций и список поездов на станции

include Helper

@routes = []
@stations = []
@trains = []

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
    # Create a train
    when '1'
      puts ''
      puts 'Enter the train number:'
      number = gets.chomp
      puts 'Choose type: 1 for cargo, 2 for passenger:'
      type = gets.chomp.to_i
      
      @trains << CargoTrain.new(number) if type == 1
      @trains << PassengerTrain.new(number) if type == 2
      puts ''
    
    # Create a route, station management
    when '2'
      puts ''
      puts '1. Create a route'
      puts '2. Delete a route'
      puts '3. Add station'
      puts '4. Remove station'
      puts '5. Create station'
      input = gets.chomp.to_i
      
      case input
        
        # Create a route
        when 1
          puts ''
          while @stations.count < 2
            puts 'Do not enough stations'
            name = Helper.get_station_name
            
            @stations << Station.new(name)
            puts ''
          end
          Helper.show_station_list(@stations)
          puts ''
          puts 'Select the start station'
          start = gets.chomp.to_i
          puts 'Select the end station'
          _end = gets.chomp.to_i
          
          @routes << Route.new(@stations[start], @stations[_end])
          Helper.show_route_list(@routes)
          puts ''
        
        # Delete a route
        when 2
          puts ''
          if @routes.any?
            Helper.show_route_list(@routes)
            puts ''
            puts 'Select the route index to delete'
            number = gets.chomp.to_i
            puts 'Are you sure?(y/n)'
            input = gets.chomp
            
            route = @routes[number]
            @routes.delete(route) if input == 'y'
            Helper.show_route_list(@routes)
          else
            puts 'Nothing to delete'
          end
          puts ''
        # Add station
        when 3
          puts ''
          if @routes.any?
            if @stations.count.zero?
              puts 'Do not enough stations'
              puts 'Enter the name of station.'
              name = gets.chomp
              
              @stations << Station.new(name)
              Helper.show_station_list(@stations)
            else
              route_index = Helper.choose_a_route(@routes)
              station_index = Helper.choose_a_station(@stations)
              
              @routes[route_index].add_station(@stations[station_index])
              @routes[route_index].stations.each { |station| print "#{station.name} " }
              puts ''
            end
          else
            puts 'First create a route'
            puts ''
          end
        
        # Remove station
        when 4
          puts ''
          if @routes.any? && @stations.any?
            route_index = Helper.choose_a_route(@routes)
            @routes[route_index].stations.each_with_index { |station, index| puts "#{station.name} : #{index}" }
            station_index = gets.chomp.to_i
            
            @routes[route_index].delete_station(@routes[route_index].stations[station_index])
            @routes[route_index].stations.each { |station| print "#{station.name} " }
          else
            puts "Do not enough routes or stations; routes: #{@routes.count}, stations: #{@stations.count}"
          end
          puts ''
        
        # Create station
        when 5
          puts ''
          name = Helper.get_station_name
          @stations << Station.new(name)
          puts ''
      end
    
    # Assign a route
    when '3'
      puts ''
      if @trains.any? && @routes.any?
        route_index = Helper.choose_a_route(@routes)
        train_index = Helper.choose_a_train(@trains)
        
        # взял поезд
        train = @trains[train_index]
        # назначил ему маршрут
        train.route = @routes[route_index]
        # теперь у поезда есть маршрут
        route = train.route
        # у поезда есть номер станции из маршрута
        station_number = train.station_index
        # получаем станцию из маршрута поезда
        station = route.stations[station_number]
        # добавляем поезд на эту станцию
        station.add_train(train)
        
        puts "Train #{train.number} was assign on the station #{station.name} from route #{route.print}"
      else
        puts "First create a train or route; trains: #{@trains.count}, routes: #{@routes.count}"
      end
      puts ''
    
    # Add wagon to train
    when '4'
      puts ''
      if @trains.any?
        train_index = Helper.choose_a_train(@trains)
        
        train = @trains[train_index]
        train.add_wagon(CargoWagon.new) if train.type == 'cargo'
        train.add_wagon(PassengerWagon.new) if train.type == 'passenger'
      
      else
        puts 'First create a train'
      end
      puts ''
    
    # Remove wagon from train
    when '5'
      puts ''
      if @trains.any?
        train_index = Helper.choose_a_train(@trains)
        
        @trains[train_index].remove_wagon
      else
        puts "First create a train, trains count: #{@trains.count}"
      end
      puts ''
    
    # Move train on the road
    when '6'
      puts ''
      if @trains.any?
        train_index = Helper.choose_a_train(@trains)
        
        # взял поезд
        train = @trains[train_index]
        if train.route.nil?
          puts 'First assign route for this train'
        else
          puts 'Where we go?'
          puts 'forward movement: 1, backward movement: 2'
          input = gets.chomp.to_i
          
          if input.eql? 1
            # взял из маршрута поезда текущую станцию
            station = train.current_station
            # убрал из нее поезд
            station.move train
            
            # взял из маршрута поезда следующую станцию
            next_station = train.next_station
            if next_station.nil?
              puts 'There is nowhere to go'
              puts ''
            else
              # добавил в нее поезд
              next_station.add_train train
              
              # поезд отправился на следующую станцию (station_index увеличился на 1)
              train.go_to_the_next_station
              
              puts "Train: #{train.number} goes from: #{station.name} to: #{next_station.name}"
            end
          end
          if input.eql? 2
            # взял из маршрута поезда текущую станцию
            station = train.current_station
            # убрал из нее поезд
            station.move train
            
            # взял из маршрута поезда следующую станцию
            previous_station = train.previous_station
            
            if previous_station.nil?
              puts 'There is nowhere to go'
              puts ''
            else
              # добавил в нее поезд
              previous_station.add_train train
              
              # поезд отправился на предыдущую станцию (station_index уменьшился на 1)
              train.go_to_the_previous_station
              
              puts "Train: #{train.number} goes from: #{station.name} to: #{previous_station.name}"
            
            end
          end
        end
      else
        puts "First create a train, trains count: #{@trains.count}"
      end
      puts ''
    
    # Show station list
    when '7'
      puts ''
      if @stations.any?
        Helper.show_station_list(@stations)
      else
        puts "First create a stations, stations count: #{@stations.count}"
      end
      puts ''
    
    # Show train list on station
    when '8'
      puts ''
      if @stations.any? && @trains.any?
        station_index = Helper.choose_a_station(@stations)
        
        # взял станцию
        station = @stations[station_index]
        # нашел грузовые поезда (cargo)
        cargo = station.trains_by_type('cargo')
        # нашел пассажирские поезда (passenger)
        passenger = station.trains_by_type('passenger')
        
        puts 'There are no cargo trains at this station.' unless cargo.any?
        puts 'There are no passenger trains at this station.' unless passenger.any?
        
        if cargo.any?
          puts ''
          puts "Cargo (#{cargo.count})"
          cargo.each { |train| puts " - #{train.number.to_s}" }
          puts ''
        end
        
        if passenger.any?
          puts ''
          puts "Passenger (#{passenger.count})"
          passenger.each { |train| puts " - #{train.number.to_s}" }
          puts ''
        end
      
      else
        puts "First create a stations and train, stations: #{@stations.count}, trains: #{@trains.count}"
      end
  end
  
  break if input == 'q'
end
