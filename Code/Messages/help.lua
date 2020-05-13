function DifferentHelps(words, message)
  
  if words[1] == "joke" then
    message:reply(":question: **Jokes help list** :question:\n``+joke random`` --Chooses a random joke\n``+joke wow`` --Chooses a random world of warcraft related joke\n``+joke lol`` --Chooses a random league of legends related joke")
    
  elseif words[1] == "profile" then  
    message:reply(":question: **Profile help list** :question:\n``+profile check`` --Shows the user profile, if one doesnt exist yet then it will create a new one\n``+profile write (bio or desc or description) {write whatever you want here}`` --Changes the user description into its custom caption")
    
    
  
  
  
  
  
  elseif words[1] == nil then
  
    message:reply(":question: **Help list** :question:\n``+help joke`` --Show all jokes commands\n``+help profile`` --Show all profile commands\n``+help test``--yet to set")
  
  end
  
  
end  














