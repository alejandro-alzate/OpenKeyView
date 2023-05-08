netkey = {}
netkey.host, netkey.port = "127.0.0.1", 7788
local client = {}
netkey.debug = false
netkey.show = false
netkey.simulatekeyboard = false
netkey.simulatemouse = false
lookupstr = {}
local v = {}
v.mouse = {}
v.mouse.x = 0
v.mouse.dx = 0
v.mouse.y = 0
v.mouse.dy = 0
v.msg = ''

do --[[look up string table human readable manner]]
	--[[Mouse Buttons]]
	lookupstr['001'] = 'Left Mouse Click'
	lookupstr['002'] = 'Right Mouse Click'
	lookupstr['004'] = 'Middle Mouse Click'
	lookupstr['00a'] = 'Scroll Wheel Up'
	lookupstr['00b'] = 'Scroll Wheel Down'
	--[[Keyboard Modifiers]]
	lookupstr['0a2'] = 'Left Control'
	lookupstr['0a0'] = 'Left Shift'
	lookupstr['0a4'] = 'Left Alt'
	lookupstr['1a3'] = 'Right Control'
	lookupstr['1a1'] = 'Right Shift'
	lookupstr['1a5'] = 'Right Alt'
	--[[Numbers]]
	for i=0,9 do
		lookupstr['03'..i] = 'Number '..i
	end
	--[[QWERTY es_EN]]
	lookupstr['041'] = 'A'
	lookupstr['042'] = 'B'
	lookupstr['043'] = 'C'
	lookupstr['044'] = 'D'
	lookupstr['045'] = 'E'
	lookupstr['046'] = 'F'
	lookupstr['047'] = 'G'
	lookupstr['048'] = 'H'
	lookupstr['049'] = 'I'
	lookupstr['04a'] = 'J'
	lookupstr['04b'] = 'K'
	lookupstr['04c'] = 'L'
	lookupstr['04d'] = 'M'
	lookupstr['04e'] = 'N'
	lookupstr['04f'] = 'O'
	lookupstr['050'] = 'P'
	lookupstr['051'] = 'Q'
	lookupstr['052'] = 'R'
	lookupstr['053'] = 'S'
	lookupstr['054'] = 'T'
	lookupstr['055'] = 'U'
	lookupstr['056'] = 'V'
	lookupstr['057'] = 'W'
	lookupstr['058'] = 'X'
	lookupstr['059'] = 'Y'
	lookupstr['05a'] = 'Z'
	lookupstr['0be'] = '.'
	lookupstr['0bc'] = ','
	lookupstr['0bd'] = '/'
	lookupstr['0c0'] = ';'
	lookupstr['0de'] = '\''
	lookupstr['0ba'] = '['
	lookupstr['0bb'] = ']'
	lookupstr['0bd'] = '/'
	lookupstr['0bf'] = '\\'
	lookupstr['0db'] = '-'
	lookupstr['0dd'] = '='
	lookupstr['0dc'] = '`'
	lookupstr['0e2'] = 'unknown' --'<'' and '>' in one key idk what to do XD
	--[[Numpad]]
	lookupstr['190'] = 'Num lock'
	lookupstr['16f'] = 'Numpad Divide'
	lookupstr['06a'] = 'Numpad Multiply'
	lookupstr['06d'] = 'Numpad Subtract'
	lookupstr['06b'] = 'Numpad Add'
	lookupstr['06e'] = 'Numpad Colon' --idk
	for i=0,9 do
		lookupstr['06'..i] = 'Numpad '..i
	end
	lookupstr['021'] = 'Numpad Page Up'
	lookupstr['022'] = 'Numpad Page Down'
	lookupstr['023'] = 'Numpad End'
	lookupstr['024'] = 'Numpad Start'
	--usseless but wtf btw with this?! this code appears when num lock is off
	--and when you press 5 on the numpad
	lookupstr['00c'] = 'Numpad 5'
	lookupstr['10d'] = 'Numpad Enter'
	lookupstr['02d'] = 'Numpad Insert'
	lookupstr['02e'] = 'Numpad Delete'
	lookupstr['025'] = 'Numpad Left Arrow'
	lookupstr['026'] = 'Numpad Up Arrow'
	lookupstr['027'] = 'Numpad Right Arrow'
	lookupstr['028'] = 'Numpad Down Arrow'
	--[[Control keys]]
	lookupstr['009'] = 'Tab'
	lookupstr['01b'] = 'Escape'
	lookupstr['014'] = 'Caps Lock' --bloq mayús in es-Es
	lookupstr['091'] = 'Scroll Unlock'
	for i=0,9 do
		lookupstr['07'..i] = 'Function Key '..i+1
	end
	lookupstr['008'] = 'Backspace'
	lookupstr['00d'] = 'Enter'
	lookupstr['013'] = 'Pause Break'
	lookupstr['12c'] = 'Print Screen'
	lookupstr['12e'] = 'Delete'
	lookupstr['12d'] = 'Insert'
	lookupstr['121'] = 'Page Up'
	lookupstr['122'] = 'Page Down'
	lookupstr['123'] = 'End'
	lookupstr['124'] = 'Start'
	lookupstr['125'] = 'Left Arrow'
	lookupstr['126'] = 'Up Arrow'
	lookupstr['127'] = 'Right Arrow'
	lookupstr['128'] = 'Down Arrow'
	lookupstr['15b'] = 'Super Left'
	lookupstr['15c'] = 'Super Right'
	lookupstr['15d'] = 'Menu'
	lookupstr['020'] = 'Space'
end

do --[[look up scan compatible table]]
	lookupkey = {}
	--[[Mouse Buttons]]
	lookupkey['001'] = 'lclick'
	lookupkey['002'] = 'rclick'
	lookupkey['004'] = 'mclick'
	lookupkey['00a'] = 'wheelup'
	lookupkey['00b'] = 'wheeldown'
	--[[Keyboard Modifiers]]
	lookupkey['0a2'] = 'lcontrol'
	lookupkey['0a0'] = 'lshift'
	lookupkey['0a4'] = 'lalt'
	lookupkey['1a3'] = 'rcontrol'
	lookupkey['1a1'] = 'rshift'
	lookupkey['1a5'] = 'ralt'	
	--[[Numbers]]
	for i=0,9 do
		lookupkey['03'..i] = i
	end
	--[[QWERTY es_EN]]
	lookupkey['041'] = 'a'
	lookupkey['042'] = 'b'
	lookupkey['043'] = 'c'
	lookupkey['044'] = 'd'
	lookupkey['045'] = 'e'
	lookupkey['046'] = 'f'
	lookupkey['047'] = 'g'
	lookupkey['048'] = 'h'
	lookupkey['049'] = 'i'
	lookupkey['04a'] = 'j'
	lookupkey['04b'] = 'k'
	lookupkey['04c'] = 'l'
	lookupkey['04d'] = 'm'
	lookupkey['04e'] = 'n'
	lookupkey['04f'] = 'o'
	lookupkey['050'] = 'p'
	lookupkey['051'] = 'q'
	lookupkey['052'] = 'r'
	lookupkey['053'] = 's'
	lookupkey['054'] = 't'
	lookupkey['055'] = 'u'
	lookupkey['056'] = 'v'
	lookupkey['057'] = 'w'
	lookupkey['058'] = 'x'
	lookupkey['059'] = 'y'
	lookupkey['05a'] = 'z'
	lookupkey['0be'] = '.'
	lookupkey['0bc'] = ','
	lookupkey['0bd'] = '/'
	lookupkey['0c0'] = ';'
	lookupkey['0de'] = '\''
	lookupkey['0ba'] = '['
	lookupkey['0bb'] = ']'
	lookupkey['0bd'] = '/'
	lookupkey['0bf'] = '\\'
	lookupkey['0db'] = '-'
	lookupkey['0dd'] = '='
	lookupkey['0dc'] = 'unknown' --º
	lookupkey['0e2'] = 'nonusbackslash' --WTF <
	--[[Numpad]]
	lookupkey['190'] = 'numlock'
	lookupkey['16f'] = 'kp/'
	lookupkey['06a'] = 'kp*'
	lookupkey['06d'] = 'kp-'
	lookupkey['06b'] = 'kp+'
	lookupkey['06e'] = 'kp.' --idk
	for i=0,9 do
		lookupkey['06'..i] = 'kp'..i
	end
	--love doesn't care about numlock state lol
	lookupkey['021'] = 'kp9'
	lookupkey['022'] = 'kp3'
	lookupkey['023'] = 'kp1'
	lookupkey['024'] = 'kp7'
	lookupkey['00c'] = 'kp5'
	lookupkey['10d'] = 'kpenter'
	lookupkey['02d'] = 'kp0'
	lookupkey['02e'] = 'kp.'
	lookupkey['025'] = 'kp4'
	lookupkey['026'] = 'kp8'
	lookupkey['027'] = 'kp6'
	lookupkey['028'] = 'kp2'
	--[[Control keys]]
	lookupkey['009'] = 'tab'
	lookupkey['01b'] = 'escape'
	lookupkey['014'] = 'capslock' --bloq mayús in es-Es
	lookupkey['091'] = 'scrolllock'
	for i=0,9 do
		lookupkey['07'..i] = 'f'..i+1
	end
	lookupkey['008'] = 'backspace'
	lookupkey['00d'] = 'enter'
	lookupkey['013'] = 'pause'
	lookupkey['12c'] = 'printscreen'
	lookupkey['12e'] = 'delete'
	lookupkey['12d'] = 'insert'
	lookupkey['121'] = 'pageup'
	lookupkey['122'] = 'pagedown'
	lookupkey['123'] = 'end'
	lookupkey['124'] = 'start'
	lookupkey['125'] = 'left'
	lookupkey['126'] = 'up'
	lookupkey['127'] = 'right'
	lookupkey['128'] = 'down'
	lookupkey['15b'] = 'lgui'
	lookupkey['15c'] = 'rgui'
	lookupkey['15d'] = 'aplication'
	lookupkey['020'] = 'space'
end

function netkey.msghandler(msg)
	if netkey then
		if netkey.event then
			netkey.event(msg)
		end
	end
	if netkey.debug then
		io.stdout = io.write(tostring(msg))
	end
	if msg == '+074' then
		love.event.quit('restart')
	end
	if type(msg) == 'string' then
		if msg:len() == 4 then --[[Key pressed / released]]
			if netkey.debug then
				io.stdout = io.write('\t'..(lookupkey[msg:gsub('+', ''):gsub('-', '')] or 'unregistered')..'\t'..(lookupstr[msg:gsub('+', ''):gsub('-', '')] or 'unregistered')..'\n')
			end
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
			if netkey.debug then
				io.stdout = io.write('\tMouse move: x: '..x..' y: '..y..' dx: '..dx..' dy: '..dy..'\n')
			end
		end
	end
end

function netkey.update(dt)
	client:update()
end

function netkey.connect()
	client = require('websocket').new(netkey.host, netkey.port)
	function client:onclose()
		client = require('websocket').new(netkey.host, netkey.port)
	end
	function client:onmessage(msg)
		netkey.msghandler(msg)
	end
end