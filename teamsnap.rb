require 'rubygems'
require 'mechanize'

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

class Teamsnap < Mechanize
  TEAMSNAP_EMAIL = "xxxx@yyyy.com"
  TEAMSNAP_PASSWORD = "somepassword"
  TEAM_ID = "12345"

  TEAMSNAP_URL = "http://teamsnap.com"
  LOGIN_URL = "https://go.teamsnap.com/login/signin"
  LOGIN_SUCCESS_URL = Regexp.new('http://go.teamsnap.com/(\d+)/home')
  LOGIN_FAIL_URL = LOGIN_URL
  
  TEAMSNAP_SUCCESS_URL = Regexp.new('http://go.teamsnap.com/(\d+)/home')
  TEAMSNAP_FAIL_URL = "https://go.teamsnap.com/login/signin"
  
  attr_accessor :logged_in
  
  def initialize
    super
  end
    
  def add_game(date, time, opponent, location)    
    login or return false unless self.logged_in
    game_details = {"game[event_date_start_formatted]" => date, "game[event_date_hours]"=> time, "game[opponent_id]"=> opponent, "game[location_id]"=> location, "game[minutes_early]" => '20'}
    #puts game_details.inspect
    post("http://go.teamsnap.com/#{TEAM_ID}/schedule/create_game", game_details)
  end
  
  def add_opponent(name)
    login or return false unless self.logged_in
    post("http://go.teamsnap.com/#{TEAM_ID}/opponent/create", "opponent[opponent_name]" => name)
  end

  def add_location(name)
    login or return false unless self.logged_in
    post("http://go.teamsnap.com/#{TEAM_ID}/location/create", "location[location_name]" => name)
  end


  def see_roster
    login or return false unless self.logged_in
    page = get("http://go.teamsnap.com/#{TEAM_ID}/roster/list")
    puts page.inspect
  end
  

  private
  def login(email=TEAMSNAP_EMAIL, password=TEAMSNAP_PASSWORD)
    @logged_in =  begin
                    post(LOGIN_URL, {"login" => email, "password" => password})
                    pp page
                    if page.uri.to_s =~ LOGIN_SUCCESS_URL
                      true
                    else
                      history.clear
                      false
                    end
                  end
  end
end

