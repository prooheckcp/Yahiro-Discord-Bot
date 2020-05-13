

local expfile = nil
local json = nil

function UpdateJsonVariables(EXP, J)
  expfile = EXP
  json = J
end  


function SaveExp()
  
  local array
  
  if expfile ~= nil and json ~= nil then
    local w = io.open(expfile, "w")
    
    w:write(json.encode(GetExpTable()))
    w:close()
    
    return "Files were saved!"
    
  end  
  
end  

function LoadExp()
  
  local array
  
  if expfile ~= nil and json ~= nil then
    local o = io.open(expfile, "r")
    local r = o:read("*all")
    local JsonIntoLua = json.decode(tostring(r))
    o:close()
    
    return JsonIntoLua
    
  else
    
    return "Error: Json empty or file was deleted"
    
  end
  
  
  
end