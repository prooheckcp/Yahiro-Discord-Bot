function ChooseRandom(array)
  
  
  if #array > 0 then
    local randomFactor = math.random(1, #array)
    return array[randomFactor]
    
  end
end  

local responses = {
  "number...",
  "*yawn* number",
  "Ugggggghhhhh... You're so noisy...number",
  "I think it's a number.",
  "Let's see, number.",
  "My head hurts too much for this. number",
  "number Did things go the way you wanted?",
  "Chill out, okay? Gimme a sec. It's a number",
  "Hmm... Looks like number wins.",
  "What? Oh yeah, the dice roll. number. Totally forgot about that."
  
  }

local coinflipResponses = {
  "Oh, would you look at that, it’s heads",
  "Tails. We’re done here, right?"
  
  }
 
 function CoinFlip(message)
   
   message:reply(ChooseRandom(coinflipResponses))
   
  end 

function DiceRoll(message)
  
  local TheNumber = tostring(math.random(1, 6))
  --ChooseRandom(responses)
  
  
  message:reply(string.gsub(ChooseRandom(responses), "number", "**"..TheNumber.."**"))
end  