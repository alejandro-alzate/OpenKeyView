local f = {}
local multiplier = 64
local mousearrowpos = {x = 13 * multiplier, y = 3 * multiplier}
local mx, my, mdx, mdy, arrowstick_active, arrowstick_idle
mdx, mdy = 0, 0
local loadQueue = require(LAYOUT)
local pressed = {}
drawCalls = {}

function f.load()
	arrowstick_active = love.graphics.newImage('/assets/keyboard/mouse_active.png')
	arrowstick_idle = love.graphics.newImage('/assets/keyboard/mouse_idle.png')
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
			info = love.filesystem.getInfo(loadQueue.path..tostring(alias)..'_up.png')
			if not info then
				up = love.graphics.newImage('/assets/common/err_up.png')
			else
				up = love.graphics.newImage(loadQueue.path..tostring(target)..'_up.png')
			end
			info = love.filesystem.getInfo(loadQueue.path..tostring(alias)..'_down.png')
			if not info then
				down = love.graphics.newImage('/assets/common/err_down.png')
			else
				down = love.graphics.newImage(loadQueue.path..tostring(target)..'_down.png')
			end
			drawable = up
			func = function()
				if type(pressed) == 'table' then
					if pressed[name] == true then
						drawable = down
					else
						drawable = up
					end
					love.graphics.draw(drawable, x, y)
				end
			end
			table.insert(drawCalls, func)
			pressed[name] = false
		end
	end
	local windowWidth, windowHeight = 400, 200
	love.window.setMode(windowWidth, windowHeight,  {resizable = true, vsync = 1})
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
	if loadQueue.hideMouseJoystick then
	else
		love.graphics.draw(drawable, x, y)
	end
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