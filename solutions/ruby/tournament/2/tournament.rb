class Tournament
  def self.tally(input)
    "#{header}\n#{display(results(input))}"
  end

  class << self
    private

    def header
      "Team                           | MP |  W |  D |  L |  P"
    end

    def display(results)
      return "" if results.nil?

      results
        .sort_by { |r| [-r.points, r.team]  }
        .map { |r| format(r) }
        .join("\n")
        .concat("\n")
    end

    def results(input)
      tally_results(parse_games(input))
    end

    def format(result)
      "%s| %s | %s | %s | %s | %s" % [
        result.team        .ljust(31),
        result.matches.to_s.rjust(2),
        result.wins   .to_s.rjust(2),
        result.draws  .to_s.rjust(2),
        result.losses .to_s.rjust(2),
        result.points .to_s.rjust(2)]
    end

    Game      = Struct.new(:team1, :team2, :result)
    ResultSet = Struct.new(:team, :matches, :wins, :draws, :losses, :points)

    def parse_games(input)
      games = input.split("\n").map do |game|
        parts = game.split(";")
        Game.new(parts[0], parts[1], parts[2])
      end
    end

    def tally_results(games)
      return nil if games.empty?

      get_teams(games)
        .map { |t| ResultSet.new(t, 0, 0, 0, 0, 0) }
        .each do |rs|
          rs.matches = games.count { |g| team_in_game?(rs.team, g) }
          rs.draws   = games_drawn(rs.team, games)
          rs.wins    = games_won(rs.team, games)
          rs.losses  = games_lost(rs.team, games)
          rs.points  = rs.wins * 3 + rs.draws
        end
    end

    def get_teams(games)
      teams = []
      games.each { |g| teams << [g.team1, g.team2] }
      teams.flatten.uniq
    end

    def team_in_game?(team, game)
      team == game.team1 || team == game.team2
    end

    def games_drawn(team, games)
      games.count { |g| team_in_game?(team, g) && g.result == "draw" }
    end

    def games_won(team, games)
      home_games(team, games).count { |g| g.result == "win"  } +
      away_games(team, games).count { |g| g.result == "loss" }
    end

    def games_lost(team, games)
      home_games(team, games).count { |g| g.result == "loss" } +
      away_games(team, games).count { |g| g.result == "win"  }
    end

    def home_games(team, games)
      games.select { |g| g.team1 == team }
    end

    def away_games(team, games)
      games.select { |g| g.team2 == team }
    end
  end
end
