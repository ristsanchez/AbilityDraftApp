from code import interact
import requests 

abilities = 'http://cdn.dota2.com/apps/dota2/images/abilities/riki_backstab_lg.png'

hero = 'https://api.steampowered.com/IEconDOTA2_570/GetHeroes/v0001/?key=D53FE560AEBBD9A3A3EE066E90C7C16D&language=en_us&format=JSON' 
# {
# "name":"npc_dota_hero_axe",
# "id":2,
# "localized_name":"Axe"
# },
img = 'https://cdn.dota2.com/apps/dota2/images/heroes/axe_full.png'


url = 'https://api.steampowered.com/IEconDOTA2_570/GetHeroes/v0001/?key=D53FE560AEBBD9A3A3EE066E90C7C16D&language=en_us&format=JSON' 
response = requests.get(url)        # To execute get request 
print(response.status_code)     # To print http response code  
print(response.text)



# MATCH history
all = "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?format=JSON&language=en_us&key=D53FE560AEBBD9A3A3EE066E90C7C16D"
STEAM_WEB_API = "https://api.steampowered.com/{interface}/{resource}/V001/?format=JSON&language=en_us&key={api_key}"

interface = "IDOTA2Match_570"
resource = "GetMatchHistory" # or gethero or other shit

# match details
details = 'https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=D53FE560AEBBD9A3A3EE066E90C7C16D&match_id=6434722715'
sample = 'https://www.opendota.com/matches/6298733250/overview'
# https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?format=JSON&language=en_us&key=D53FE560AEBBD9A3A3EE066E90C7C16D&game_mode=18
# https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?format=JSON&language=en_us&key=D53FE560AEBBD9A3A3EE066E90C7C16D
# https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=D53FE560AEBBD9A3A3EE066E90C7C16D&match_id=6298733250

6434847199

# https://api.opendota.com/api/matches/{match_id}