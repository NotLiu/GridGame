/// @description Insert description here
// You can write your code in this editor

player_score = 0;
enemy_score = 0;

chosen_pos = 0;
enemy_chosen_pos = 0;

global.state_deal = 0;
global.state_choose = 1;
global.state_compare = 2;
global.state_cleanup = 3;
global.state_reshuffle = 4;

global.state = global.state_deal;

global.hand = ds_list_create();
global.deck = ds_list_create();
global.deck_reverse = ds_list_create();
global.discard = ds_list_create();

global.enemy_hand = ds_list_create();

global.numcards = 24;

global.selected = noone;
global.enemy_selected = noone;

enemy_chosen = false;
chosen = false;

for(i=0; i<8; i++){ //add 8 rock
	var card = instance_create_layer(x, y, "Instances", objCard);
	card.type = 0; // rock
	card.target_x = x;
	card.target_y = y;
	
	card.in_hand = false;
	card.faceup = false;
	ds_list_add(global.deck, card);
}


for(i=0; i<8; i++){ //add 8 paper
	var card = instance_create_layer(x, y, "Instances", objCard);
	card.type = 1; // paper
	card.target_x = x;
	card.target_y = y;
	
	card.in_hand = false;
	card.faceup = false;
	ds_list_add(global.deck, card);
}

for(i=0; i<8; i++){ //add 8 scissors
	var card = instance_create_layer(x, y, "Instances", objCard);
	card.type = 2; // scissors
	card.target_x = x;
	card.target_y = y; //-2*ds_list_size(global.deck)
	
	card.in_hand = false;
	card.faceup = false;
	ds_list_add(global.deck, card);
}

randomize();
ds_list_shuffle(global.deck);

wait_time = 0;
global.selected = noone;

for(i=0; i<ds_list_size(global.deck); i++){
	global.deck[| i].depth = -i;
	global.deck[| i].target_y -= 2*i;
}
