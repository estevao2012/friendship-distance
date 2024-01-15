require 'rails_helper'

RSpec.describe Application::Friendship::Services::ShortPathCalculator do
  subject { Application::Friendship::Services::ShortPathCalculator.new }

  describe 'dijkstra' do
    it 'performs dijkstra' do
      # Define a graph using an adjacency list
      # Using same weight since friendship_repository won't calc weights
      graph = {
        'A' => { 'B' => 1, 'C' => 1 },
        'B' => { 'A' => 1, 'C' => 1, 'D' => 1 },
        'C' => { 'A' => 1, 'B' => 1, 'D' => 1 },
        'D' => { 'B' => 1, 'E' => 1 },
        'E' => {}
      }

      # Test the function with node 'A' as the starting point
      expect(subject.dijkstra(graph, 'A')).to eq({"A"=>0, "B"=>1, "C"=>1, "D"=>2, "E" => 3})
      expect(subject.dijkstra(graph, 'B')).to eq({"A"=>1, "B"=>0, "C"=>1, "D"=>1, "E" => 2})
      expect(subject.dijkstra(graph, 'C')).to eq({"A"=>1, "B"=>1, "C"=>0, "D"=>1, "E" => 2})
      expect(subject.dijkstra(graph, 'D')).to eq({"A"=>2, "B"=>1, "C"=>2, "D"=>0, "E" => 1})
      expect(subject.dijkstra(graph, 'E')).to eq({
        "A"=>Float::INFINITY,
        "B"=>Float::INFINITY,
        "C"=>Float::INFINITY,
        "D"=>Float::INFINITY,
        "E" => 0
      })
    end

    it 'performs other case' do
      graph = {
        "17" => {"19"=>1},
        "19" => {"20"=>1},
        "20" => {"18"=>1},
        "18" => {}
      }

      expect(subject.dijkstra(graph, '17')).to eq({"17"=>0, "19"=>1, "20"=>2, "18"=>3})
    end
  end
end
