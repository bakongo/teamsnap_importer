
require 'teamsnap.rb'

teams = {
  "Berkeley Jets" => "197386",
  "Blue Notes" => "199991",
  "Booty Booty" => "199992",
  "Galacticos" => "199993",
  "Mallards" => "199994",
  "Scrimmage" => "186955",
  "testing" => "192975",
  "The Big Gs" => "199995",
  "Twin Castle Utd" => "199996"
}

venues = {
  "Bates Grass (W)" => "168865",
  "Bates Turf (S)" => "168867",
  "Bates Turf (N)" => "166575",
  "Campo Lindo High School" => "157177",
  "Cougar Field"=> "168868"
}


tm = Teamsnap.new

games_raw = File.open('games.txt').readlines
games = games_raw.collect {|g| g.chomp.split(/\t/)}

games.each do |date, time, venue, opponent|
  venue_id = venues[venue]
  opponent_id = teams[opponent]
  puts "Would add game at #{venue}(#{venue_id}) vs #{opponent}(#{opponent_id}) on #{date} #{time}"
  tm.add_game(date, time, opponent_id, venue_id)
end

