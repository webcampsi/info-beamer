gl.setup(1920, 864)

local json = require"json"

local base_time = N.base_time or 0

local line
local fade_start
local current_talk = nil

function cluttered()
	local all_breaks = '/.-{}()[]<>|,;!? '
	local breaks = {}
	for idx = 1, #all_breaks do
		breaks[all_breaks:sub(idx, idx)]=true
	end

	local next_change
	local start
	local duration
	local start_text
	local end_text
	local text

	local function go(s, e, d)
		start_text = s
		end_text = e
		start = sys.now()
		duration = d
		text = start_text
	end

	local function speed(t)
		return math.pow((math.sin(t / duration * math.pi)+1) / 2, 2)
	end

	local function next_time()
		next_change = sys.now() + speed()
	end

	local function get()
		if not start then
			return ""
		end
		local t = sys.now() - start
		if t > duration then
			return end_text
		end
		local s = speed(t)
		local spread = math.max(math.min(1.0 / duration * t, 1.0), 0)
		local len = #text
		local pos = 0
		text = string.gsub(text, "(.)", function (x)
			pos = pos + 1
			local r = math.random()
			if t < duration / 2 then
				if r < s / #start_text * spread  then
					local p = math.random(1, #all_breaks)
					return all_breaks:sub(p,p)
				elseif r < s / #start_text then
					local p = math.random(1, #start_text)
					return start_text:sub(pos,pos)
				else
					return
				end
			else
				if r < s / #end_text * (1 - spread) then
					local p = math.random(1, #all_breaks)
					return all_breaks:sub(p,p)
				elseif r < s / #end_text then
					return end_text:sub(pos, pos)
				else
					return
				end
			end
		end)
		return text
	end
	return {
		go = go;
		get = get;
	}
end

function wrap(str, limit, indent, indent1)
	limit = limit or 72
	local here = 1
	local wrapped = str:gsub("(%s+)()(%S+)()", function(sp, st, word, fi)
		if fi-here > limit then
			here = st
			return "\n"..word
		end
	end)
	local splitted = {}
	for token in string.gmatch(wrapped, "[^\n]+") do
		splitted[#splitted + 1] = token
	end
	return splitted
end


function start_anim()
	local duration = 5
	line = cluttered()
	line.go(
		"E.M/B.R-A[C/E]-CO-/N.S/[T/R].A./I-/.N/T/S.",
		current_talk.title,
		duration
	)
	fade_start = sys.now() + (duration/1.5)
end

function check_next_talk()
	local now = base_time + sys.now()
	local lineup = {}
	local found = false
	for idx, talk in ipairs(talks) do
		if talk.room == room then
			if talk.start < now and talk.stop > now then
				local changed = talk ~= current_talk
				if changed then
					current_talk = talk
					start_anim()
				end
				return
			end
		end
	end
	current_talk = nil
	line = nil
end

util.data_mapper{
	["clock/set"] = function(time)
		base_time = tonumber(time) - sys.now()
		N.base_time = base_time
		print("UPDATED TIME", base_time)
		check_next_talk()
	end;
}

util.file_watch("schedule.json", function(content)
	talks = json.decode(content)
	check_next_talk()
end)

util.file_watch("room", function(content)
	room = content:match'^%s*(.*%S)' or ''
	check_next_talk()
end)
pp(room)

check_next_talk()

bold = resource.load_font("OpenSans-Bold.ttf")
regular = resource.load_font("OpenSans-Regular.ttf")

function node.render()
	gl.clear(0, 0, 0, 0)

	if line then
		bold:write(75, 150, line.get(), 80, .99, .72, .07, 1)
	end

	local alpha = 0
	if fade_start and sys.now() > fade_start then
		alpha = 1.0 / 3 * (sys.now() - fade_start)
		alpha = math.min(alpha, 1.0)
	end

	if current_talk then
		regular:write(200, 400, current_talk.nice_start, 60, 1, 1, 1, alpha)
		bold:write(400, 393, current_talk.speaker, 70, 1, 1, 1, alpha)
		if current_talk.subtitle then
			bold:write(75, 250, current_talk.subtitle, 80, .99, .72, .07, alpha)
		end
	end
end
