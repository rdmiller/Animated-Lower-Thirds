--[[
      OBS Studio Lua script : Control the switches of the lower thirds with hotkeys
      Author: NoeAL
      Version: 0.2
      Released: 2020-09-28
--]]


local obs = obslua
local debug
local hk = {}

-- Number of lower thirds, and of memory slots in each one
local LOWER_THIRDS_COUNT = 4
local MEMORY_SLOTS_COUNT = 10

-- Each hotkey flips a variable between 0 and 1 in common/js/hotkeys.js, and the control panel
-- reacts when that variable changes. The hotkey name is what OBS saves the key binding under.
local hotkeys = {}         -- hotkey name -> description shown in the OBS hotkey settings
local hotkey_variable = {} -- hotkey name -> variable in hotkeys.js
local variables = {}       -- variables of hotkeys.js, in the order they are written
local values = {}          -- variable -> 0 or 1

-- if you are extending the script, you can add more hotkeys here
-- then use the variable in the control panel
local function add_hotkey(name, description, variable)
	hotkeys[name] = description
	hotkey_variable[name] = variable
	table.insert(variables, variable)
	values[variable] = 0
end

add_hotkey("A_SWITCH_0_main", "Main Switch", "hotkeyMasterSwitch")
for n = 1, LOWER_THIRDS_COUNT do
	add_hotkey("A_SWITCH_" .. n, "Lower Third Switch #" .. n, "hotkeySwitch" .. n)
end
for n = 1, LOWER_THIRDS_COUNT do
	for slot = 1, MEMORY_SLOTS_COUNT do
		add_hotkey(string.format("LT%d_SLT%02d", n, slot), "Load Slot #" .. slot .. " on LT#" .. n, "hotkeyAlt" .. n .. "Slot" .. slot)
	end
end

-- add any custom actions here
local function onHotKey(action)
	--obs.timer_remove(rotate)
	if debug then obs.script_log(obs.LOG_INFO, string.format("Hotkey : %s", action)) end

	local variable = hotkey_variable[action]
	if variable then
		values[variable] = 1 - values[variable]
		update_hotkeys_js()
	end
end


-- write settings to js file
function update_hotkeys_js()
	local output = assert(io.open(script_path() .. '../common/js/hotkeys.js', "w"))
	for _, variable in ipairs(variables) do
		output:write(variable .. ' = ' .. values[variable] .. ';\n')
	end
	output:close()
end

----------------------------------------------------------

-- called on startup
function script_load(settings)
	function pairsByKeys (t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0
		local iter = function ()
		  i = i + 1
		  if a[i] == nil then return nil
		  else return a[i], t[a[i]]
		  end
		end
		return iter
	end

	for name, line in pairsByKeys(hotkeys) do
		hk[name] = obs.obs_hotkey_register_frontend(name, line, function(pressed) if pressed then onHotKey(name) end end)
		local hotkeyArray = obs.obs_data_get_array(settings, name)
		obs.obs_hotkey_load(hk[name], hotkeyArray)
		obs.obs_data_array_release(hotkeyArray)
	end
	update_hotkeys_js()
end


-- called on unload
function script_unload()
end


-- called when settings changed
function script_update(settings)
	debug = obs.obs_data_get_bool(settings, "debug")
end


-- return description shown to user
function script_description()
	return "Control the switches of the lower thirds with hotkeys"
end


-- define properties that user can change
function script_properties()
	local props = obs.obs_properties_create()
	obs.obs_properties_add_bool(props, "debug", "Debug")
	return props
end


-- set default values
function script_defaults(settings)
	obs.obs_data_set_default_bool(settings, "debug", false)
end


-- save additional data not set by user
function script_save(settings)
	for k, v in pairs(hotkeys) do
		local hotkeyArray = obs.obs_hotkey_save(hk[k])
		obs.obs_data_set_array(settings, k, hotkeyArray)
		obs.obs_data_array_release(hotkeyArray)
	end
end
