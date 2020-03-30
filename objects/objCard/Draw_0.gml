/// @description Insert description here
// You can write your code in this editor

if(abs(x - target_x) > x){
	lerp(x, target_x, 0.2);
}
else{
	target_x = x;	
}

if(type == 0){ //rock
	image_index = rock;
}

if(type == 1){ //paper
	image_index = paper;	
}

if(type == 2){ //scissors
	image_index = scissors;	
}

if(faceup == false){
	image_index = card_back;	
}