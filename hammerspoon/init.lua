Displays = nil

function Tablelength(T)
  local count = 0
  assert(type(T) == "table", "argument was not a table")
  for _ in pairs(T) do count = count + 1 end
  return count
end

function DockMover()
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

  if Tablelength(Displays) == 1 then
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
              SynergyStarter(shouldStartSynergy)
            end
          end) -- ping callback
          break -- break lan IP check
        end -- LAN ip check
      end -- ip address lookup
    end -- display name if
  end -- display tablelength

  SynergyStarter(shouldStartSynergy)
end

function SynergyStarter(shouldStartSynergy)
  if shouldStartSynergy then
    print("synergy should start")
    local pid = hs.execute("pgrep synergyc")
    if (pid == nil or pid == '') then
      print(hs.execute("/Applications/Synergy.app/Contents/MacOS/synergyc --debug INFO --name Rufos-MBP.lan --enable-drag-drop --enable-crypto --tls-cert /Users/rufo/Library/Synergy/SSL/Synergy.pem --log /tmp/synergy.log 192.168.212.117:24800"))
      print("synergy started")
    end
  else
    print("synergy should end")
    print(hs.execute("killall synergyc"))
    print("synergy should be killed")
  end
end

DockMoverWatcher = hs.screen.watcher.new(DockMover)
DockMoverWatcher:start()

function Dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. Dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

hs.loadSpoon('ControlEscape'):start() -- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon
