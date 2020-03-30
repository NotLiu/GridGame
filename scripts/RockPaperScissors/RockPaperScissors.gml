player = global.selected.type;
enemy = global.enemy_selected.type;
//0 rock 1 paper 2 scissors
if(player - enemy == -1 || player - enemy == 2){
	return 2; // enemy wins
}
else if(player - enemy == 0){
	return 0; // neutral	
}
else{
	return 1; // player wins	
}
	