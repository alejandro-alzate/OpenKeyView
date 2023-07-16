--Hey! take a look don't be shy to edit it to suit your needs,
--The default is set to DFJK but you can edit the layout
--choosen in the line "local LAYOUT ="
local dfjk_layout = {
	path = "/assets/not-in-the-groove/",
	windowWidth = 220,
	windowHeight = 30,
	{name = "d",		pos = {x = 0, y = 0}, alias = 'left'},
	{name = "f",		pos = {x = 1, y = 0}, alias = 'down'},
	{name = "j",		pos = {x = 2, y = 0}, alias = 'up'},
	{name = "k",		pos = {x = 3, y = 0}, alias = 'right'},
}
local arrow_layout = {
	path = "/assets/not-in-the-groove/",
	windowWidth = 156,
	windowHeight = 156,
	{name = "left",		pos = {x = 0, y = 1}},
	{name = "down",		pos = {x = 1, y = 2}},
	{name = "up",		pos = {x = 1, y = 0}},
	{name = "right",	pos = {x = 2, y = 1}},
}
local LAYOUT = dfjk_layout
LAYOUT.hideMouseJoystick = true
return LAYOUT