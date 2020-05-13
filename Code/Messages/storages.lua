
--//Exp table\\--
local expTable = nil


function CheckIfUserAndOrGuildExists(guild, author)
  
  local userId = author.id
  
   --Create guild if it didnt exist yet
  if expTable[tostring(guild.id)] == nil then
    expTable[tostring(guild.id)] = {}
  end
  
  --check if the user has any profile info

  if expTable[tostring(guild.id)][tostring(userId)] == nil then
    expTable[tostring(guild.id)][tostring(userId)] = {
      exp = 0,
      name = author.name,
      level = 1,
      description = "Use <yahiro desc [custom message]>",
      coins = 0,
      reputation = 0,
      achievements = {},
      status = "",
      emptyvalue = nil,
      emptyvalue2 = nil
    }
  end
end  


function GiveExp(guild, author, amount)

  local userId = author.id
  
  CheckIfUserAndOrGuildExists(guild, author)
  
  --check if the user has any profile info
    if expTable[tostring(guild.id)][tostring(userId)].exp == nil then
      expTable[tostring(guild.id)][tostring(userId)].exp = amount
      
    else  
      expTable[tostring(guild.id)][tostring(userId)].exp = expTable[tostring(guild.id)][tostring(userId)].exp + amount
    end  
     

  
end  

local test = {
  a = 2,
  b= 5,
  c = 1,
  d = 3,
  e = 7
  
  }

function SortArraysInPairs(array)
  local TableHolder = {}
  local holder = {}
  local SaveIndexs = {}
  
  
  local number = 1
  for i,v in pairs(array) do
    table.insert(TableHolder, v)
    SaveIndexs[i] = v
    number = number + 1
  end  
  table.sort(TableHolder)
 


  for n, v in pairs(TableHolder) do 
    
    for i, k in pairs(SaveIndexs) do
      local bool = false
      if v == k then
        
        for h, m in pairs(holder) do
          if m.index == i then
            bool = true
          end  
        end  
        
        if bool == false then
          table.insert(holder, {index = i, result = v})
        end
        
      end  
    end  
  end


  return holder
end 


function SendLeaderBoard(message, discordia, words, page)
  
  local TableToString = ""
  local GuildId = message.guild.id
  local UserId = message.author.id
  local temporaryTable = {}
  
  for i, k in pairs(expTable[GuildId]) do
    local UserName = message.guild.members:toArray()
   
      for ii, v in pairs(UserName) do
  
        if i == v.id then
            temporaryTable[v.name] = k.exp
        end
           
      end  

  end  
  
  local result = SortArraysInPairs(temporaryTable)
  local ff = {}
  
  local PP = page * 10

for i = PP-10, PP - 1 do
  if i < #result then
    local NewTable = {name = tostring(i + 1)..". "..result[#result - i].index, value = result[#result - i].result.." exp", inline = false}
    table.insert(ff, NewTable)
  end
end  

      message:reply({embed = {
      title = "Exp leaderboards",
      color = discordia.Color.fromRGB(152, 0, 222).value,
      description = "Top 10 users of page "..page..":",
      
      fields = ff
      
      }})
  
end  


function GetExpTable(id)
  if expTable ~= nil then
    
    return expTable
    
  else
    return "Table not found!"
  end
end

function StoragesUponStart()
  
  expTable = LoadExp()  
  

end