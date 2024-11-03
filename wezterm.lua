-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

local function reverse(list)
  local rev = {}
  for i=#list, 1, -1 do
    rev[#rev+1] = list[i]
  end
  return rev
end

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

-- Function to apply fade effect to tab titles
local function text_gradient(from_color, to_color, length)
  length = length or 4
  local gradient = wezterm.color.gradient({colors={from_color, to_color}, blend='LinearRgb'}, length)

  local faded_text = ""
  for i = 1, length do
    faded_text = faded_text .. wezterm.format({
      {Background = {Color = gradient[i]}},
      {Text = " "}
    })
  end
  return faded_text
end

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  local process_name = basename(tab_info.active_pane.foreground_process_name)
  if process_name == "zsh" then
    return tab_info.active_pane.title
  else
    return process_name
  end
end

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.dpi = 201
-- config.freetype_load_target = "VerticalLcd"

config.window_frame = {
  active_titlebar_bg = "#00ff00",
}

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'BerkeleyMono Nerd Font'
config.font_size = 10

config.use_fancy_tab_bar = false
config.tab_max_width = 26

config.window_frame = {
  font = wezterm.font { family = 'Noto Sans', weight = "Bold" },
  font_size = 12.0,
}
config.enable_scroll_bar = true
config.min_scroll_bar_height = "0.5cell"
config.colors = {
  scrollbar_thumb = "#fff"
}
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- Get the tab title and apply the fade effect
  local title = tab_title(tab)
  local fgColor
  local bgColor
  local textColor
  local length = 4

  if tab.is_active then
    fgColor = config.resolved_palette.tab_bar.active_tab.fg_color
    textColor = config.resolved_palette.tab_bar.active_tab.bg_color
    bgColor = config.resolved_palette.tab_bar.background
  else
    fgColor = config.resolved_palette.tab_bar.inactive_tab.fg_color
    textColor = config.resolved_palette.tab_bar.inactive_tab.bg_color
    bgColor = config.resolved_palette.tab_bar.background
  end

  if hover then
    fgColor = wezterm.color.parse(fgColor)
    fgColor = fgColor:lighten(0.2)
  end

  local full_tab_width = (length * 2 + #title)

  -- wezterm.log_info(title, max_width, full_tab_width)
  if max_width >= full_tab_width then
    return {
      {Text = text_gradient(bgColor, fgColor, length)},
      {Background = {Color = fgColor}},
      {Foreground = {Color = textColor}},
      {Text = title},
      {Text = text_gradient(fgColor, bgColor, length)},
    }
  else
    return {
      {Background = {Color = fgColor}},
      {Foreground = {Color = textColor}},
      {Text = " " .. title .. " "},
    }
  end
end)

config.quote_dropped_files = "SpacesOnly"

config.ssh_domains = {
  {
    name = 'butts',
    remote_address = 'butts.lan',
    username = 'rufo',
    remote_wezterm_path = '/home/linuxbrew/.linuxbrew/bin/wezterm',
  },
}

-- and finally, return the configuration to wezterm
return config
