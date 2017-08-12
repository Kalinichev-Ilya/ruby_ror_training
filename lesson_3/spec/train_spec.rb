require 'spec_helper'
require_relative '../app/train'
require_relative '../app/route'

describe 'Train' do
  before :all do
    route = Route.new('Moscow', 'Spb')
    route.add_station('Velikiy Novgorod')
    @train = Train.new('NUM123', 'passenger', 10, route)
    @end_station_index = route.stations.count
  end
  
  context 'when does not to go' do
    it 'has a number' do
      expect(@train.number).to eq 'NUM123'
    end
    
    it 'has a type' do
      expect(@train.type).to eq 'passenger'
    end
    
    it 'has a wagons' do
      expect(@train.wagons_count).to eq 10
    end
    
    it 'is standing still' do
      expect(@train.speed).to eq 0
    end
    
    it 'on the first station' do
      expect(@train.station_index).to eq 0
    end
    
    it 'add wagon' do
      expect(@train.add_wagon).to eq 11
    end
    
    it 'remove wagon' do
      expect(@train.remove_wagon).to eq 10
    end
    
    it 'try to find the previous station' do
      expect(@train.previous_station).to eq nil
    end
    
    it 'try to find the next station' do
      expect(@train.next_station).to eq 'Velikiy Novgorod'
    end
  end
  
  context 'when on the road' do
    it 'accelerate on positive value' do
      expect(@train.accelerate(40)).to eq 40
    end
    
    it 'add wagon' do
      expect(@train.add_wagon).to eq nil
    end
    
    it 'remove wagon' do
      expect(@train.remove_wagon).to eq nil
    end
    
    it 'go to the previous station' do
      expect(@train.go_to_the_previous_station).to eq nil
    end
    
    it 'go to the next station' do
      expect(@train.go_to_the_next_station).to eq @train.station_index
    end
    
    it 'accelerate on negative value' do
      expect(@train.accelerate(-50)).to eq 0
    end
    
    it 'can stop' do
      @train.brake
      expect(@train.speed).to eq 0
    end
  end
end
