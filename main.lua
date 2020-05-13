---------------// Librarys \\---------------
local discordia = require('discordia')
local client = discordia.Client()
local class = discordia.class
local coro = require("coro-http")
local json = require("Code/Librarys/json")
local https = require('https')


require("Code/Messages/MessageReader")
require("Code/Messages/help")
require("Code/Messages/jsonSystem")
require("Code/Messages/storages") --Json Storages functions
require("Code/Messages/randombased")
--------------------------------------------

--// Variables \\--
local prefix = "yahiro"
local startBot = 0
local minutesBot = 0
-------------------

--//functions\\--
SetVariables(prefix, discordia)


function CountTimePerSecond()
  
  startBot = startBot + 1
  
  LowerCooldowns()
  
  
  if math.floor(startBot/60) ~= minutesBot then
    minutesBot = math.floor(startBot/60)
    
    
    if minutesBot/5 == math.floor(minutesBot/5) then
      SaveExp()
      print(SaveExp())
    end  
    
  end  
  
  


end


function start(event)
  
  client:setGame("Yahiro's route")
  UpdateJsonVariables("Storages/UserExp.json", json)
  StoragesUponStart()
  
  
  
  local clock = discordia.Clock()
  clock:start()
  clock:on('sec', CountTimePerSecond)
 

end
-----------------

-- clock:on('sec', test)
--//Events\\--

  
  
  
client:on('messageCreate', MessageFilter)
client:on("ready", start)
--------------

--//Start the bot\\--
client:run('Bot Njg0NDUxODg4MzAwOTQ5NTI5.Xl6xSA.8-qdyAoasGyD2q7RU8aaX_oAAro')
---------------------
