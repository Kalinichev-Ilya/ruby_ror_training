require 'spec_helper'
require_relative '../app/route'

describe Route do
  before :all do
    @route = Route.new('Moscow', 'Spb')
  end

  it 'got station' do
    expect(@route.add_station('Velikiy Novgorod')).to eq @route.stations
  end

  it 'delete station' do
    @route.delete_station 'Velikiy Novgorod'
    expect(@route.stations).to eq %w[Moscow Spb]
  end

  it 'cant delete first station' do
    expect(@route.delete_station('Moskow')).to eq nil
  end

  it 'cant delete last station' do
    expect(@route.delete_station('Spb')).to eq nil
  end
end
