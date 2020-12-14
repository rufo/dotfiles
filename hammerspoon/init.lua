displays = nil

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function dockMover()
--  local newDisplays = hs.screen.screenPositions()
--  local dockOnBottom = false
--  if displays == newDisplays then
--    return
--  end
--  displays = newDisplays
--  
--  for screen, position in pairs(displays) do
--    if position.x > 0 then
--      dockOnBottom = true
--    end
--  end
--  
--  if dockOnBottom then
--    hs.alert.show("move dock to bottom")
--    hs.osascript.applescript([[ tell application "System Events"
--      tell dock preferences
--        set properties to {screen edge: bottom, autohide: true}
--      end tell
--    end tell ]])
--  else
--    hs.alert.show("move dock to right")
--    hs.osascript.applescript([[ tell application "System Events"
--      tell dock preferences
--        set properties to {screen edge: right, autohide: false}
--      end tell
--    end tell ]])
--  end

  local shouldStartSynergy = false

  if tablelength(displays) == 1 then
    print("one display found, continuing")
    local display = hs.screen.primaryScreen()
    if string.find(display:name(), "LG HDR 4K") then
      print("found LG display, continuing")
      for interface, ip in pairs(hs.network.addresses()) do
        if string.find(ip, "192.168.212.") then
          print("found LAN ip, pinging")
          hs.network.ping("192.168.212.117", 3, 0.2, 0.2, "any", function(pingObj, msg, sn, err)
            if msg == "receivedPacket" then
              print("got ping back")
              shouldStartSynergy = true
              pingObj:cancel()
            elseif msg == "didFinish" then
              synergyStarter(shouldStartSynergy)
            end
          end) -- ping callback
          break -- break lan IP check
        end -- LAN ip check
      end -- ip address lookup
    end -- display name if
  end -- display tablelength
end

function synergyStarter(shouldStartSynergy)
  if shouldStartSynergy then
    print("synergy should start")
  else
    print("synergy should end")
  end
end

dockMoverWatcher = hs.screen.watcher.new(dockMover)
dockMoverWatcher:start()

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

hs.loadSpoon('ControlEscape'):start() -- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon
