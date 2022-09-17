
local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


StartTimer = function()
    Citizen.CreateThread(function()
          while true do
              Citizen.Wait(60000)
        local xPlayers = ESX.GetPlayers()
        for _, xPlayer in pairs(xPlayers) do
          MySQL.Async.fetchAll('SELECT * FROM users WHERE vrijeme = vrijeme', {
          }, function(result)
              if result then
                  MySQL.Sync.execute(
                      'UPDATE users SET vrijeme = vrijeme + 1',
                      {
          
                         
                      }
                  )	
          
              end
          end)
        end
      end
    end)
end
  
  
StartTimer()
  
  
  
  
RegisterCommand('onlinetime', function(source)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local rez = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @notw', {
        ['@notw'] = xPlayer.identifier
    })
    for i=1, #rez, 1 do
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 1vw; margin: 0.5vw; background-image: linear-gradient(to right, #000046, #1cb5e0); border-radius: 10px;"><i class="far fa-envelope"></i> Earth Development:<br> {0}</div>',
      args = { 'You have '..rez[i].time..' minutes' } 
    })
    end
end)
  