#define init
	global.sprites = {};
	var arr = [];
	wait file_find_all("Sprites/", arr);
	//for each item in arr
	for (var i = 0; i < array_length(arr); i++) {
		//if it is a .png, add it as a sprite replacement
		if(arr[i].ext == ".png"){
			if(fork()){
				AddSprite(arr[i].name);
				exit;
			}
		}
	}

#define step
	script_bind_end_step(custom_step, 0);
	
#define custom_step
	instance_destroy();
	with(instances_matching(WepPickup, "reskinned", null)) {
		var reroll = 1;
		var didReroll = 0;
		while(reroll){
			reroll = 0;
			with(Player){
				if(race != char_steroids){
					if(is_object(wep) && "skinnedwep" in wep && wep.skinnedwep == other.wep || 
					is_object(bwep) && "skinnedwep" in bwep && bwep.skinnedwep == other.wep){
						reroll = 1;
						didReroll = 1;
						break;
					}
				}
			}
			if(reroll){
				wep = weapon_decide(0, (ammo > 0) + (2 * curse) + GameCont.hard, false, null);
			}
		}
		if(!didReroll){
			reskinned = 1;
			reskin();
		}
	}
	with(Player){
		reskin();
		var temp = wep;
		wep = bwep;
		reskin();
		bwep = wep;
		wep = temp;
	}

#define reskin()
	if(skill_get("prismaticiris")){
		if(is_object(wep) && "irisCheck" not in wep && "skinnedwep" in wep){
			wep.irisCheck = 1;
			wep.reskinned = false;
			wep.wep = wep.skinnedwep;
			return;
		}
		if(mod_variable_get("skill", "prismaticiris", "color") == "prismaticiris"){
			return;
		}else if(is_object(wep) && "skinnedwep" in wep && "reskinned" in wep && wep.reskinned == false){
			wep.reskinned = true;
			wep.wep = "SkinnedWep";
		}
	}
	if(is_object(wep) && "reskinned" in wep){return;}
	var variables = ["sprt", "wepid", "animSprites", "frame", "timer", "waitReload"];
	if(is_object(wep)){
		wep.reskinned = true;
		var s = lq_defget(global.sprites, string(wep.wep), null);
		if(s != null){
			var r = irandom(array_length(s) - 1);
			for(var i = 0; i < array_length(variables); i++){
				lq_set(wep, variables[i], lq_defget(s[r], variables[i], 0));
			}
		}
	}else{
		var s = lq_defget(global.sprites, string(wep), null);
		if(s != null){
			var r = irandom(array_length(s) - 1);
			var _wep = {wep: "SkinnedWep", "skinnedwep":wep, "reskinned" : true}
			for(var i = 0; i < array_length(variables); i++){
				lq_set(_wep, variables[i], lq_defget(s[r], variables[i], 0));
			}
			wep = _wep;
		}
	}

#define AddSprite(name)
	//figure out variables (weapon ID, offset, rarity, etc)
	var split = string_split(string_split(name, ".png")[0], ",");
	var wep = string_trim(string_split(split[0], ";")[0]);
	var offx = real(split[1]);
	var offy = real(split[2]);
	var rarity = real(split[3]);
	var wepid = string_trim(string_trim(string_split(split[0], ";")[0]) + " " + string_trim(split[4]) + " " + (array_length(split) > 5 ? string_trim(split[5]) : ""));
	var list = ds_list_create();
	weapon_get_list(list,-1,1000);
	if real(wep) > 0{
		if real(wep) > 0 && real(wep) < ds_list_size(list) wep = list[| i];
			else trace(wep + " DID NOT GET SPRITED");
	}else{
		d = 0;
		do{
			if string_upper(weapon_get_name(list[| d])) = string_upper(wep) || string_upper(string(list[| d])) = string_upper(wep){
				wep = list[| d];
				break;
			}
			d ++;
		}until d > ds_list_size(list);
	}
	ds_list_destroy(list);
	
	//This is the object that gets added into the list
	var _spr;
	if(array_length(string_split(split[0], ";")) > 1){
		_spr = sprite_add("Sprites/"+name, real(string_split(split[0], ";")[1]), offx, offy);
	}else{
		_spr = sprite_add_weapon("Sprites/"+name, offx, offy);
	}
	var weaponSkin = {"sprt":_spr,"wepid":wepid};
	
	//If animated, load sprites and set up animation
	var arr = [];
	wait file_find_all("Sprites/"+wepid + "/", arr);
	var spriteArr = [];
	//for each item in arr
	for (var i = 0; i < array_length(arr); i++) {
		//if it is a .png, add it as a sprite replacement
		if(arr[i].ext == ".png"){
			var _split = string_split(string_split(arr[i].name, ".png")[0], ",");
			if(array_length(_split) > 1){
				array_push(spriteArr, [sprite_add_weapon("Sprites/" + wepid + "/" + arr[i].name, offx, offy), real(_split[0]), real(_split[1]), array_length(_split) > 2 ? _split[2] : "", arr[i].name]);
			}
		}
	}
	//if there are sprites in this array, we have an animation we need to set up
	if(array_length(spriteArr)){
		array_sort_sub(spriteArr, 1, 1);
		weaponSkin.animSprites = spriteArr;
		weaponSkin.frame = 0;
		weaponSkin.timer = 0;
		weaponSkin.waitReload = 0;
	}
	
	var spr = lq_defget(global.sprites, string(wep), null);
	if(spr == null){
		spr = [];
		repeat(8){array_push(spr, {"sprt":weapon_get_sprite(wep), "wepid":string_trim(string_split(name, ",")[0])+" vanilla"});}
	}
	repeat(rarity){array_push(spr, weaponSkin);}
	lq_set(global.sprites, string(wep), spr);
	
//Yokin script
#define weapon_decide(_hardMin, _hardMax, _gold, _noWep)
	/*
		Returns a random weapon that spawns within the given difficulties
		Takes standard weapon chest spawning conditions into account
		
		Args:
			hardMin - The minimum weapon spawning difficulty
			hardMax - The maximum weapon spawning difficulty
			gold    - Spawn golden weapons like a mansion chest, true/false
			          Use -1 to completely exclude golden weapons
			noWep   - A weapon or array of weapons to exclude from spawning
			
		Ex:
			wep = weapon_decide(0, 1 + (2 * curse) + GameCont.hard, false, null);
			wep = weapon_decide(2, GameCont.hard, false, [p.wep, p.bwep]);
	*/
	
	 // Hardmode:
	_hardMax += ceil((GameCont.hard - (UberCont.hardmode * 13)) / (1 + (UberCont.hardmode * 2))) - GameCont.hard;
	
	 // Robot:
	for(var i = 0; i < maxp; i++){
		if(player_get_race(i) == "robot"){
			_hardMax++;
		}
	}
	_hardMin += 5 * ultra_get("robot", 1);
	
	 // Just in Case:
	_hardMax = max(0, _hardMax);
	_hardMin = min(_hardMin, _hardMax);
	
	 // Default:
	var _wepDecide = wep_screwdriver;
	if("wep" in self && wep != wep_none){
		_wepDecide = wep;
	}
	else if(_gold > 0){
		_wepDecide = choose(wep_golden_wrench, wep_golden_machinegun, wep_golden_shotgun, wep_golden_crossbow, wep_golden_grenade_launcher, wep_golden_laser_pistol);
		if(GameCont.loops > 0 && random(2) < 1){
			_wepDecide = choose(wep_golden_screwdriver, wep_golden_assault_rifle, wep_golden_slugger, wep_golden_splinter_gun, wep_golden_bazooka, wep_golden_plasma_gun);
		}
	}
	
	 // Decide:
	var	_list    = ds_list_create(),
		_listMax = weapon_get_list(_list, _hardMin, _hardMax);
		
	ds_list_shuffle(_list);
	
	for(var i = 0; i < _listMax; i++){
		var	_wep    = ds_list_find_value(_list, i),
			_canWep = true;
			
		 // Weapon Exceptions:
		if(_wep == _noWep || (is_array(_noWep) && array_find_index(_noWep, _wep) >= 0)){
			_canWep = false;
		}
		
		 // Gold Check:
		else if((_gold > 0 && !weapon_get_gold(_wep)) || (_gold < 0 && weapon_get_gold(_wep) == 0)){
			_canWep = false;
		}
		
		 // Specific Spawn Conditions:
		else switch(_wep){
			case wep_super_disc_gun       : if("curse" not in self || curse <= 0) _canWep = false; break;
			case wep_golden_nuke_launcher : if(!UberCont.hardmode)                _canWep = false; break;
			case wep_golden_disc_gun      : if(!UberCont.hardmode)                _canWep = false; break;
			case wep_gun_gun              : if(crown_current != crwn_guns)        _canWep = false; break;
		}
		
		 // Success:
		if(_canWep){
			_wepDecide = _wep;
			break;
		}
	}
	
	ds_list_destroy(_list);
	
	return _wepDecide;