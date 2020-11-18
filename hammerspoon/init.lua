displays = nil

dockMover = hs.screen.watcher.new(function()
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
end)

--dockMover:start()

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
