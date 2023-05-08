local f = {}
local multiplier = 64
local mousearrowpos = {x = 13 * multiplier, y = 3 * multiplier}
local mx, my, mdx, mdy, arrowstick_active, arrowstick_idle
mdx, mdy = 0, 0
local loadQueue = {
	{name = '1', pos = {x = 1, y = 0}, alias = '1'},
	{name = '2', pos = {x = 2, y = 0}, alias = '2'},
	{name = '3', pos = {x = 3, y = 0}, alias = '3'},
	{name = '4', pos = {x = 4, y = 0}, alias = '4'},
	{name = '5', pos = {x = 5, y = 0}, alias = '5'},
	{name = '6', pos = {x = 6, y = 0}, alias = '6'},
	{name = '7', pos = {x = 7, y = 0}, alias = '7'},
	{name = '8', pos = {x = 8, y = 0}, alias = '8'},
	{name = '9', pos = {x = 9, y = 0}, alias = '9'},
	{name = '0', pos = {x = 10, y = 0}, alias = '0'},
	{name = 'q', pos = {x = 1.5, y = 1}},
	{name = 'w', pos = {x = 2.5, y = 1}},
	{name = 'e', pos = {x = 3.5, y = 1}},
	{name = 'r', pos = {x = 4.5, y = 1}},
	{name = 't', pos = {x = 5.5, y = 1}},
	{name = 'y', pos = {x = 6.5, y = 1}},
	{name = 'u', pos = {x = 7.5, y = 1}},
	{name = 'i', pos = {x = 8.5, y = 1}},
	{name = 'o', pos = {x = 9.5, y = 1}},
	{name = 'p', pos = {x = 10.5, y = 1}},
	{name = 'a', pos = {x = 2, y = 2}},
	{name = 's', pos = {x = 3, y = 2}},
	{name = 'd', pos = {x = 4, y = 2}},
	{name = 'f', pos = {x = 5, y = 2}},
	{name = 'g', pos = {x = 6, y = 2}},
	{name = 'h', pos = {x = 7, y = 2}},
	{name = 'j', pos = {x = 8, y = 2}},
	{name = 'k', pos = {x = 9, y = 2}},
	{name = 'l', pos = {x = 10, y = 2}},
	{name = 'z', pos = {x = 2.5, y = 3}},
	{name = 'x', pos = {x = 3.5, y = 3}},
	{name = 'c', pos = {x = 4.5, y = 3}},
	{name = 'v', pos = {x = 5.5, y = 3}},
	{name = 'b', pos = {x = 6.5, y = 3}},
	{name = 'n', pos = {x = 7.5, y = 3}},
	{name = 'm', pos = {x = 8.5, y = 3}},
	{name = 'space', pos = {x = 3, y = 4}},
	{name = 'tab', pos = {x = 0, y = 1}},
	{name = 'lshift', pos = {x = 0, y = 3}},
	{name = 'lcontrol', pos = {x = 0, y = 4}},
	{name = 'lgui', pos = {x = 1, y = 4}},
	{name = 'lalt', pos = {x = 2, y = 4}},
	{name = 'capslock', pos = {x = 0, y = 2}},
	{name = 'space', pos = {x = 3, y = 4}},
	{name = 'lclick', pos = {x = 12, y = 0}},
	{name = 'mclick', pos = {x = 13, y = 0}},
	{name = 'wheelup', pos = {x = 13, y = 1}},
	{name = 'wheeldown', pos = {x = 13, y = 1.5}},
	{name = 'rclick', pos = {x = 14, y = 0}},
}
local pressed = {}
drawCalls = {}

function f.load()
	arrowstick_active = love.graphics.newImage('mouse_active.png')
	arrowstick_idle = love.graphics.newImage('mouse_idle.png')
	for i,v in ipairs(loadQueue) do
		local x, y, drawable, name, up, down, alias, func, info
		if type(loadQueue[i]) == 'table' then
			if loadQueue[i].name then
				name = tostring(loadQueue[i].name)
				alias = name
			end
			if type(loadQueue[i].pos) == 'table' then
				x = (loadQueue[i].pos.x * multiplier)or 0
				y = (loadQueue[i].pos.y * multiplier) or 0
			end
			if type(loadQueue[i].alias) == 'string' then
				alias = tostring(loadQueue[i].alias)
			end
			target = alias
			info = love.filesystem.getInfo(tostring(alias)..'_up.png')
			info = love.filesystem.getInfo(tostring(alias)..'_down.png')
			if not info then
				target = 'err'
			end
			if not info then
				target = 'err'
			end
			up = love.graphics.newImage(tostring(target)..'_up.png')
			down = love.graphics.newImage(tostring(target)..'_down.png')
			drawable = up
			func = function()
				if type(pressed) == 'table' then
					if pressed[alias] == true then
						drawable = down
					else
						drawable = up
					end
					love.graphics.draw(drawable, x, y)
				end
			end
			table.insert(drawCalls, func)
			pressed[alias] = false
		end
	end
end

function f.draw()
	for i,v in ipairs(drawCalls) do
		if type(v) == 'function' then
			pcall(v)
		end
	end
	local drawable = arrowstick_idle
	if mdx == 0 and mdy == 0 then
	else
		drawable = arrowstick_active
	end
	local capx, capy = (mdx * 3), (mdy * 3)
	if math.abs(capx) > 64*1 then
		if capx > 0 then
			capx = 64*1
		else
			capx = -(64*1)
		end
	end
	if math.abs(capy) > 64*1 then
		if capy > 0 then
			capy = 64*1
		else
			capy = -(64*1)
		end
	end

	local x, y = (mousearrowpos.x + capx), (mousearrowpos.y + capy)
	love.graphics.draw(drawable, x, y)
	pressed['wheelup'] = false
	pressed['wheeldown'] = false
	mdx, mdy = 0, 0
end

function f.keypressed(key)
	pcall(
		function()
			pressed[tostring(key)] = true
		end)
end

function f.keyreleased(key)
	pcall(
		function()
			pressed[tostring(key)] = false
		end)
end

function f.mousemoved(x, y, dx, dy, istouch)
	mx = x
	my = y
	mdx = dx
	mdy = dy
end

return f