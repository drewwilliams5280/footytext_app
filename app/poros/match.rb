class Match
  attr_reader :home_team,
              :away_team,
              :home_score,
              :away_score,
              :status
  def initialize(match_info, player_info)
    @home_team = match_info[:homeTeam][:team_name]
    @away_team = match_info[:awayTeam][:team_name]
    @home_score = match_info[:goalsHomeTeam]
    @away_score = match_info[:goalsAwayTeam]
    @status = match_info[:statusShort]
    @player_info = player_info
  end

  def format
    "Home: #{@home_team} Away: #{@away_team}\nScore: #{@home_score}-#{@away_score} #{@status}\nGoals: #{format_goals}"
  end

  def goals
    @player_info.find_all do |player|
      player[:goals][:total] > 0
    end
  end

  def format_goals
    goals.map do |player|
      "#{player[:player_name]} #{player[:goals][:total]}"
    end.join(", ")
  end
end