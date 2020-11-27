displays = nil

function dockMover()
  local newDisplays = hs.screen.screenPositions()
  local dockOnBottom = false
  if displays == newDisplays then
    return
  end
  displays = newDisplays
  
  for screen, position in pairs(displays) do
    if position.x > 0 then
      dockOnBottom = true
    end
  end
  
  if dockOnBottom then
    hs.alert.show("move dock to bottom")
    hs.osascript.applescript([[ tell application "System Events"
      tell dock preferences
        set properties to {screen edge: bottom, autohide: true}
      end tell
    end tell ]])
  else
    hs.alert.show("move dock to right")
    hs.osascript.applescript([[ tell application "System Events"
      tell dock preferences
        set properties to {screen edge: right, autohide: false}
      end tell
    end tell ]])
  end

  local shouldStartSynergy = false

  hs.timer.doAfter(1, function()
    synergyStarter(shouldStartSynergy)
  end)

  if #displays == 1 then
    if string.find(displays[1].name, "LG HDR 4K") then
      for interface, ip in pairs(hs.network.addresses()) do
        if string.find(ip, "192.168.212.") then
          print("found ip")
          hs.network.ping("192.168.212.117", 3, 0.2, 0.2, "any", function(obj, msg, sn, err)
            print("pingCallback")
            if msg == "receivedPacket" then
              shouldStartSynergy = true
            end
          end)
          break
        end
      end
    end
  end
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
