/// @description Insert description here
// You can write your code in this editor

if(global.state == global.state_choose && in_hand){
	if(position_meeting(mouse_x, mouse_y, id)){
		global.selected = id;
		target_y = room_width*3/4-10;
	} else if(global.selected == id){
		global.selected = noone;	
		target_y = room_width*3/4;
	}
}