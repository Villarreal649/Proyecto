#define init
global.rpg = sprite_add("extras/RPG.png",1,4,4);
global.nerfDart = sprite_add("extras/Nerf Dart.png",1,-6,3);
global.nerfDartMega = sprite_add("extras/Nerf Dart Mega.png",1,12,3);
global.bomb = sprite_add("extras/Bomb.png",1,3,3);
global.mSwordGlow = sprite_add_weapon("sprites/Black Sword,4,4,1,Mufina,2.png",4,4);
global.purpPlasma = [sprite_add("extras/purpPlasmaTrail.png",3,4,4),sprite_add("extras/purpPlasmaImpact.png",7,16,16),sprite_add("extras/purpPlasmaBall.png",2,12,12),sprite_add("extras/purpPlasmaBallBig.png",2,16,16),sprite_add("extras/purpPlasmaBallHuge.png",2,24,24)];
global.purpSlash = sprite_add("extras/purpSlash.png",3,0,24);
global.purpEnergySlash = sprite_add("extras/purpEnergySlash.png",3,0,24);
global.fishSlash = sprite_add("extras/fishSlash.png",3,0,24);
global.honeySlash = sprite_add("extras/honeySlash.png",3,0,24);
global.goldFlare = sprite_add("extras/goldFlare.png",2,3,3);
global.goldFire = sprite_add("extras/goldFire.png",7,8,8);
global.ultraFlameBall = sprite_add("extras/ultraFlameBall.png",6,16,16);
global.ultraFire = sprite_add("extras/ultraFire.png",7,8,8);
global.popoFlameBall = sprite_add("extras/popoFlameBall.png",6,16,16);
global.popoFire = sprite_add("extras/popoFire.png",7,8,8);
global.redSlug = sprite_add("extras/redSlug.png",2,12,12);
global.redSlugHit = sprite_add("extras/redSlugHit.png",4,16,16);
global.redSlugDisappear = sprite_add("extras/redSlugDisappear.png",6,12,12);
global.redHeavySlug = sprite_add("extras/redHeavySlug.png",2,16,16);
global.redHeavySlugHit = sprite_add("extras/redHeavySlugHit.png",4,24,24);
global.redHeavySlugDisappear = sprite_add("extras/redHeavySlugDisappear.png",6,16,16);
global.blueShell = sprite_add("extras/blueShell.png",2,8,8);
global.blueShellDisappear = sprite_add("extras/blueShellDisappear.png",5,8,8);
global.blueFlak = sprite_add("extras/blueFlak.png",2,8,8);
global.blueFlakExplo = sprite_add("extras/blueFlakExplosion.png",8,16,16);
global.blueSuperFlak = sprite_add("extras/blueSuperFlak.png",2,12,12);
global.blueSuperFlakExplo = sprite_add("extras/blueSuperFlakExplosion.png",9,24,24);
global.doomRocket = sprite_add("extras/doomRocket.png",1,8,4);
global.doomPlasma = [sprite_add("extras/doomPlasmaTrail.png",3,4,4),sprite_add("extras/doomPlasmaImpact.png",7,16,16),sprite_add("extras/doomPlasmaBall.png",2,12,12)];
global.bfgPlasma = [sprite_add("extras/bfgPlasmaTrail.png",3,4,4),sprite_add("extras/bfgPlasmaImpact.png",7,16,16),sprite_add("extras/bfgPlasmaBall.png",2,12,12),sprite_add("extras/bfgPlasmaBallBig.png",2,16,16),sprite_add("extras/bfgPlasmaBallHuge.png",2,24,24),sprite_add("extras/bfgPlasmaHugeImpact.png",6,30,24)];
global.goldSlash = sprite_add("extras/goldSlash.png",3,0,24);
global.baseball = sound_add("extras/baseballHit.ogg");
global.supernovaflame = sprite_add("extras/SuperNova618 Flame.png", 10, 16, 16);
global.deactivatedminigun = sprite_add_weapon("extras/Plasma Minigun, SuperNova618, deactivated.png", 9, 8);
global.aceLightningSpawn = sprite_add("extras/sprLightningSpawn.png", 4, 12, 12);
global.aceLightningHit = sprite_add("extras/sprLightningHit.png", 4, 12, 12);
global.aceLightning = sprite_add("extras/sprLightning.png", 4, 0, 1);
global.aceLightningBall = sprite_add("extras/sprLightningBall.png", 4, 16, 16);
global.aceLightningSlash = sprite_add("extras/sprLightningSlash.png", 4, -8, 24);
global.popoClusterNade = sprite_add("extras/popoClusterNade.png", 1, 3, 3);
global.popoMiniNade = sprite_add("extras/PopoMininade.png", 1, 2, 2);
global.blueSmallExplosion = sprite_add("extras/BlueSmallExplosion.png", 7, 12, 12);
global.blueExplosion = sprite_add("extras/BlueExplosion.png", 9, 24, 24);
global.popoHeavyNade = sprite_add("extras/PopoHeavyNade.png", 1, 4, 4);


global.burstList = [];
global.hitList = [];
global.disappearList = [];
global.scriptList = [];
global.bind_step = noone;
global.bind_step2 = noone;
global.idNum = 0;

if(!instance_exists(global.bind_step)){
	global.bind_step = script_bind_step(post_step, 0, "step");
}
if(!instance_exists(global.bind_step2)){
	global.bind_step2 = script_bind_end_step(post_step, 0, "end");
}
    
#define cleanup
	with(global.bind_step){
		instance_destroy();
	}
	with(global.bind_step2){
		instance_destroy();
	}

#define weapon_name(_wep)
  return is_object(_wep) ? weapon_get_name(_wep.skinnedwep) : "SkinnedWep";
#define weapon_type(_wep)
  return is_object(_wep) ? weapon_get_type(_wep.skinnedwep) : 0;
#define weapon_cost(_wep)
  return is_object(_wep) ? weapon_get_cost(_wep.skinnedwep) : 0;
#define weapon_area(_wep)
  return -1;
#define weapon_rads(_wep)
  return is_object(_wep) ? weapon_get_rads(_wep.skinnedwep) : 0;
#define weapon_load(_wep)
  return is_object(_wep) ? weapon_get_load(_wep.skinnedwep) : 0;
#define weapon_swap(_wep)
  return is_object(_wep) ? weapon_get_swap(_wep.skinnedwep) : 0;
#define weapon_auto(_wep)
  return is_object(_wep) ? weapon_get_auto(_wep.skinnedwep) : 0;
#define weapon_gold(_wep)
  return is_object(_wep) ? weapon_get_gold(_wep.skinnedwep) : 0;
#define weapon_melee(_wep)
  return is_object(_wep) ? weapon_is_melee(_wep.skinnedwep) : 0;
#define weapon_laser_sight(_wep)
  return is_object(_wep) ? weapon_get_laser_sight(_wep.skinnedwep) : 0;
#define weapon_raw(_wep)
  return is_object(_wep) ? _wep.skinnedwep : "SkinnedWep";
#define weapon_sprt(_wep)
	if(!(is_object(_wep) && "sprt" in _wep && sprite_exists(_wep.sprt))){return mskNone;}
	var retVal = _wep.sprt;
	if(is_array(_wep.animSprites) && array_length(_wep.animSprites)){
		if("lastTime" in _wep && _wep.lastTime != current_frame){
			if(!isFiring(_wep) && _wep.waitReload == -1){
				_wep.waitReload = 0;
			}
			if(_wep.timer > 0 && _wep.waitReload == 0){
				_wep.timer -= current_time_scale * 0.4;
			}
			while(_wep.timer <= 0){
				_wep.frame++;
				_wep.frame %= array_length(_wep.animSprites);
				_wep.timer += _wep.animSprites[_wep.frame][2];
				var mods = _wep.animSprites[_wep.frame][3];
				for(var i = 1; i <= string_length(mods); i++){
					switch(string_char_at(mods, i)){
						case "r":
							_wep.waitReload = 1;
							_wep.timer = _wep.animSprites[_wep.frame][2];
							break;
						case "R":
							_wep.waitReload = -1;
							_wep.timer = _wep.animSprites[_wep.frame][2];
							break;
						case "n":
							if(isFiring(_wep)){
								_wep.timer = 0;
								_wep.waitReload = 0;
							}
							break;
						case "j":
							i++;
							switch(string_char_at(mods, i)){
								case "r":
									i++;
									if(isFiring(_wep)){
										var c = string_char_at(mods, i);
										var mult = 1;
										_wep.frame = 0;
										while(string(real(c)) == c){
											_wep.frame += real(c) * mult;
											mult *= 10;
											i++;
											c = string_char_at(mods, i);
										}
										_wep.frame--;
										_wep.timer = 0;
									}else{
										var c = string_char_at(mods, i);
										while(string(real(c)) == c){
											i++;
											c = string_char_at(mods, i);
										}
									}
									break;
								case "n":
									i++;
									if(!isFiring(_wep)){
										var c = string_char_at(mods, i);
										var mult = 1;
										_wep.frame = 0;
										while(string(real(c)) == c){
											_wep.frame += real(c) * mult;
											mult *= 10;
											i++;
											c = string_char_at(mods, i);
										}
										_wep.frame--;
										_wep.timer = 0;
									}else{
										var c = string_char_at(mods, i);
										while(string(real(c)) == c){
											i++;
											c = string_char_at(mods, i);
										}
									}
									break;
							}
							break;
						default:
							break;
					}
				}
			}
		}
		_wep.lastTime = current_frame;
		if(_wep.frame >= 0 && _wep.frame < array_length(_wep.animSprites) && sprite_exists(_wep.animSprites[_wep.frame][0])){
			retVal = _wep.animSprites[_wep.frame][0];
		}
	}
	switch(_wep.wepid){
		case "Black Sword Mufina":
			if(array_length(instances_matching(Player, "my_health", 0)) || array_length(instances_matching_ne(enemy, "intro", null)) || array_length(instances_matching_ne(enemy, "bossname", null))){
				retVal = global.mSwordGlow;
			}
			break;
		case "Plasma Minigun SuperNova618":
			with(Player){
				if(bwep == _wep){retVal = global.deactivatedminigun;}
			}
			break;
		default:
	}
	return retVal;

#define weapon_fire(_wep)
	if(!instance_exists(global.bind_step)){
		global.bind_step = script_bind_step(post_step, 0, "step");
	}
	if(!instance_exists(global.bind_step2)){
		global.bind_step2 = script_bind_end_step(post_step, 0, "end");
	}
	if("waitReload" in _wep && _wep.waitReload == 1){
		_wep.waitReload = 0;
	}
	if(is_array(_wep.animSprites) && array_length(_wep.animSprites) > 2 && _wep.frame >= 0){
		var mods = _wep.animSprites[_wep.frame][3];
		for(var i = 1; i <= string_length(mods); i++){
			switch(string_char_at(mods, i)){
				case "s":
					_wep.timer = 0;
					_wep.frame = -1;
					break;
				default:
					break;
			}
		}
	}
	
	var _snd = stopSound_setup();
	
	var	_lastLoad = reload,
		_lastRads = GameCont.rad;
	
	var _fireID = instance_create(0,0,DramaCamera);
	
	if(instance_is(self, Player)){
		var _lastAmmo = array_clone(ammo),
			 _swap     = wep_swap(true, [true], _wep);
		
		player_fire();
		
		if(instance_exists(self)){
			if(_swap != false){
				wep_swap(_swap[0], _swap[1], _wep);
			}
			array_copy(ammo, 0, _lastAmmo, 0, array_length(_lastAmmo));
		}
	}
	else player_fire_ext(gunangle, (_wep.skinnedwep), x, y, team, (("creator" in self) ? creator : self), accuracy);
	
	if(instance_exists(self)){
		reload = _lastLoad;
	}
	GameCont.rad = _lastRads;
	
	/*if(instance_exists(LaserBrain)){
		with(instances_matching_gt(LaserBrain, "id", _fireID)){
			instance_delete(self);
		}
	}
	if(instance_exists(SteroidsTB)){
		with(instances_matching_gt(SteroidsTB, "id", _fireID)){
			if(instance_is(self + 1, PopupText)){
				instance_delete(self + 1);
			}
			instance_delete(self);
		}
	}*/
	
	switch(_wep.wepid){
		case "Crossbow Golden Epsilon Unicorn":
		case "Auto Crossbow Golden Epsilon Unicorn":
			with(instances_matching_gt(Bolt, "id", _fireID)){
				if(fork()){
					var c = random(255);
					while(instance_exists(self)){
						with(instance_create(x,y,BoltTrail)){
							image_blend = make_color_hsv(c,255,255);
							image_angle = other.image_angle;
							image_xscale = other.speed;
							image_yscale *= 2;
						}
						c+=10*current_time_scale;
						c %= 255;
						wait(0);
					}
					exit;
				}
			}
			break;
		case "Super Crossbow Golden Epsilon Unicorn":
			with(instances_matching_gt(Bolt, "id", _fireID)){
				if(fork()){
					var c = (current_frame*10) % 255;
					while(instance_exists(self)){
						with(instance_create(x,y,BoltTrail)){
							image_blend = make_color_hsv(c,255,255);
							image_angle = other.image_angle;
							image_xscale = other.speed;
							image_yscale *= 2;
						}
						c+=10*current_time_scale;
						c %= 255;
						wait(0);
					}
					exit;
				}
			}
			break;
		case "Heavy Crossbow Golden Epsilon Unicorn":
		case "Heavy Auto Crossbow Golden Epsilon Unicorn":
			with(instances_matching_gt(HeavyBolt, "id", _fireID)){
				if(fork()){
					var c = (current_frame*10) % 255;
					while(instance_exists(self)){
						with(instance_rectangle(x-15,y-15,x+15,y+15,instances_matching_le(enemy, "my_health", 0))){
							repeat(15){
								with(instance_create(x,y,Confetti)){
									speed = random_range(2,8);
									direction = random(360);
								}
							}
						}
						with(instance_create(x,y,BoltTrail)){
							image_blend = make_color_hsv(c,255,255);
							image_angle = other.image_angle;
							image_xscale = other.speed;
							image_yscale *= 4;
						}
						c+=10*current_time_scale;
						c %= 255;
						wait(0);
					}
					exit;
				}
			}
			break;
		case "Disc Gun Golden Epsilon Unicorn":
			with(instances_matching_gt(Disc, "id", _fireID)){
				if(fork()){
					var c = (current_frame*10) % 255;
					while(instance_exists(self)){
						with(instance_rectangle(x-15,y-15,x+15,y+15,instances_matching_le(enemy, "my_health", 0))){
							repeat(15){
								with(instance_create(x,y,Confetti)){
									speed = random_range(2,8);
									direction = random(360);
								}
							}
						}
						with(instance_create(x,y,BoltTrail)){
							image_blend = make_color_hsv(c,255,255);
							image_angle = other.direction;
							image_xscale = other.speed;
							image_yscale *= 6;
						}
						c+=10*current_time_scale;
						c %= 255;
						wait(0);
					}
					exit;
				}
			}
			break;
		case "Revolver Golden Epsilon Unicorn":
		case "Machinegun Golden Epsilon Unicorn":
		case "Minigun Golden Epsilon Unicorn":
			with(instances_matching_gt(Bullet1, "id", _fireID)){
				if(fork()){
					var c = (current_frame*10) % 255;
					while(instance_exists(self)){
						with(instance_create(x,y,BoltTrail)){
							image_blend = make_color_hsv(c,255,255);
							image_angle = other.image_angle;
							image_xscale = other.speed;
							image_yscale *= 2;
						}
						c+=10*current_time_scale;
						c %= 255;
						wait(0);
					}
					exit;
				}
			}
			break;
		case "Revolver Golden Epsilon Downwell":
		case "Machinegun Golden Epsilon Downwell":
		case "SMG Golden Epsilon Downwell":
		case "Triple Machinegun Golden Epsilon Downwell":
		case "Quadruple Machinegun Golden Epsilon Downwell":
		case "Minigun Golden Epsilon Downwell":
		case "Double Minigun Golden Epsilon Downwell":
			with(instances_matching_gt(Bullet1, "id", _fireID)){
				image_blend = c_red;
			}
			proj_addOnHit(x,y,self,Bullet1,5,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_red]]);
			break;
		case "Assault Rifle Golden Epsilon Downwell":
			makeBurst(instances_matching_gt(Burst, "id", _fireID), script_ref_create(proj_call), Bullet1, 5, script_ref_create(recolor), [c_red]);
			makeBurst(instances_matching_gt(Burst, "id", _fireID), script_ref_create(proj_addOnHit), Bullet1, 5, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_red]]);
			break;
		case "Heavy Machinegun Golden Epsilon Downwell":
			with(instances_matching_gt(HeavyBullet, "id", _fireID)){
				image_blend = c_red;
			}
			proj_addOnHit(x,y,self,HeavyBullet,5,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_red]]);
			break;
		case "Heavy Assault Rifle Golden Epsilon Downwell":
			makeBurst(instances_matching_gt(HeavyBurst, "id", _fireID), script_ref_create(proj_call), HeavyBullet, 5, script_ref_create(recolor), [c_red]);
			makeBurst(instances_matching_gt(HeavyBurst, "id", _fireID), script_ref_create(proj_addOnHit), HeavyBullet, 5, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_red]]);
			break;
		case "Shotgun Golden Epsilon Downwell":
		case "Auto Shotgun Golden Epsilon Downwell":
		case "Sawed-Off Shotgun Golden Epsilon Downwell":
		case "Double Shotgun Golden Epsilon Downwell":
		case "Pop Gun Golden Epsilon Downwell":
			with(instances_matching_gt(Bullet2, "id", _fireID)){
				image_blend = c_red;
			}
			proj_addOnHit(x,y,self,Bullet2,5,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_red]]);
			break;
		case "Pop Rifle Golden Epsilon Downwell":
			makeBurst(instances_matching_gt(PopBurst, "id", _fireID), script_ref_create(proj_call), Bullet2, 5, script_ref_create(recolor), [c_red]);
			makeBurst(instances_matching_gt(PopBurst, "id", _fireID), script_ref_create(proj_addOnHit), Bullet2, 5, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_red]]);
			break;
		
		case "Revolver Golden Epsilon Soaker":
		case "Machinegun Golden Epsilon Soaker":
		case "SMG Golden Epsilon Soaker":
		case "Triple Machinegun Golden Epsilon Soaker":
		case "Minigun Golden Epsilon Soaker":
			with(instances_matching_gt(Bullet1, "id", _fireID)){
				image_blend = c_aqua;
			}
			proj_addOnHit(x,y,self,Bullet1,5,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_aqua]]);
			break;
		case "Assault Rifle Golden Epsilon Soaker":
			makeBurst(instances_matching_gt(Burst, "id", _fireID), script_ref_create(proj_call), Bullet1, 5, script_ref_create(recolor), [c_aqua]);
			makeBurst(instances_matching_gt(Burst, "id", _fireID), script_ref_create(proj_addOnHit), Bullet1, 5, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [c_aqua]]);
			break;
		case "Bazooka SpazProjects":
			with(instances_matching_gt(Rocket, "id", _fireID)){
				sprite_index = global.rpg;
			}
			break;
		case "Sledgehammer SpazProjects":
			sound_play_pitchvol(sndMutant9Slct,random_range(2,4),random_range(4,6.6));
			break;
		case "Splinter Pistol SpazProjects Nerf":
		case "Splinter Gun SpazProjects Nerf":
			repSpr(Splinter, global.nerfDart, _fireID);
			break;
		case "Super Splinter Gun SpazProjects Nerf":
			repeat(8){
				with(instance_rectangle(x-30,y-30,x+30,y+30,instances_matching_gt(Splinter, "id", _fireID))){
					sprite_index = global.nerfDart;
				}
				wait(1);
			}
			break;
		case "Heavy Crossbow SpazProjects Nerf":
		case "Heavy Auto Crossbow SpazProjects Nerf":
			resprite(instances_matching_gt(HeavyBolt, "id", _fireID), global.nerfDartMega);
			break;
		case "Grenade Launcher smashy":
			with(instances_matching_gt(Grenade, "id", _fireID)){
				sprite_index = global.bomb;
			}
			break;
		case "Super Plasma Cannon beeb Purple":
			repSpr(PlasmaHuge,global.purpPlasma[4], _fireID);
			makeBurst(instances_matching_gt(PlasmaHuge, "id", _fireID), script_ref_create(effect_call), PlasmaTrail, 25, script_ref_create(resprite), [global.purpPlasma[0]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0",[script_ref_create(proj_call),PlasmaBig, 15, script_ref_create(resprite), [global.purpPlasma[3]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0",[script_ref_create(effect_call), PlasmaBig, 15, script_ref_create(makeBurst), [script_ref_create(effect_call), PlasmaTrail, 15, script_ref_create(resprite), [global.purpPlasma[0]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag1",[script_ref_create(effect_call),PlasmaImpact, 15, script_ref_create(resprite), [global.purpPlasma[1]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag2",[script_ref_create(proj_call),PlasmaBall, 15, script_ref_create(resprite), [global.purpPlasma[2]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag3",[script_ref_create(proj_addOnHit),PlasmaBall, 15, "tag1", [script_ref_create(effect_call),PlasmaImpact, 5, script_ref_create(resprite), [global.purpPlasma[1]]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag4",[script_ref_create(effect_call),PlasmaBall, 15, script_ref_create(makeBurst), [script_ref_create(effect_call), PlasmaTrail, 15, script_ref_create(resprite), [global.purpPlasma[0]]]]]);
			break;
		case "Ultra Shovel beeb Purple":
			with(instances_matching(instances_matching(Slash,"creator",self), "sprite_index", sprUltraSlash)){
				sprite_index = global.purpSlash;
			}
			break;
		case "Energy Sword beeb Purple":
			with(instances_matching_gt(EnergySlash, "id", _fireID)){
				sprite_index = global.purpEnergySlash;
			}
			break;
		case "Ultra Shovel beeb Fish":
			with(instances_matching(instances_matching(Slash,"creator",self), "sprite_index", sprUltraSlash)){
				sprite_index = global.fishSlash;
			}
			break;
		case "Flare Gun beeb Gold":
			resprite(instances_matching_gt(Flare, "id", _fireID), global.goldFlare);
			makeBurst(instances_matching_gt(Flare, "id", _fireID), script_ref_create(effect_call), Flame, 5, script_ref_create(resprite), [global.goldFire]);
			break;
		case "Flame Cannon beeb Ultra":
			resprite(instances_matching_gt(FlameBall, "id", _fireID), global.ultraFlameBall);
			makeBurst(instances_matching_gt(FlameBall, "id", _fireID), script_ref_create(effect_call), Flame, 5, script_ref_create(resprite), [global.ultraFire]);
			break;
		case "Flame Cannon Shane Popo":
			resprite(instances_matching_gt(FlameBall, "id", _fireID), global.popoFlameBall);
			makeBurst(instances_matching_gt(FlameBall, "id", _fireID), script_ref_create(effect_call), Flame, 5, script_ref_create(resprite), [global.popoFire]);
			break;
		case "Flamethrower GoldenEpsilon Popo":
			makeBurst(instances_matching_gt(FlameBurst, "id", _fireID), script_ref_create(effect_call), Flame, 15, script_ref_create(resprite), [global.popoFire]);
			break;
		case "Guitar bean":
			repSpr(GuitarSlash,global.honeySlash, _fireID);
			break;
		case "Slugger SpazProjects":
		case "Gatling Slugger SpazProjects":
		case "Super Slugger SpazProjects":
			proj_call(x,y,self,Slug,5,script_ref_create(resprite),[global.redSlug]);
			proj_addOnHit(x,y,self,Slug,5,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(resprite), [global.redSlugHit]]);
			repDis(x,y,self,Slug,5,sprSlugDisappear,global.redSlugDisappear);
			break;
		case "Assault Slugger SpazProjects":
			makeBurst(instances_matching_gt(SlugBurst, "id", _fireID), script_ref_create(proj_call), Slug, 5, script_ref_create(resprite), [global.redSlug]);
			makeBurst(instances_matching_gt(SlugBurst, "id", _fireID), script_ref_create(proj_addOnHit), Slug, 5, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(resprite), [global.redSlugHit]]);
			makeBurst(instances_matching_gt(SlugBurst, "id", _fireID), script_ref_create(repDis), Slug, 5, sprSlugDisappear, global.redSlugDisappear);
			break;
		case "Hyper Slugger SpazProjects":
			repDis(x,y,self,HyperSlug,5,sprHyperSlugDisappear,global.redHeavySlugDisappear);
			with(instance_rectangle(x-5,y-5,x+5,y+5,instances_matching_gt(HyperSlug, "id", _fireID))){
				sprite_index = global.redSlug;
				if(fork()){
					var _x = x;
					var _y = y;
					wait(2);
					if(instance_exists(self)){
						with(instance_create(x,y,BoltTrail)){
							image_blend = c_red;
							image_alpha = 0.6;
							image_angle = point_direction(x,y,_x,_y);
							image_xscale = point_distance(_x,_y,x,y);
							image_yscale *= 2;
						}
					}
					while(instance_exists(self)){
						_x = x;
						_y = y;
						wait(0);
					}
					with(instance_nearest(_x,_y,BulletHit)){sprite_index = global.redSlugHit;}
					exit;
				}
			}
			break;
		case "Heavy Slugger SpazProjects":
			repDis(x,y,self,HeavySlug,5,sprHeavySlugDisappear,global.redHeavySlugDisappear);
			with(instance_rectangle(x-5,y-5,x+5,y+5,instances_matching_gt(HeavySlug, "id", _fireID))){
				if(sprite_index == sprHeavySlug){sprite_index = global.redHeavySlug;}
				if(fork()){
					var _x = x;
					var _y = y;
					while(instance_exists(self)){
						with(instance_create(x,y,BoltTrail)){
							image_blend = c_red;
							image_alpha = 0.6;
							image_angle = other.direction;
							image_xscale = other.speed - other.friction;
							image_yscale *= 4;
						}
						_x = x;
						_y = y;
						wait(0);
					}
					with(instance_nearest(_x,_y,BulletHit)){sprite_index = global.redHeavySlugHit;}
					exit;
				}
			}
			break;
		case "Laser Minigun Exclusive":
			with(instances_matching_ne(instances_matching_gt(Laser, "id", _fireID), "skinned", true)){
				sprite_index = sprEnemyLaser;
			}
			break;
		case "Shotgun cheese curd blue":
		case "Double Shotgun cheese curd blue":
		case "Double Shotgun cheese curd blue 2":
		case "Sawed-Off Shotgun cheese curd blue":
		case "Auto Shotgun cheese curd blue":
			repSpr(Bullet2,global.blueShell, _fireID);
			proj_addOnHit(x,y,self,Bullet2,5,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(resprite), [global.blueShellDisappear]]);
			repDis(x,y,self,Bullet2,5,sprBullet2Disappear,global.blueShellDisappear);
			break;
		case "Flak Cannon cheese curd blue":
			repSpr(FlakBullet,global.blueFlak, _fireID);
			proj_addOnHit(x,y,self,FlakBullet,5,"tag1",[script_ref_create(effect_call),BulletHit, 15, script_ref_create(resprite), [global.blueFlakExplo]]);
			proj_addOnHit(x,y,self,FlakBullet,5,"tag2",[script_ref_create(proj_call),Bullet2, 15, script_ref_create(resprite), [global.blueShell]]);
			proj_addOnHit(x,y,self,FlakBullet,5,"tag3",[script_ref_create(proj_addOnHit),Bullet2, 15, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(resprite), [global.blueShellDisappear]]]);
			proj_addOnHit(x,y,self,FlakBullet,5,"tag4",[script_ref_create(repDis),Bullet2, 15, sprBullet2Disappear, global.blueShellDisappear]);
			break;
		case "Super Flak Cannon cheese curd blue":
		case "Super Flak Cannon cheese curd blue 2":
			repSpr(SuperFlakBullet,global.blueSuperFlak, _fireID);
			proj_addOnHit(x,y,self,SuperFlakBullet,5,"tag0",[script_ref_create(effect_call),BulletHit, 15, script_ref_create(resprite), [global.blueSuperFlakExplo]]);
			proj_addOnHit(x,y,self,SuperFlakBullet,5,"tag0",[script_ref_create(proj_call),FlakBullet, 15, script_ref_create(resprite), [global.blueFlak]]);
			proj_addOnHit(x,y,self,SuperFlakBullet,5,"tag0", [script_ref_create(proj_addOnHit),FlakBullet,15,"tag1",[script_ref_create(effect_call),BulletHit, 15, script_ref_create(resprite), [global.blueFlakExplo]]]);
			proj_addOnHit(x,y,self,SuperFlakBullet,5,"tag0", [script_ref_create(proj_addOnHit),FlakBullet,15,"tag2",[script_ref_create(proj_call),Bullet2, 15, script_ref_create(resprite), [global.blueShell]]]);
			proj_addOnHit(x,y,self,SuperFlakBullet,5,"tag0", [script_ref_create(proj_addOnHit),FlakBullet,15,"tag3",[script_ref_create(proj_addOnHit),Bullet2, 15, "tag1", [script_ref_create(effect_call),BulletHit, 5, script_ref_create(resprite), [global.blueShellDisappear]]]]);
			proj_addOnHit(x,y,self,SuperFlakBullet,5,"tag0", [script_ref_create(proj_addOnHit),FlakBullet,15,"tag4",[script_ref_create(repDis),Bullet2, 15, sprBullet2Disappear, global.blueShellDisappear]]);
			break;
		case "Bazooka Igston DOOM":
			repSpr(Rocket, global.doomRocket, _fireID);
			break;
		case "Plasma Rifle Igston DOOM":
			repSpr(PlasmaBall,global.doomPlasma[2], _fireID);
			makeBurst(instances_matching_gt(PlasmaBall, "id", _fireID), script_ref_create(effect_call), PlasmaTrail, 15, script_ref_create(resprite), [global.doomPlasma[0]]);
			proj_addOnHit(x,y,self,PlasmaBall,5,"tag0",[script_ref_create(effect_call),PlasmaImpact, 15, script_ref_create(resprite), [global.doomPlasma[1]]]);
			break;
		case "Super Plasma Cannon Igston DOOM":
			repSpr(PlasmaHuge,global.bfgPlasma[4], _fireID);
			makeBurst(instances_matching_gt(PlasmaHuge, "id", _fireID), script_ref_create(effect_call), PlasmaTrail, 25, script_ref_create(resprite), [global.bfgPlasma[0]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0",[script_ref_create(effect_create),CaveSparkle, 0, global.bfgPlasma[5], 0]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0",[script_ref_create(proj_call),PlasmaBig, 15, script_ref_create(resprite), [global.bfgPlasma[3]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0",[script_ref_create(effect_call), PlasmaBig, 15, script_ref_create(makeBurst), [script_ref_create(effect_call), PlasmaTrail, 15, script_ref_create(resprite), [global.bfgPlasma[0]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag1",[script_ref_create(effect_call),PlasmaImpact, 15, script_ref_create(resprite), [global.bfgPlasma[1]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag2",[script_ref_create(proj_call),PlasmaBall, 15, script_ref_create(resprite), [global.bfgPlasma[2]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag3",[script_ref_create(proj_addOnHit),PlasmaBall, 15, "tag1", [script_ref_create(effect_call),PlasmaImpact, 5, script_ref_create(resprite), [global.bfgPlasma[1]]]]]);
			proj_addOnHit(x,y,self,PlasmaHuge,5,"tag0", [script_ref_create(proj_addOnHit),PlasmaBig,15,"tag4",[script_ref_create(effect_call),PlasmaBall, 15, script_ref_create(makeBurst), [script_ref_create(effect_call), PlasmaTrail, 15, script_ref_create(resprite), [global.bfgPlasma[0]]]]]);
			break;
		case "Energy Hammer SpazProjects":
			with(instances_matching_gt(EnergyHammerSlash, "id", _fireID)){
				sprite_index = global.goldSlash;
			}
		case "Wrench Liz v Valentine Baseball":
			with(instances_matching_gt(Slash, "id", _fireID)){
				if(distance_to_object(enemy) == 0 || distance_to_object(Wall) == 0 || distance_to_object(projectile) == 0){
					sound_play_pitch(global.baseball,random_range(0.9,1.1));
				}
			}
			break;
		case "Laser Rifle SuperNova618":
			with(instances_matching_gt(Laser, "id", _fireID)){
				image_blend = make_color_rgb(100, 200, 255);
			}
			break;
		case "Dragon SuperNova618":
			makeBurst(instances_matching_gt(DragonBurst, "id", _fireID), script_ref_create(proj_call), Flame, 15, script_ref_create(resprite), [global.supernovaflame]);
			break;
		case "Plasma Minigun SuperNova618":
			repSpr(PlasmaBall,sprPopoPlasma, _fireID);
			makeBurst(instances_matching_gt(PlasmaBall, "id", _fireID), script_ref_create(effect_call), PlasmaTrail, 15, script_ref_create(resprite), [sprPopoPlasmaTrail]);
			proj_addOnHit(x,y,self,PlasmaBall,5,"tag0",[script_ref_create(effect_call),PlasmaImpact, 15, script_ref_create(resprite), [sprPopoPlasmaImpact]]);
			break;
		case "Lightning Pistol SpazProjects Ace":
		case "Lightning SMG SpazProjects Ace":
		case "Lightning Rifle SpazProjects Ace":
		case "Lightning Shotgun SpazProjects Ace":
			repSpr(Lightning, global.aceLightning, _fireID);
			repSpr(LightningSpawn, global.aceLightningSpawn, _fireID);
			repSpr(LightningHit, global.aceLightningHit, _fireID);
			break;
		//LHammer and LCannon affect more lightning than I'd like
		case "Lightning Hammer SpazProjects Ace":
			repSpr(LightningSlash, global.aceLightningSlash, _fireID);
			makeBurst(instances_matching_gt(LightningSlash, "id", _fireID), script_ref_create(effect_call), Lightning, 250, script_ref_create(resprite), [global.aceLightning]);
			makeBurst(instances_matching_gt(LightningSlash, "id", _fireID), script_ref_create(effect_call), LightningSpawn, 250, script_ref_create(resprite), [global.aceLightningSpawn]);
			makeBurst(instances_matching_gt(LightningSlash, "id", _fireID), script_ref_create(effect_call), LightningHit, 250, script_ref_create(resprite), [global.aceLightningHit]);
			break;
		case "Lightning Cannon SpazProjects Ace":
			repSpr(LightningBall, global.aceLightningBall, _fireID);
			makeBurst(instances_matching_gt(LightningBall, "id", _fireID), script_ref_create(effect_call), Lightning, 250, script_ref_create(resprite), [global.aceLightning]);
			makeBurst(instances_matching_gt(LightningBall, "id", _fireID), script_ref_create(effect_call), LightningSpawn, 250, script_ref_create(resprite), [global.aceLightningSpawn]);
			makeBurst(instances_matching_gt(LightningBall, "id", _fireID), script_ref_create(effect_call), LightningHit, 250, script_ref_create(resprite), [global.aceLightningHit]);
			break;
		case "Cluster Launcher Mr. Mediocre Popo":
			repSpr(ClusterNade, global.popoClusterNade, _fireID);
			proj_addOnHit(x,y,self,ClusterNade,15,"tag1",[script_ref_create(effect_call), MiniNade, 5, script_ref_create(resprite), [global.popoMiniNade]]);
			proj_addOnHit(x,y,self,ClusterNade,15,"tag2",[script_ref_create(proj_addOnHit),MiniNade, 5, "tag1", [script_ref_create(effect_call), SmallExplosion, 5, script_ref_create(resprite), [global.blueSmallExplosion]]]);
			break;
		case "Grenade Shotgun Mr. Mediocre Popo":
			repSpr(MiniNade, global.popoMiniNade, _fireID);
			proj_addOnHit(x,y,self,MiniNade,15,"tag1",[script_ref_create(effect_call), SmallExplosion, 5, script_ref_create(resprite), [global.blueSmallExplosion]]);
			break;
		case "Grenade Rifle Mr. Mediocre Popo":
			repeat(4){
				repSpr(MiniNade, global.popoMiniNade, _fireID);
				proj_addOnHit(x,y,self,MiniNade,15,"tag1",[script_ref_create(effect_call), SmallExplosion, 5, script_ref_create(resprite), [global.blueSmallExplosion]]);
				wait(1);
			}
			break;
		case "Heavy Grenade Launcher Mr. Mediocre Popo":
			repSpr(HeavyNade, global.popoMiniNade, _fireID);
			proj_addOnHit(x,y,self,HeavyNade,15,"tag1",[script_ref_create(effect_call), GreenExplosion, 5, script_ref_create(resprite), [global.blueExplosion]]);
			break;
		case "Bouncer SMG Golden Epsilon Disco":
		case "Bouncer Shotgun Golden Epsilon Disco":
			with(instances_matching_gt(BouncerBullet, "id", _fireID)){
				if(fork()){
					var c = (current_frame*10) % 255;
					while(instance_exists(self)){
						image_blend = make_color_hsv(c,255,255);
						with(instance_create(x,y,BoltTrail)){
							image_blend = make_color_hsv(c,255,255);
							image_angle = other.image_angle;
							image_xscale = 4;
							image_yscale = 4;
						}
						c+=10*current_time_scale;
						c %= 255;
						wait(1);
					}
					exit;
				}
			}
			proj_addOnHit(x,y,self,BouncerBullet,15,"tag1",[script_ref_create(effect_call),BulletHit, 5, script_ref_create(recolor), [make_color_hsv(random(255),255,255)]]);
			break;
		default:
	}
	
/*#define _scr(_scr, args)
	switch(array_length(args)){
		case 7:
			script_ref_call(_scr, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
			break;
		case 6:
			script_ref_call(_scr, args[0], args[1], args[2], args[3], args[4], args[5]);
			break;
		case 5:
			script_ref_call(_scr, args[0], args[1], args[2], args[3], args[4]);
			break;
		case 4:
			script_ref_call(_scr, args[0], args[1], args[2], args[3]);
			break;
		case 3:
			script_ref_call(_scr, args[0], args[1], args[2]);
			break;
		case 2:
			script_ref_call(_scr, args[0], args[1]);
			break;
		case 1:
			script_ref_call(_scr, args[0]);
			break;
	}
	instance_destroy();*/

#define repSpr(_obj, _spr, _fireID)
	resprite(instances_matching_ge(_obj, "id", _fireID), _spr);

#define repDis(_x,_y,_fireID,_obj,_size,_disspr,_spr)
	with(instance_rectangle(_x-_size,_y-_size,_x+_size,_y+_size,instances_matching_gt(instances_matching_ne(_obj, "replacedDis", true), "id", _fireID))){
		replacedDis = true;
		array_push(global.scriptList, ["disappear", self, _disspr, _spr, noone]);
		global.idNum++;
	}

#define makeBurst(_burst, _scr, _obj, _size, arg1, arg2)
	if(is_array(_burst)){
		with(_burst){
			makeBurst(self, _scr, _obj, _size, arg1, arg2);
		}
		return;
	}
	array_push(global.scriptList, ["burst", _burst, _scr, _obj, _size, arg1, arg2, _burst.x, _burst.y, _burst.creator]);
	global.idNum++;
	
#define makeHit(_proj, _scr, _obj, _size, arg1, arg2)
	array_push(global.scriptList, ["hit", _proj, _scr, _obj, _size, arg1, arg2, _proj.x + _proj.hspeed, _proj.y + _proj.vspeed, _proj.creator]);
	global.idNum++;

#define effect_create(_x, _y, _fireID, _obj, _size, _spr, _unused)
	with(instance_create(_x,_y,_obj)){
		sprite_index = _spr;
	}
	
#define proj_call(_x, _y, _fireID, _obj, _size, _scr, args)
	with(instance_rectangle(_x-_size,_y-_size,_x+_size,_y+_size,instances_matching_gt(_obj, "id", _fireID))){
		switch(array_length(args)){
			case 7:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
				break;
			case 6:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3], args[4], args[5]);
				break;
			case 5:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3], args[4]);
				break;
			case 4:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3]);
				break;
			case 3:
				script_ref_call(_scr, self, args[0], args[1], args[2]);
				break;
			case 2:
				script_ref_call(_scr, self, args[0], args[1]);
				break;
			case 1:
				script_ref_call(_scr, self, args[0]);
				break;
		}
	}

#define effect_call(_x, _y, _fireID, _obj, _size, _scr, args)
	with(instance_rectangle(_x-_size,_y-_size,_x+_size,_y+_size,_obj)){
		switch(array_length(args)){
			case 7:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
				break;
			case 6:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3], args[4], args[5]);
				break;
			case 5:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3], args[4]);
				break;
			case 4:
				script_ref_call(_scr, self, args[0], args[1], args[2], args[3]);
				break;
			case 3:
				script_ref_call(_scr, self, args[0], args[1], args[2]);
				break;
			case 2:
				script_ref_call(_scr, self, args[0], args[1]);
				break;
			case 1:
				script_ref_call(_scr, self, args[0]);
				break;
		}
	}
	
#define proj_addOnHit(_x, _y, _fireID, _obj, _size, _tag, args)
	with(instance_rectangle(_x-_size,_y-_size,_x+_size,_y+_size,instances_matching_gt(instances_matching_ne(_obj, _tag, true), "id", _fireID))){
		switch(_tag){
			case "tag1": tag1 = true; break;
			case "tag2": tag2 = true; break;
			case "tag3": tag3 = true; break;
			case "tag4": tag4 = true; break;
			case "tag5": tag5 = true; break;
			case "tag6": tag6 = true; break;
		}
		makeHit(self, args[0], args[1], args[2], args[3], args[4]);
	}

#define resprite(_obj, _spr)
	with(_obj){
		sprite_index = _spr;
	}

#define recolor(_obj, _col)
	with(_obj){
		image_blend = _col;
	}
	
#define post_step(_part)
for(var i = array_length(global.scriptList) - 1; i >= 0; i--){
	if(global.scriptList[i][0] == noone){
		global.scriptList = array_delete(global.scriptList, i);
	}
}
for(var i = 0; i < array_length(global.scriptList); i++){
	switch(global.scriptList[i][0]){
		case "burst":
			if(instance_exists(global.scriptList[i][1])){
				with(global.scriptList[i][1]){
					global.scriptList[i][@7] = x;
					global.scriptList[i][@8] = y;
					global.scriptList[i][@9] = creator;
					script_ref_call(global.scriptList[i][2], x, y, creator, global.scriptList[i][3], global.scriptList[i][4], global.scriptList[i][5], global.scriptList[i][6]);
				}
			}else{
				script_ref_call(global.scriptList[i][2], global.scriptList[i][7], global.scriptList[i][8], global.scriptList[i][9], global.scriptList[i][3], global.scriptList[i][4] + 20, global.scriptList[i][5], global.scriptList[i][6]);
				if(_part == "end"){
					global.scriptList[i][@0] = noone;
				}
			}
			break;
		case "hit":
			if(instance_exists(global.scriptList[i][1])){
				with(global.scriptList[i][1]){
					global.scriptList[i][@7] = x + hspeed;
					global.scriptList[i][@8] = y + vspeed;
					global.scriptList[i][@9] = creator;
				}
			}else{
				script_ref_call(global.scriptList[i][2], global.scriptList[i][7], global.scriptList[i][8], global.scriptList[i][9], global.scriptList[i][3], global.scriptList[i][4] + 20, global.scriptList[i][5], global.scriptList[i][6]);
				if(_part == "end"){
					global.scriptList[i][@0] = noone;
				}
			}
			break;
		case "disappear":
			if(instance_exists(global.scriptList[i][1])){
				with(global.scriptList[i][1]){
					if("visual" not in self){visual = noone;}
					if(sprite_index == global.scriptList[i][2]){
						image_alpha = 0;
						if(!instance_exists(visual)){
							visual = instance_create(x,y,Wind);
							visual.sprite_index = global.scriptList[i][3];
						}
						visual.x = x;
						visual.y = y;
						visual.speed = speed;
						visual.direction = direction;
						visual.image_angle = image_angle;
						visual.image_blend = image_blend;
						visual.image_speed = image_speed;
					}
					global.scriptList[i][@4] = visual;
				}
			}else{
				if(_part == "end"){
					with(global.scriptList[i][4]){instance_destroy();}
					global.scriptList[i][@0] = noone;
				}
			}
			break;
	}
}
//I don't want to worry about this number getting too big, but there also shouldn't ever be overlap
global.idNum %= 32768;

#define wep_swap(_swap, _slot, _wep)
	if(_swap == true){
		var _slotMax = array_length(_slot),
			_slotWep = [(("bwep" in self) ? bwep : undefined), (("wep" in self) ? wep : undefined)],
			_slotNew = [];
			
		for(var i = 0; i < _slotMax; i++){
			var _primary = _slot[i];
			if(_slotWep[_primary] == _wep){
				if(_primary){
					if(object_index == WepPickup){
						var _lastVisible = visible,
							_lastDepth   = depth,
							_lastSprite  = sprite_index,
							_lastMask    = mask_index,
							_lastSolid   = solid,
							_lastPersist = persistent;
							
						instance_change(Player, false);
						wep = _wep.skinnedwep;
						instance_change(WepPickup, false);
						
						visible      = _lastVisible;
						depth        = _lastDepth;
						sprite_index = _lastSprite;
						mask_index   = _lastMask;
						solid        = _lastSolid;
						persistent   = _lastPersist;
					}
					else wep = _wep.skinnedwep;
				}
				else{
					bwep = _wep.skinnedwep;
				}
				array_push(_slotNew, _primary);
			}
		}
		
		if(array_length(_slotNew)){
			return [_slotWep, _slotNew];
		}
	}
	else for(var i = array_length(_slot) - 1; i >= 0; i--){
		var _primary = _slot[i],
			_swapped = false;
			
		if(
			_primary
			? ("wep"  in self && (is_object(wep)  ? wep_base(wep)  : wep)  == _wep.skinnedwep)
			: ("bwep" in self && (is_object(bwep) ? wep_base(bwep) : bwep) == _wep.skinnedwep)
		){
			_swapped = true;
		}
		else if(
			_primary
			? ("bwep" in self && (is_object(bwep) ? wep_base(bwep) : bwep) == _wep.skinnedwep && bwep != _swap[0])
			: ("wep"  in self && (is_object(wep)  ? wep_base(wep)  : wep)  == _wep.skinnedwep && wep  != _swap[1])
		){
			_swapped = true;
			_primary = !_primary;
		}
		
		if(_swapped){
			if(_primary){
				if(object_index == WepPickup){
					var _lastVisible = visible,
						_lastDepth   = depth,
						_lastSprite  = sprite_index,
						_lastMask    = mask_index,
						_lastSolid   = solid,
						_lastPersist = persistent;
						
					instance_change(Player, false);
					wep = _wep;
					instance_change(WepPickup, false);
					
					visible      = _lastVisible;
					depth        = _lastDepth;
					sprite_index = _lastSprite;
					mask_index   = _lastMask;
					solid        = _lastSolid;
					persistent   = _lastPersist;
				}
				else wep = _wep;
			}
			else{
				bwep = _wep;
			}
		}
	}
	return false;

#define wep_base(_wep)
	while(is_object(_wep)){
		_wep = (("wep" in _wep) ? _wep.wep : wep_none);
	}
	return _wep;

#define isFiring(_wep)
return ("reload" in self && reload > 0 || "wkick" in self && wkick > 0) && "wep" in self && wep == _wep || ("breload" in self && breload > 0 || "bwkick" in self && bwkick > 0) && "bwep" in self && bwep == _wep;

//sound code donated by matt/smashbrothers/attfooy
#define stopSound_setup()
	return sound_play_pitchvol(0, 0, 0);
	
#define stopSound(_sndID)
	while(audio_is_playing(_sndID)){
		sound_stop(_sndID);
		_sndID++;
	}

#define instance_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their coordinates touching a given rectangle
		Much better performance than manually performing 'point_in_rectangle()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "x", _x1), "x", _x2), "y", _y1), "y", _y2);

#define array_delete(_array, _index)
	/*
		Returns a new array with the value at the given index removed
		
		Ex:
			array_delete([1, 2, 3], 1) == [1, 3]
	*/
	
	var _new = array_slice(_array, 0, _index);
	
	array_copy(_new, array_length(_new), _array, _index + 1, array_length(_array) - (_index + 1));
	
	return _new;