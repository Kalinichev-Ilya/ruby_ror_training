require 'spec_helper'
require_relative '../app/station'
require_relative '../app/train'

describe Station do
  before :all do
    @trains = [
      Train.new('NUM111', 'passenger', 10),
      Train.new('NUM122', 'passenger', 5),
      Train.new('NUM113', 'passenger', 15),
      Train.new('NUM222', 'cargo', 10),
      Train.new('NUM122', 'cargo', 1),
      Train.new('NUM322', 'cargo', 20)
    ]
    @train = Train.new('NUM444', 'cargo', 21)
    @station = Station.new('Moscow', @trains)
  end

  it 'have a name' do
    expect(@station.name).to eq 'Moscow'
  end

  it 'there is a trains at the station' do
    expect(@station.trains).to eq @trains
  end

  it 'add a train at the station' do
    expect(@station.add_train(@train)).to eq @trains << @train
  end

  it 'delete a train from the station' do
    @station.move @train
    expect(@station.trains).to eq @trains
  end

  it 'сan determine the number of types by type' do
    cargo = @station.trains_by_type 'cargo'
    expect(cargo.count).to eq 3
  end

  it 'сan be divided into types' do
    cargo = @station.trains_by_type 'passenger'
    expect(cargo.count).to eq 3
  end
end
