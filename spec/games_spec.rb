# game_spec.rb

require 'rspec'
require_relative '../classes/games'

describe Game do
  let(:current_year) { 2023 }
  let(:last_played_at) { Time.new(current_year - 3, 1, 1) }

  subject(:game) do
    Game.new(
      multiplayer: true,
      last_played_at: last_played_at,
      publish_date: '2010-01-01'
    )
  end

  describe '#to_json' do
    it 'returns a valid JSON representation' do
      json_result = game.to_json
      parsed_json = JSON.parse(json_result)

      expect(parsed_json).to include(
        'id' => game.id,
        'publish_date' => game.publish_date,
        'multiplayer' => game.multiplayer,
        'author' => game.author
      )
    end
  end
end
