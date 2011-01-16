A sample use in add_games.rb

Steps are:
1. Add opponents 
2. Add venues
3. Find teamsnap-generated ids for venues and oppenents from their HTML (go to create game page, and view HTML), 
   and add these as hashes in your add_games.rb
4. Create a file with the list of games with date, time, opponent
5. run a version of add_games.rb

# 
# tm = Teamsnap.new
#
#  Add teams
# teams = ["Berkeley Jets", "Blue Notes", "Booty Booty", "Galacticos", "Mallards", "The Big Gs", "Twin Castle Utd"]
# teams.each {|o| tm.add_opponent(o)}
# venues = ['Bates Grass (W)', "Bates Turf (N)", "Bates Turf (S)", "Cougar Field"]
# venues.each {|v| tm.add_location(v)}
#
# Then you have to figure out what IDs teamsnap has assigned to the teams and locations, stick them into a hash like so:
#
#
# teams = {
#   "Berkeley Jets" => "197386",
#   "Blue Notes" => "199991",
#   "Booty Booty" => "199992",
#   "Galacticos" => "199993",
#   "Mallards" => "199994",
#   "Scrimmage" => "186955",
#   "testing" => "192975",
#   "The Big Gs" => "199995",
#   "Twin Castle Utd" => "199996"
# }
# 
# venues = {
#   "Bates Grass (W)" => "168865",
#   "Bates Turf (S)" => "168867",
#   "Bates Turf (N)" => "166575",
#   "Campo Lindo High School" => "157177",
#   "Cougar Field"=> "168868"
# }

# Games are in a file like this:
#
# 09/12/2010	17:00	Bates Turf (S)	Booty Booty	
# 09/19/2010	13:00	Cougar Field	The Big Gs
# 09/24/2010	19:00	Bates Turf (N)	Twin Castle Utd	
# 09/26/2010	13:00	Bates Grass (W)	Mallards
# 10/03/2010	17:00	Bates Turf (N)	Blue Notes

# games_raw = File.open('games.txt').readlines
# games = games_raw.collect {|g| g.chomp.split(/\t/)}
# 
# games.each do |date, time, venue, opponent|
#   venue_id = venues[venue]
#   opponent_id = teams[opponent]
#   puts "Would add game at #{venue}(#{venue_id}) vs #{opponent}(#{opponent_id}) on #{date} #{time}"
#   tm.add_game(date, time, opponent_id, venue_id)
# end
# 
