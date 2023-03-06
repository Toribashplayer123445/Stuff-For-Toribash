m={}
m.x=0
m.y=0
bodyparts = {0}
force = {0, 0 ,0}
state = 0
player = 0
ctrlkey = false

frametorilinvel = {}   
frametoriangvel = {}
frameukelinvel = {}   
frameukeangvel = {}
appliedtorilinvel = {}
appliedtoriangvel = {}
appliedukelinvel = {}
appliedukeangvel = {}
c = {}
    for i=1,21 do
		frametorilinvel[i] = {}   
		frametoriangvel[i] = {}
		frameukelinvel[i] = {}   
		frameukeangvel[i] = {}
		appliedtorilinvel[i] = {}
		appliedtoriangvel[i] = {}
		appliedukelinvel[i] = {}
		appliedukeangvel[i] = {}
		c[i] = {}
      for j=1,3 do
        frametorilinvel[i][j] = 0
		frametoriangvel[i][j] = 0
		frameukelinvel[i][j] = 0
		frameukeangvel[i][j] = 0
		appliedtorilinvel[i][j] = nil
		appliedtoriangvel[i][j] = nil
		appliedukelinvel[i][j] = nil
		appliedukeangvel[i][j] = nil
		c[i][j] = 0.45
      end
    end

function get_length()
	--calculate length of linvel vector
	l = math.sqrt(math.pow(force[1],2) + math.pow(force[2],2) + math.pow(force[3],2))
	return l
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function enterframe()
 -- read in all values
	for i = 1,21 do
		frametorilinvel[i][1], frametorilinvel[i][2], frametorilinvel[i][3] = get_body_linear_vel(0, i-1)
		frametoriangvel[i][1], frametoriangvel[i][2], frametoriangvel[i][3] = get_body_angular_vel(0, i-1)
		frameukelinvel[i][1], frameukelinvel[i][2], frameukelinvel[i][3] = get_body_linear_vel(1, i-1)
		frameukeangvel[i][1], frameukeangvel[i][2], frameukeangvel[i][3] = get_body_angular_vel(1, i-1)
		for j=1,4 do
		appliedtorilinvel[i][j] = nil
		appliedtoriangvel[i][j] = nil
		appliedukelinvel[i][j] = nil
		appliedukeangvel[i][j] = nil
		end
	end
	remove_hooks("draw")
end

function drawtext()
	if state == 0 then	
		if player == 0 then
			framevalue = frametorilinvel
			appliedvalue = appliedtorilinvel
		else
			framevalue = frameukelinvel
			appliedvalue = appliedukelinvel
		end
	elseif state == 1 then
		if player == 0 then
			framevalue = frametoriangvel
			appliedvalue = appliedtoriangvel
		else
			framevalue = frameukeangvel
			appliedvalue = appliedukeangvel
		end
	end	
	
	set_color(c[1][1],c[1][2],c[1][3],1)
	draw_quad(73, 291, 24, 12) 	--head1
	draw_quad(79, 285, 12, 24) 	--head2
	
	set_color(c[13][1],c[13][2],c[13][3],1)
	draw_quad(12, 305, 14, 14) 	--lwrist
	
	set_color(c[11][1],c[11][2],c[11][3],1)
	draw_quad(30, 308, 12, 8)  	--ltriceps
	
	set_color(c[10][1],c[10][2],c[10][3],1)
	draw_quad(48, 307, 16, 10) 	--lbiceps
	
	set_color(c[9][1],c[9][2],c[9][3],1)
	draw_quad(66, 311, 9, 14)  	--lpec
	
	set_color(c[2][1],c[2][2],c[2][3],1)
	draw_quad(77, 311, 15, 14) 	--breast
	
	set_color(c[6][1],c[6][2],c[6][3],1)
	draw_quad(94, 311, 9, 14)  	--rpec
	
	set_color(c[7][1],c[7][2],c[7][3],1)
	draw_quad(105, 307, 16, 10) --rbiceps
	
	set_color(c[8][1],c[8][2],c[8][3],1)
	draw_quad(127, 308, 12, 8)	--rtriceps
	
	set_color(c[12][1],c[12][2],c[12][3],1)
	draw_quad(143, 305, 14, 14) --rwrist
	
	set_color(c[3][1],c[3][2],c[3][3],1)
	draw_quad(71, 327, 27, 11) 	--chest
	
	set_color(c[4][1],c[4][2],c[4][3],1)
	draw_quad(75, 340, 18, 10) 	--stomach
	
	set_color(c[5][1],c[5][2],c[5][3],1)
	draw_quad(79, 354, 10, 7) 	--groin
	
	set_color(c[17][1],c[17][2],c[17][3],1)
	draw_quad(67, 368, 12, 22) 	--lthigh
	
	set_color(c[16][1],c[16][2],c[16][3],1)
	draw_quad(88, 368, 12, 22) 	--rthigh
	
	set_color(c[18][1],c[18][2],c[18][3],1)
	draw_quad(67, 400, 12, 22) 	--lleg
	
	set_color(c[19][1],c[19][2],c[19][3],1)
	draw_quad(88, 400, 12, 22) 	--rleg
	
	set_color(c[21][1],c[21][2],c[21][3],1)
	draw_quad(67, 430, 12, 5) 	--lfoot
	
	set_color(c[20][1],c[20][2],c[20][3],1)
	draw_quad(88, 430, 12, 5) 	--rfoot
		
	
	offset = 200

	set_color(0.45, 0.45, 0.45, 1)
	draw_text("Reset", 120, 380, 1)
	draw_text("Apply", 120, 417, 1)
	if player == 0 then
		draw_text("Uke", 80, offset-55, 1)
		set_color(0.1, 0.1, 0.1, 1)
		draw_text("Tori", 12, offset-55, 2)
	else
		draw_text("Tori", 12, offset-55, 1)
		set_color(0.1, 0.1, 0.1, 1)
		draw_text("Uke", 80, offset-55, 2)
	end
	if state == 0 then
		set_color(0.33,0.6,0.33,1)
		draw_text("LINVEL", 12, offset-25, 2)
		set_color(0.6,0.33,0.33,1)
		draw_text("ANGVEL", 80, offset-25, 1)
		set_color(0.33,0.6,0.33,1)
	else
		set_color(0.33,0.6,0.33,1)
		draw_text("LINVEL", 12, offset-25, 1)
		set_color(0.6,0.33,0.33,1)
		draw_text("ANGVEL", 80, offset-25, 2)
		set_color(0.6,0.33,0.33,1)
	end

	bodypart = bodyparts[1]
	draw_text("Bodypart	 " .. bodypart ,12 ,offset, 1)
	
	for i = 1, 3 do
        draw_text(round(framevalue[bodypart+1][i], 3),12,(i*17)+offset,1)
		
		if appliedvalue[bodypart+1][i] ~= nil then
			draw_text(appliedvalue[bodypart+1][i], 70, ((i)*17)+offset,1)
		end
	
	end

end

function drawforce()
	bodypart = bodyparts[1]
	pos = get_body_info(player, bodypart).pos
	set_color(1, 1, 0.6, 1)
	
	local degree = {y=0, z=0}

		if appliedvalue[bodypart+1][1] ~=nil then
			force[1] = appliedvalue[bodypart+1][1]
			force[2] = appliedvalue[bodypart+1][2]
			force[3] = appliedvalue[bodypart+1][3]
		else
			force[1] = framevalue[bodypart+1][1]
			force[2] = framevalue[bodypart+1][2]
			force[3] = framevalue[bodypart+1][3]
		end
	
	
--spin around y axis
	
	degree.y = math.atan2(force[3], force[1])
		
--spin around z axis
	x = math.cos(degree.y) * get_length()
	z = math.sin(degree.y) * get_length()

	distance = math.pow (force[1] - x,2) + math.pow(force[2],2) + math.pow(force[3] - z,2)
	distance = math.sqrt(distance)
	
	if tonumber(force[2]) >0  then
		degree.z = math.acos((2 * math.pow(get_length(),2) - math.pow(distance,2)) / (2 * math.pow(get_length(),2)))
	else
		degree.z = -math.acos((2 * math.pow(get_length(),2) - math.pow(distance,2)) / (2 * math.pow(get_length(),2)))
	end	
	draw_box(pos.x+force[1]/(2*get_length()), pos.y+force[2]/(2*get_length()), pos.z+force[3]/(2*get_length()), 1, 0.1, 0.1, 0, math.deg(degree.y), -math.deg(degree.z))
  end

function command(c)
  	cmd = c
	words = {} 
	numbers = {}
	
	for word in cmd:gmatch("%S+") do
		table.insert(words, word) 
	end
	
	if words[1] == "apply" and state == 0 then
		for i = 1,#bodyparts do
			a = bodyparts[i]
			if player == 0 then
				appliedtorilinvel[a+1] = {words[2], words[3], words[4], 1}
			else
				appliedukelinvel[a+1] = {words[2], words[3], words[4], 1}
			end
			set_body_force(player, a, words[2], words[3], words[4])
		end
	
	elseif words[1] == "apply" and state == 1 then
		for i = 1,#bodyparts do
			a = bodyparts[i]
			if player == 0 then
				appliedtoriangvel[a+1] = {words[2], words[3], words[4], 1}
			else
				appliedukeangvel[a+1] = {words[2], words[3], words[4], 1}
			end
			set_body_torque(player, a, words[2], words[3], words[4])
		end
	end
  end

function mousetrack(mx, my)
m.x,m.y=mx,my
end

function changecolor()
	for i=1,21 do
		c[i][1] = 0.45
		c[i][2] = 0.45
		c[i][3] = 0.45
		if player == 0 then
			if appliedtorilinvel[i][4] == 1 then
				c[i][2] = 0.8
			end
		
			if appliedtoriangvel[i][4] == 1 then
				c[i][1] = 0.8
			end
		else
			if appliedukelinvel[i][4] == 1 then
				c[i][2] = 0.8
			end
		
			if appliedukeangvel[i][4] == 1 then
				c[i][1] = 0.8
			end
		end
			
	end
	
	for j = 1,#bodyparts do
		a = bodyparts[j]
		c[a+1][1] = 0.1
		c[a+1][2] = 0.1
		c[a+1][3] = 0.1
	end
end

function checkbox(xstart, ystart, xwidth, yheight, part)
	if xstart < m.x and  m.x < xstart+xwidth and ystart < m.y and m.y < ystart+yheight then
		if ctrlkey == false then
			bodyparts = {}
		end
		table.insert(bodyparts, part)
		add_hook("draw3d","draw", drawforce)
		changecolor()
	end
end

function mouseclick()
	--toribox
	if 12 < m.x and  m.x < 65 and 145 < m.y and m.y < 170 then
		player = 0
		changecolor()
	end
	--ukebox
	if 80 < m.x and  m.x < 145 and 145 < m.y and m.y < 170 then
		player = 1
		changecolor()
	end
		--linvelbox
	if 12 < m.x and  m.x < 65 and 175 < m.y and m.y < 200 then
		state = 0
	end
	--angvelbox
	if 80 < m.x and  m.x < 145 and 175 < m.y and m.y < 200 then
		state = 1
	end
	--resetbox
	if 120 < m.x and  m.x < 160 and 380 < m.y and m.y < 397 then
		for j=1,4 do
			if player == 0 then
				appliedtorivalue[bodypart+1][j] = nil
			else
				appliedukevalue[bodypart+1][j] = nil
			end
		end	
		if state == 0 then
				set_body_force(0, bodypart, framelinvel[bodypart+1][1], framelinvel[bodypart+1][2], framelinvel[bodypart+1][3])
			else
				set_body_torque(0, bodypart, frameangvel[bodypart+1][1], frameangvel[bodypart+1][2], frameangvel[bodypart+1][3])
			end
	end
	--applybox
	if 120 < m.x and  m.x < 160 and 417 < m.y and m.y < 434 then
		run_frames(1)
		echo("Please change a joint")
	end

	checkbox(73, 291, 24, 24, 0)	--headbox
	checkbox(12, 305, 14, 14, 12)	--lwristbox
	checkbox(30, 308, 12, 8, 10)	--ltricepsbox
	checkbox(48, 307, 16, 10, 9)	--lbicepsbox
	checkbox(66, 311, 9, 14, 8)		--lpecbox
	checkbox(77, 311, 15, 14, 1)	--breastbox
	checkbox(94, 311, 9, 14, 5)		--rpecbox
	checkbox(105, 307, 16, 10,6)	--rbicepsbox
	checkbox(127, 308, 12, 8, 7)	--rtricepsbox
	checkbox(143, 305, 14, 14, 11)	--rwristbox
	checkbox(71, 327, 27, 11, 2)	--chestbox
	checkbox(75, 340, 18, 10, 3)	--stomachbox
	checkbox(79, 354, 10, 7, 4)		--groinbox
	checkbox(67, 368, 12, 22, 16)	--lthighbox
	checkbox(88, 368, 12, 22, 15)	--rthighbox
	checkbox(67, 400, 12, 22, 17)	--llegbox
	checkbox(88, 400, 12, 22, 18)	--rlegbox
	checkbox(67, 430, 12, 5, 20)	--lfootbox
	checkbox(88, 430, 12, 5, 19)	--rfootbox
end

function keydown(key)
	if key == 306 then
		ctrlkey = true
	end
end

function keyup(key)
	if key == 306 	then
		ctrlkey = false
	end
end

add_hook("key_up","keys",keyup)
add_hook("key_down","keys",keydown)
add_hook("draw2d","drawtext", drawtext)
add_hook("new_game","initialize",enterframe)
add_hook("enter_frame", "framelinvel", enterframe)
add_hook("mouse_move","movecursor",mousetrack)
add_hook("mouse_button_down","click",mouseclick)
add_hook("command", "commandhook", command)