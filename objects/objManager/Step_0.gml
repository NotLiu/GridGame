/// @description Insert description here
// You can write your code in this editor

switch(global.state){
	case global.state_deal:
		var cards_enemy_hand = ds_list_size(global.enemy_hand);
		var cards_hand = ds_list_size(global.hand);
		
		if(wait_time > 15){
			if(cards_enemy_hand <3){
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
					global.selected.target_x = room_width/3 + 100;
					global.selected.target_y = room_height/2;
					global.selected.in_hand = false;
					chosen = true;
			}
		}
		
		if(wait_time > 30 && enemy_chosen == false){
			enemy_chosen = true;
			global.enemy_selected = global.enemy_hand[| irandom_range(0,2)];
			global.enemy_selected.target_x = room_width/3 +100;
			global.enemy_selected.target_y = room_height/2 - 135;
			wait_time = 0;
		}
		
		if(chosen == true && enemy_chosen == true){
			global.state = global.state_compare;	
			wait_time = 0;
		}
		
		wait_time ++;
		break;
	
	case global.state_compare:
		winner = RockPaperScissors();
		if(winner == 1){ //player wins
			player_score += 1;
		}
		else if(winner == 2){ //enemy wins
			enemy_score += 1;	
		}
		
		if(wait_time > 30){
			global.state = global.state_cleanup;
			wait_time = 0;
		}
		wait_time++;

}

if(keyboard_check(ord("3")) && keyboard_check(ord("6"))){
	game_restart();	
}