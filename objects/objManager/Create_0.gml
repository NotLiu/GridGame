/// @description Insert description here
// You can write your code in this editor

global.state_deal = 0;
global.state_fight = 1;
global.state_cleanup = 2;
global.state_reshuffle = 3;

global.state = global.state_deal;

global.hand = ds_list_create();
global.deck = ds_list_create();
global.discard = ds_list_create();

global.enemy_hand = ds_list_create();

global.numcards = 24;

global.selected = noone;
global.enemy_selected = noone;

for(i=0; i<8; i++){ add 8 rock
	card = instance_create_layer(x, y, "Instances", objCard);
	card.type = 0; // rock
	
}