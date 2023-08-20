--Select the .lua file containing the layout
LAYOUT = "/assets/not-in-the-groove/_layout"

websocket = ""
client = ""
open = false
left_ptr = love.graphics.newImage('/assets/common/left_ptr.png')
love.graphics.setDefaultFilter("nearest", "nearest")
local ww, wh = love.graphics.getDimensions()
local sw, sh = love.window.getDesktopDimensions()
local mx, my = 0, 0
local rc, lc, mc, wu, wd
local w, a, s, d = false, false, false, false
require("netkey")
buttons = require('buttons')

function makeClient(host, port)
	client = websocket.new(host or "localhost", port or 5000)
	function client:onopen()
		open = true
	end
	function client:onclose(code, reason)
		open = false
	end
	function client:onmessage(message)
		--print(message)
		netkey.msghandler(message)
	end
	return client
end

function love.load(args, unfilteredArgs)
	love.window.setTitle('KeyStrokeViewer By Alejandro Alzate (github.com/alejandro-alzate)')
	love.window.setMode(15*64, 5*64, {resizable = true, vsync = 1})
	websocket = require("websocket")
	client = makeClient("127.0.0.1", 7788)
	buttons.load()
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'f5' then love.event.quit('restart') end
end

function love.update(dt)
	client:update()
	--if open == false then
	--	client = makeClient("127.0.0.1", 7788)
	--end
end

function love.draw()
	love.graphics.setBackgroundColor(0,1,0)
	buttons.draw()
end

function netkey.mousemoved(x, y, dx, dy, istouch)
	mx, my = x/sw*ww, y/sh*wh
	buttons.mousemoved(x, y, dx, dy, istouch)
end

function netkey.keypressed(key, scancode, isrepeat)
	buttons.keypressed(key, scancode, isrepeat)
end

function netkey.keyreleased(key, scancode, isrepeat)
	buttons.keyreleased(key, scancode)
end

function netkey.msghandler(msg)
	local typedata, data
	if netkey then
		if netkey.event then
			netkey.event(msg)
		end
	end
	if msg == '+074' then
		love.event.quit('restart')
	end
	if type(msg) == 'string' then
		if msg:len() == 4 then --[[Key pressed / released]]
			--Got pressed -> '+'..'scancode'
			local code, status = msg:gsub('+', '')
			if status > 0 then
				if code:len() == 3 then
					if netkey then
						if netkey.keypressed then
							netkey.keypressed(lookupkey[code], msg)
						end
					end
					if netkey.simulatekeyboard then
						if love then
							if love.keypressed then
								love.keypressed(lookupkey[code] or 'unknown',
									lookupkey[code] or 'unknown', false)
								return
							end
						end
					end
				end
			end
			--Got pressed -> '+'..'scancode'
			local code, status = msg:gsub('-', '')
			if status > 0 then
				if code:len() > 0 then
					if netkey then
						if netkey.keyreleased then
							netkey.keyreleased(lookupkey[code], msg)
						end
					end
					if netkey.simulatekeyboard then
						if love then
							if love.keyreleased then
								love.keyreleased(lookupkey[code] or 'unknown',
								lookupkey[code] or 'unknown', false)
								return
							end
						end
					end
				end
			end
		end
		if msg:len() == 16 then --[[Mouse moved]]
			--DisplayKeystroke Server
			local x =   tonumber(string.sub(msg, 1,4), 16)
			local y =   tonumber(string.sub(msg, 5,8), 16)
			local dx = (tonumber(string.sub(msg, 9,12 ), 16)+2^15)%2^16-2^15
			local dy = (tonumber(string.sub(msg, 13,16), 16)+2^15)%2^16-2^15
			local raw = msg
			if netkey then
				if netkey.mousemoved then
					netkey.mousemoved(x,y,dx,dy,raw)
				end
			end
			if netkey.simulatemouse then
				if love then
					if love.mousemoved then
						love.mousemoved(x,y,dx,dy,false)
					end
				end
			end
		end
	end
end
