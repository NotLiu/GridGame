/// @description Insert description here
// You can write your code in this editor

switch(global.state){
	case global.state_deal:
		var cards_enemy_hand = ds_list_size(global.enemy_hand);
		var cards_hand = ds_list_size(global.hand);
		
		if(wait_time > 15){
			if(cards_enemy_hand <3){
				audio_play_sound(snd_card, 10, false);
				
				var dealt_card = global.deck[| ds_list_size(global.deck)-1];
				ds_list_delete(global.deck,	ds_list_size(global.deck)-1);
				ds_list_add(global.enemy_hand, dealt_card);
			
				dealt_card.target_x = room_width/3 + cards_enemy_hand * 100;
				dealt_card.target_y = room_height/7;
				//dealt_card.in_hand = true; //commented out because its not in our hand so we shouldnt be able to select
				wait_time = 0;
			}
			else{
				if(cards_hand < 3){
					audio_play_sound(snd_card, 10, false);
					
					dealt_card = global.deck[| ds_list_size(global.deck)-1];
					ds_list_delete(global.deck, ds_list_size(global.deck)-1);
					ds_list_add(global.hand, dealt_card);
				
					dealt_card.target_x = room_width/3 + cards_hand * 100;
					dealt_card.target_y = room_width*3/4;
					dealt_card.in_hand = true;
					dealt_card.faceup = true;
					wait_time = 0;
				}
				else{
					global.state = global.state_choose;
					wait_time = 0;
				}
			}
		}
		
		wait_time++;
		break;
	
	case global.state_choose:
		if(mouse_check_button_pressed(mb_left)){
			if(global.selected != noone){
				audio_play_sound(snd_card, 10, false);
				
				global.selected.target_x = room_width/3 + 100;
				global.selected.target_y = room_height/2;
				global.selected.in_hand = false;
				chosen = true;
			}
		}
		
		if(wait_time > 30 && enemy_chosen == false){
			audio_play_sound(snd_card, 10, false);
			
			enemy_chosen = true;
			global.enemy_selected = global.enemy_hand[| irandom_range(0,2)];
			global.enemy_selected.target_x = room_width/3 +100;
			global.enemy_selected.target_y = room_height/2 - 135;
			wait_time = 0;
		}
		
		for(i=0; i<ds_list_size(global.hand); i++){
			if(global.hand[| i] == global.selected){	
				chosen_pos = i;
			}
		}
		
		for(i=0; i<ds_list_size(global.enemy_hand); i++){
			if(global.enemy_hand[| i] == global.enemy_selected){
				enemy_chosen_pos = i;
			}
		}
		
		if(chosen == true && enemy_chosen == true){
			global.state = global.state_compare;	
			wait_time = 0;
		}
		
		wait_time ++;
		break;
	
	case global.state_compare:
		if(wait_time > 40 && global.enemy_selected.faceup == false){
			global.enemy_selected.faceup = true;
			winner = RockPaperScissors();
			if(winner == 1){ //player wins
				audio_play_sound(snd_win, 10, false);
				player_score += 1;
			}
			else if(winner == 2){ //enemy wins
				audio_play_sound(snd_lose, 10, false);
				enemy_score += 1;	
			}
		}
		if(wait_time > 100){
			global.state = global.state_cleanup;
			wait_time = 0;
		}
		wait_time++;
		break;
		
	case global.state_cleanup:
		
		if(wait_time > 15){
			if(ds_list_size(global.enemy_hand) == 3){
				audio_play_sound(snd_card, 10, false);
				
				global.enemy_selected.target_x = room_width -x*1.5;
				global.enemy_selected.target_y = y - 2*ds_list_size(global.discard);
				global.enemy_selected.depth = -ds_list_size(global.discard);
				ds_list_add(global.discard, global.enemy_selected);
				ds_list_delete(global.enemy_hand, enemy_chosen_pos);
				global.enemy_selected = noone;
				enemy_chosen = false;
				enemy_chosen_pos = 0;
			}
			else if(ds_list_size(global.hand) == 3){
				audio_play_sound(snd_card, 10, false);
				
				global.selected.target_x = room_width -x*1.5;
				global.selected.target_y = y - 2*ds_list_size(global.discard);
				global.selected.depth = -ds_list_size(global.discard);
				ds_list_add(global.discard, global.selected);
				ds_list_delete(global.hand, chosen_pos);
				global.selected = noone;
				chosen = false;
				chosen_pos = 0;
			}
			else{			
				if(ds_list_size(global.enemy_hand) > 0){
					audio_play_sound(snd_card, 10, false);
					
					global.enemy_hand[| ds_list_size(global.enemy_hand)-1].faceup = true;
					global.enemy_hand[| ds_list_size(global.enemy_hand)-1].target_x = room_width - x*1.5;
					global.enemy_hand[| ds_list_size(global.enemy_hand)-1].target_y = y - 2*ds_list_size(global.discard);
					global.enemy_hand[| ds_list_size(global.enemy_hand)-1].depth = -ds_list_size(global.discard);
					ds_list_add(global.discard, global.enemy_hand[| ds_list_size(global.enemy_hand)-1]);
					ds_list_delete(global.enemy_hand, ds_list_size(global.enemy_hand)-1);
				}
				else if(ds_list_size(global.hand) > 0){
					audio_play_sound(snd_card, 10, false);
					
					global.hand[| ds_list_size(global.hand)-1].faceup = true;
					global.hand[| ds_list_size(global.hand)-1].target_x = room_width - x*1.5;
					global.hand[| ds_list_size(global.hand)-1].target_y = y - 2*ds_list_size(global.discard);
					global.hand[| ds_list_size(global.hand)-1].depth = -ds_list_size(global.discard);
					ds_list_add(global.discard, global.hand[| ds_list_size(global.hand)-1]);
					ds_list_delete(global.hand, ds_list_size(global.hand)-1);
				}
				else{
					if(ds_list_size(global.deck) > 0){
						global.state = global.state_deal;
						wait_time = 0;
					}
					else{
						global.state = global.state_reshuffle;
						wait_time = 0;
					}
				}
			}
			wait_time = 0;
		}
		wait_time++;
		break;
	case global.state_reshuffle:
		if(wait_time > 5){
			if(ds_list_size(global.deck_reverse) != global.numcards && ds_list_size(global.discard)!=0){				
				audio_play_sound(snd_card, 10, false);
				
				var card = global.discard[| ds_list_size(global.discard)-1];
				card.faceup = false;
				card.target_x = x;
				card.target_y = y - 2*ds_list_size(global.deck_reverse);
				card.depth = -ds_list_size(global.deck_reverse);
				
				ds_list_add(global.deck_reverse, card);
				ds_list_delete(global.discard, ds_list_size(global.discard)-1);
			
			}
			else{
				if(ds_list_size(global.deck_reverse) == global.numcards){
					randomize();
					ds_list_shuffle(global.deck_reverse);
				}
				for(i = ds_list_size(global.deck_reverse)-1; i>0; i--){
					audio_play_sound(snd_card, 10, false);
					
					var card = global.deck_reverse[| i];
					card.target_y = y - 2*ds_list_size(global.deck);
					card.depth = -ds_list_size(global.deck);
					ds_list_add(global.deck, card);	
					ds_list_delete(global.deck_reverse, ds_list_size(global.deck_reverse)-1);
				}
			}
			
			if(ds_list_size(global.deck) == global.numcards){
				global.state = global.state_deal;
				wait_time = 0;
			}
			wait_time = 0;
		}
		
		wait_time++;
		break;

}

if(keyboard_check(ord("3")) && keyboard_check(ord("6"))){
	game_restart();	
}