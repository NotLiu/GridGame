/// @description Insert description here
// You can write your code in this editor

if(abs(x - target_x) > 1){
	x = lerp(x, target_x, 0.2);
}
else{
	target_x = x;	
}

if(abs(y - target_y) > 1){
	y = lerp(y, target_y, 0.2);
}
else{
	target_y = y;	
}


if(type == 0){ //rock
	sprite_index = rock;
}

if(type == 1){ //paper
	sprite_index = paper;	
}

if(type == 2){ //scissors
	sprite_index = scissors;	
}

if(faceup == false){
	sprite_index = card_back;	
}

//draw card
draw_sprite(sprite_index, image_index, x , y);