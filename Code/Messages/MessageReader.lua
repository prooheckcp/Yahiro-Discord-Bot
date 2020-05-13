--require("../../../main.lua")



--//requires\\--
local prefix = nil
local discordia = nil

--//Lists\\--
local jokes = "joke"
local profiles = "profile"
local helps = "help"
local time = "time"

function SetVariables(PreF, dd)
  prefix = PreF
  discordia = dd
end  


local function CutText(phrase)
  
  local words = {}
  
  for word in string.gmatch(tostring(phrase),  "[^%s,]+") do --"%a+"
    table.insert(words, word)
  end
  
  return words
  
end  

local XPperMessageCooldowns = {}
function MessageFilter(message)
  
  if message.content == "" or message.author.bot or string.sub(message.content, 1, 1) == "?" or string.sub(message.content, 1, 1) == "!" or string.sub(message.content, 1, 1) == "$" then
    return;
  end  
    
  
  local words = CutText(message.content)
  
  
  --Add the xp per message here--
  if XPperMessageCooldowns[tostring(message.author.id)] == nil then
    
    XPperMessageCooldowns[tostring(message.author.id)] = 40 --Cooldown seconds
    
    GiveExp(message.guild, message.author, 2) --Give the exp to the user
  end
  -------------------------------
  
  if message.author.bot then --Change to bot type? 
    return
  end
  

  if prefix ~= nil and words ~= nil then
    if string.lower(string.sub(words[1], 1, #prefix)) == prefix then
      words[1] = string.sub(words[1], #words[1] - #words[1] + 2, #words[1])
      local list = words[1]
      table.remove(words, 1)
      ChooseAction(list, words, message)
    end
  end  

  
end




function LowerCooldowns()
  for i, k in pairs(XPperMessageCooldowns) do
    
    if k >= 1 then
      
      XPperMessageCooldowns[i] = XPperMessageCooldowns[i] - 1
    
    else
      XPperMessageCooldowns[i] = nil
    end  
    
  end  
end  


function ChooseAction(list, words, message)
  
  CheckIfUserAndOrGuildExists(message.guild, message.author)
  local array = GetExpTable()
  
  --Avoid the bot from crashing if the next word is nill UwU
  if words[1] == nil then
    message:reply("Yes?")
    return
  end  

  --Show the top users of the server
  if string.lower(words[1]) == "leaderboard" then
    
    if words[2] == nil then
      SendLeaderBoard(message, discordia, words, 1)
      return
    elseif string.lower(words[2]) == "page" and words[3] == nil then
      SendLeaderBoard(message, discordia, words, 1)
      print("2")
    elseif string.lower(words[2]) == "page" and tonumber(words[3]) == nil then
      SendLeaderBoard(message, discordia, words, 1)
    elseif string.lower(words[2]) == "page" and tonumber(words[3]) ~= nil then
      SendLeaderBoard(message, discordia, words, tonumber(words[3]))
    end
    
  end
  

  --Random coin flip
  if string.lower(words[1]) == "coin" and words[2] ~= nil then
    if string.lower(words[2]) == "flip" then
      CoinFlip(message)
    end
  end  

  --Random number between 1 and 6
  if string.lower(words[1]) == "dice" and words[2] ~= nil then
    if string.lower(words[2]) == "roll" then
      DiceRoll(message)
    end  
  end 

  --Give exp because why not XD
  if string.lower(words[1]) == "exp" then
   -- GiveExp(message.guild, message.author, 20) --not active to avoid autism
  end  
  
  local UserID = tostring(message.author.id)
  if string.lower(words[1]) == "forcedsave" and (message.author.id == "236943791070773270" or message.author.id == "609169128053538855") then
    print("saved")
    SaveExp()
  end  
  
  if string.lower(words[1]) == "profile" then
    
    message:reply({embed = {
      title = message.author.name,
      color = discordia.Color.fromRGB(0, 98, 255).value,
      description = array[tostring(message.guild.id)][tostring(message.author.id)].description,
      
      fields = {
        {name = ":chart_with_upwards_trend: Exp:", value = array[tostring(message.guild.id)][tostring(message.author.id)].exp, inline = true}
        }
      
      }})
  end  

  if string.lower(words[1]) == "desc" then
    
    local newinfo = ""
    for i = 2, #words do
      newinfo = newinfo.." "..words[i]
    end  
    
    array[tostring(message.guild.id)][tostring(message.author.id)].description = newinfo
    
    message:reply("Your description has been updated to: **"..newinfo.."**")
    
  end  

end  









