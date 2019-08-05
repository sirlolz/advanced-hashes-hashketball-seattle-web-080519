require "pry"
def game_hash
hasketball = {
  :home => {
    :team_name => "Brooklyn Nets",
    :colors => ["Black", "White"],
    :players => [
      { :player_name => "Alan Anderson",
        :number => 0,
        :shoe => 16,
        :points => 22,
        :rebounds => 12,
        :assists => 12,
        :steals => 3,
        :blocks => 1,
        :slam_dunks => 1
      },
      { :player_name => "Reggie Evans",
        :number => 30,
        :shoe => 14,
        :points => 12,
        :rebounds => 12,
        :assists => 12,
        :steals => 12,
        :blocks => 12,
        :slam_dunks => 7
      },
      { :player_name => "Brook Lopez",
        :number => 11,
        :shoe => 17,
        :points => 17,
        :rebounds => 19,
        :assists => 10,
        :steals => 3,
        :blocks => 1,
        :slam_dunks => 15
      },
      { :player_name => "Mason Plumlee",
        :number => 1,
        :shoe => 19,
        :points => 26,
        :rebounds => 11,
        :assists => 6,
        :steals => 3,
        :blocks => 8,
        :slam_dunks => 5
      },
      { :player_name => "Jason Terry",
        :number => 31,
        :shoe => 15,
        :points => 19,
        :rebounds => 2,
        :assists => 2,
        :steals => 4,
        :blocks => 11,
        :slam_dunks => 1
      }
      ]
  },
  :away => {
    :team_name => "Charlotte Hornets",
    :colors => ["Turquoise", "Purple"],
        :players => [
      { :player_name => "Jeff Adrien",
        :number => 4,
        :shoe => 18,
        :points => 10,
        :rebounds => 1,
        :assists => 1,
        :steals => 2,
        :blocks => 7,
        :slam_dunks => 2
      },
      { :player_name => "Bismack Biyombo",
        :number => 0,
        :shoe => 16,
        :points => 12,
        :rebounds => 4,
        :assists => 7,
        :steals => 22,
        :blocks => 15,
        :slam_dunks => 10
      },
      { :player_name => "DeSagna Diop",
        :number => 2,
        :shoe => 14,
        :points => 24,
        :rebounds => 12,
        :assists => 12,
        :steals => 4,
        :blocks => 5,
        :slam_dunks => 5
      },
      { :player_name => "Ben Gordon",
        :number => 8,
        :shoe => 15,
        :points => 33,
        :rebounds => 3,
        :assists => 2,
        :steals => 1,
        :blocks => 1,
        :slam_dunks => 0
      },
      { :player_name => "Kemba Walker",
        :number => 33,
        :shoe => 15,
        :points => 6,
        :rebounds => 12,
        :assists => 12,
        :steals => 7,
        :blocks => 5,
        :slam_dunks => 12
      }
      ]
  }
}
end

def get_players
  players = []
  game_hash.each do |teams, team_data|
    players << team_data[:players]
  end
  players.flatten
end

def num_points_scored(players_name)
  get_players.find {|players| players[:player_name] == players_name}[:points]
end
def shoe_size(players_name)
  return player_stats(players_name)[:shoe]
end
def team_colors(teamname)
  game_hash.each do |place, team|
    if team[:team_name] == teamname
      return team[:colors]
    end
  end
end
def team_names
  team_array = []
  game_hash.each do |place, team|
    team_array.push(team[:team_name])
  end
  return team_array
end
def player_numbers(team_name)
  jersey = []
  game_hash.map do |place, team|
    if team[:team_name] == team_name
      team.each do |attribute, data|
        if attribute == :players
          data.each do |player|
            jersey << player[:number]
          end
        end
      end
    end
  end
  return jersey
end
def player_stats(player_name)
  stats = {}
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.map do |player|
          if player[:player_name] == player_name
            stats = player
          end
        end
      end
    end
  end
 # binding.pry
  return stats.delete_if {|k,v| k == :player_name}
end
def big_shoe_rebounds
  shoe_hash = {}
    game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.each do |player|
          shoe_hash[player[:shoe]] = player[:rebounds]
          #binding.pry
        end
      end
    end
  end
  shoe_hash.max_by {|k, v| k}[1]
end
def most_points_scored
  points_hash ={}
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.each do |player|
          #binding.pry
          points_hash[player[:player_name]] = player[:points]
        end
      end
    end
  end
  points_hash.max_by {|k, v| v}[0]
end

def team_points(team)
  arr = []  
	team.each do |attribute, data|
		if attribute == :players
			data.each do |player|
				arr.push(player[:points])
			end
		end
	end
	arr
end

def winning_team
  home = []
  away = []
  game_hash.each do |place , team|
    if place == :away
      away = team_points(team)
     # binding.pry
    elsif place == :home
      home = team_points(team)
    end
  end
 # binding.pry
  if away.reduce(:+) > home.reduce(:+)
    return game_hash[:away][:team_name]
  else
    return game_hash[:home][:team_name]
  end
end
def player_with_longest_name
  player_l_n = []
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.each do |players|
          players.each do |pdata, pvalue|
            if pdata == :player_name
              player_l_n.push(pvalue)
            end
          end
        end
      end
    end
  end
  player_l_n.max_by(&:length)
end

def long_name_steals_a_ton?
  player_steals = {}
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.each do |player|
          player_steals[player[:player_name]] = player[:steals] 
        end
      end
    end
  end
  if player_steals.max_by{|name, steals| steals}[0] == player_with_longest_name
    return true
  else
    return false
  end
end