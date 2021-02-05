class FootyService
  def self.get_match_info(team_id)
    to_json("https://api-football-v1.p.rapidapi.com/v2/fixtures/team/#{team_id}/last/1")
  end

  def self.get_player_info(fixture_id)
    to_json("https://api-football-v1.p.rapidapi.com/v2/players/fixture/#{fixture_id}")
  end

  def self.to_json(url)
    response = Faraday.get(
      url, {},
      {'x-rapidapi-host' => 'api-football-v1.p.rapidapi.com',
      'x-rapidapi-key' => ENV['FOOTY_API_KEY']}
    )
    JSON.parse(response.body, symbolize_names: true)
  end
end