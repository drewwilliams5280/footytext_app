class FootyFacade
  def self.get_match_info(team_id)
    match_info = FootyService.get_match_info(team_id)[:api][:fixtures].first
    player_info = FootyService.get_player_info(match_info[:fixture_id])[:api][:players]
    Match.new(match_info, player_info)
  end
end