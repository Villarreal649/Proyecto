#define init
global.idle = sprite_add("Sprites/big wolf idle.png", 8, 40, 50);
global.roll = sprite_add("Sprites/big wolf roll.png", 3, 20, 40);
global.rollShine = sprite_add("Sprites/big wolf roll shine.png", 1, 20, 40);
global.hurt = sprite_add("Sprites/big wolf hurt.png", 3, 40, 50);
global.dead = sprite_add("Sprites/big wolf dead.png", 6, 40, 50);
global.sleep = sprite_add("Sprites/big wolf sleep.png", 6, 40, 50);
global.wake = sprite_add("Sprites/big wolf wake.png", 12, 40, 50);
global.gun = sprite_add("Sprites/big wolf gun.png", 1, 8, 3);
global.shoot = sprite_add("Sprites/big wolf shoot.png", 9, 40, 50);
global.launch = sprite_add("Sprites/big wolf launch.png", 8, 40, 50);
global.missile = sprite_add("Sprites/big wolf missile.png", 1, 3, 4);
global.mskRoll = sprite_add("Sprites/big wolf roll mask.png", 1, 24, 44);
global.mskRoll2 = sprite_add("Sprites/big wolf roll mask 2.png", 1, 16, 32);
global.bind_step = noone;
global.spawned = 0;
global.song = sound_add("NTBigWolfRemix.ogg");
    
global.override = 0; //set to 1 to get the vanilla boss, set to 2 to get the bosses+ boss

#define boss_chance
//1/2 chance, with fixed RNG
var _lastSeed = random_get_seed();
random_set_seed(GameCont.baseseed + GameCont.hard);
random_set_seed(ceil(random(100000) * random(100000)));
var rand = irandom(1);
random_set_seed(_lastSeed);
return rand;
	
#define cleanup
     // Unbind Script on Mod Unload:
    with(global.bind_step){
        instance_destroy();
    }
    
#define step
     // Bind 'post_step' Script to a Step Event:
    if(!instance_exists(global.bind_step)){
        global.bind_step = script_bind_step(post_step, 0);
    }
    
#define post_step
if(!instance_exists(GenCont) && GameCont.area == 5 && GameCont.subarea == 3 && instance_exists(Floor)){
	if(global.spawned == 1){
		with(LilHunter){
			instance_delete(self);
		}
	}
	if(global.spawned == 0 && ((boss_chance() < 1 && global.override != 1) || global.override == 2)){
		global.spawned = 1;
		var floorTiles = instances_matching(Floor, "visible", true);
		var pos = floorTiles[irandom(array_length(floorTiles) - 1)];
		var attempts = 0;
		while(attempts < 1000){
			var success = true;
			with(Player){
				if(point_distance(x,y,pos.x,pos.y) < 250 - (attempts / 10) || point_distance(x,y,pos.x,pos.y) > 350 + (attempts / 10)){
					success = false;
				}
			}
			if(success){break;}
			pos = floorTiles[irandom(array_length(floorTiles) - 1)];
			attempts++;
		}
		instance_create(pos.x,pos.y, PortalClear);
		with(instance_create(pos.x,pos.y, CustomEnemy)){ //change spawn method
			name = "BigWolf";
			boss = true;
			
			 // For Sani's bosshudredux:
			bossname = "BIG WOLF";
			col = c_red;
			
			team = 1;
			intro = 0;
			my_health = boss_hp(400);
			maxhealth = boss_hp(400);
			spr_idle = global.sleep;
			spr_walk = global.roll;
			spr_hurt = global.hurt;
			spr_dead = global.dead;
			spr_gun = global.gun;
			spr_shadow = shd64;
			meleedamage = 3;
			sprite_index = global.sleep;
			mask_index = global.idle;
			image_speed = 0.4;
			size = 4;
			wkick = 0;
			gunangle = random(360);
			maxspeed = 1;
			walk = 0;
			friction = 1;
			depth = -2;
			alrm0 = 0;
			alrm1 = 0;
			alrm2 = 0;
			alrm3 = 0;
			alrm4 = 0;
			alrm5 = 0;
			alrm6 = 0;
			ammo = 0;
			fireCount = 0;
			hurtCount = 10;
			prevDir = direction;
			hitid = [global.idle, "Big Wolf"];
			on_step = BigWolf_step;
			on_draw = BigWolf_draw;
			on_hurt = BigWolf_hurt;
			on_destroy = BigWolf_destroy;
			raddrop = 50;
		}
	}
}else{
	global.spawned = 0;
}
	
#define scr_target
	// Edit this as you see fit to match the complexity of your enemy
	if instance_exists(Player){
		var n = instance_nearest(x,y,Player);
		if !collision_line(x,y,n.x,n.y,Wall,0,1){
			target = n;
		}else target = -4;
	}
#define BigWolf_step
	if((image_index + image_speed_raw >= image_number || image_index + image_speed_raw < 0) && sprite_index == spr_hurt){
		sprite_index = spr_idle;
	}
	if(!intro){
		if(sprite_index == spr_hurt){hurtCount--;}
		list = instances_matching_gt(Player, "my_health", 0);
		for(var i = array_length(list) - 1; i >= 0; i--){
			if (distance_to_object(list[i]) < 80 || hurtCount < 1){
				sound_play_pitchvol(sndGoldTankDead,0.5,2.6);
				if(fork()){
					intro = true;
					var prevImageIndex = -1;
					image_index = 0;
					while(image_index > prevImageIndex){
						spr_idle = global.wake;
						spr_hurt = global.wake;
						prevImageIndex = image_index;
						wait(0);
					}
					if(!instance_exists(self)){exit;}
					spr_idle = global.idle;
					spr_hurt = global.hurt;
					boss_intro();
					if(!instance_exists(self)){exit;}
					alrm0 = 10;
					leadsleep = 0;
					exit;
				}
				break;
			}
		}
	}
	if(alrm0 > 0 && walk <= 0){
		alrm0 -= current_time_scale;
		target = instance_nearest(x,y,Player);
		if(instance_exists(target) && alrm2 <= 0 && alrm3 <= 0 && alrm4 <= 0){
			gunangle = point_direction(x,y,target.x,target.y);
		}
		if alrm0 <= 0{
			if instance_exists(target) && distance_to_object(Player) < 300{
				if random(3) < 1 && distance_to_object(target) > 48 && distance_to_object(target) < 128 {
					direction = gunangle + 45;
					prevDir = direction;
					alrm1 = 15 - min(GameCont.loops, 10);
					sound_play_pitchvol(sndWolfRoll, 1.1, 1.5);
					walk = 20 - min(GameCont.loops, 10);
					alrm2 = 20 - min(GameCont.loops, 10);
					alrm0 = 40 - min(GameCont.loops, 10);
				}else if random(3) < 1 && !collision_line(x,y,target.x,target.y,Wall,0,1){
					ammo = 6 + GameCont.loops*4;
					alrm4 = 30 + GameCont.loops * 2;
					alrm0 = 30 + GameCont.loops * 2;
				}else if random(3) < 2 && distance_to_object(target) > 50 && distance_to_object(Wall) > 20{
					alrm5 = 10;
					alrm0 = 30 - min(GameCont.loops, 10);
				}else{
					direction = point_direction(x,y,target.x,target.y) + (random_range(-10,10));
					prevDir = direction;
					walk = 20 + random(10) - min(GameCont.loops, 10);
					alrm1 = 15 - min(GameCont.loops, 10);
					sound_play_pitchvol(sndWolfRoll, 0.8, 1.5);
					if(distance_to_object(Player) > 200 && random(3) < 1){
						walk *= 1.5;
					}
					alrm0 = walk+5;
				}
			}else if(instance_exists(target)){
				// No close target, just idle
				gunangle = random(360);
				direction = gunangle;
				prevDir = direction;
				walk = 25 + random(10) - min(GameCont.loops, 5);
				alrm1 = 20 - min(GameCont.loops, 5);
				sound_play_pitch(sndWolfRoll, 1);
				alrm0 = walk + 10;
			}else{
				alrm0 = 1;
				//no one to fight, sleepytime
				if(sprite_index != global.wake && sprite_index != global.sleep){
					sprite_index = global.wake;
					spr_idle = global.wake;
					image_index = image_number - 0.4;
					image_speed = -0.4;
				}
				if(sprite_index == global.wake && image_index + image_speed <= 0){
					sprite_index = global.sleep;
					spr_idle = global.sleep;
					image_speed = 0.4;
					intro = 0;
					alrm0 = 0;
				}
				
			}
		}
	}
	if(alrm2 > 0){
		alrm2 -= current_time_scale;
		if alrm2 <= 0{
			direction = gunangle - 45;
			prevDir = direction;
			walk = 10;
			alrm3 = 10;
			sound_set_track_position(sound_play_pitchvol(sndWolfRoll, 1.2, 1.5), 0.2);
		}
	}
	
	if(alrm3 > 0){
		alrm3 -= current_time_scale;
		if alrm3 <= 0{
			direction = gunangle + 45;
			prevDir = direction;
			walk = 5;
			sound_set_track_position(sound_play_pitchvol(sndWolfRoll, 1.4, 1.5), 0.2);
		}
	}
	
	// If walk > 0, walk. Assigns sprites accordingly.
	if(alrm4 <= 0 && alrm5 <= 0){
		if(walk > 0){
			//doing + 5 to hopefully mitigate slowing effects
			maxspeed = (8 + min(GameCont.loops, 12)) * ((alrm2>0||alrm3>0)*0.25 + 1) + 5;
			walk -= current_time_scale;
			direction = prevDir;
			sprite_index = global.roll;
			if(alrm1 > 0){
				alrm1 -= current_time_scale;
				if(alrm1 < 6){
					sprite_index = global.rollShine;
				}
				repeat(4/current_time_scale){
					with(instance_create(x + random(5),y + random(15),Smoke)){
						speed = 5 + random(10);
						direction = other.direction + 170 + random(30);
					}
				}
			}else{
				//slow effect mitigaion
				speed = maxspeed - 5;
			}
			canmelee = true;
			with(instance_create(x + hspeed*1.2,y + vspeed*1.2,PortalClear)){
				team = other.team;
				mask_index = global.mskRoll;
			}
			mask_index = global.mskRoll2;
		}else{
			mask_index = global.idle
			maxspeed = 2;
			canmelee = false;
			if speed < 1 && sprite_index != spr_hurt{
				sprite_index = spr_idle;
			}
			// Flips the sprite
			right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
		}
	}
	
	if(alrm4 > 0){
		alrm4 -= current_time_scale;
		if(alrm4 > 0){
			sprite_index = global.shoot;
			fireCount += (ammo/alrm4)*current_time_scale;
		}
		if(floor(fireCount) >= 1){
			repeat(floor(fireCount)){
				sound_play_pitchvol(sndEnemyFire, 1.6, 2);
				with(instance_create(x,y-10,EnemyBullet1)){
					direction = other.gunangle + 30 - other.alrm4*2;
					image_angle = direction;
					speed = 8;
					team = other.team;
					creator = other;
					hitid = [global.idle, "Big Wolf"];
				}
				with(instance_create(x,y-10,EnemyBullet1)){
					direction = other.gunangle - 30 + other.alrm4*2;
					image_angle = direction;
					speed = 8;
					team = other.team;
					creator = other;
					hitid = [global.idle, "Big Wolf"];
				}
			}
			ammo -= floor(fireCount);
			fireCount -= floor(fireCount);
		}
		if alrm4 <= 0{
			ammo = 0;
		}
	}
	
	if(alrm5 > 0){
		alrm5 -= current_time_scale;
		if(alrm5 > 0){
			sprite_index = global.launch;
			if(image_index < image_number - 1){
				image_speed = 0.4;
			}else{
				image_speed = 0;
			}
		}else{
			sound_play_pitchvol(sndJockFire, 0.8, 1.5);
			with(instance_create(x,y,Rocket)){
				direction = other.gunangle;
				image_angle = direction;
				speed = 4;
				team = other.team;
				creator = other;
				sprite_index = global.missile;
				hitid = [global.idle, "Big Wolf"];
				if(fork()){
					var _x = x;
					var _y = y;
					while(instance_exists(self)){
						_x = x;
						_y = y;
						wait(1);
					}
					with(instance_create(_x,_y,Dust)){
						pickup_drop(50, 0);
						instance_destroy();
					}
					exit;
				}
			}
			alrm6 = 15;
		}
	}
	
	if(alrm6 > 0){
		alrm6 -= current_time_scale;
		if(alrm6 > 0){
			sprite_index = global.launch;
			if(image_index > 1){
				image_speed = -0.4;
			}else{
				image_speed = 0;
			}
		}else{
			image_speed = 0.4;
		}
	}
	
	// Limits speed
	speed = clamp(-maxspeed,speed,maxspeed);
	// lets me stop bouncing while rolling
	prevDir = direction;
	
#define BigWolf_draw
	var gunang = gunangle;
	if(right == 1 && gunang > 45 && gunang < 180){gunang = 45;}
	if(right == 1 && gunang < -45){gunang = -45;}
	if(right == 1 && gunang < 315 && gunang > 180){gunang = 315;}
	if(right == -1 && gunang > 225){gunang = 225;}
	if(right == -1 && gunang < 135){gunang = 135;}
	var spread = (alrm4 > 0 ? 30 - alrm4*2 : 0);
	// Draw back gun
	if(walk <= 0){draw_sprite_ext(spr_gun,0,x - right*5 + lengthdir_x(-wkick,gunang + spread), y - 8 + lengthdir_y(-wkick, gunang + spread), 1, right, gunang + spread, image_blend, image_alpha);}
	// Draw self
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	// Draw front gun
	if(walk <= 0){draw_sprite_ext(spr_gun,0,x - right*10 + lengthdir_x(-wkick,gunang - spread), y - 10 + lengthdir_y(-wkick, gunang - spread), 1, right, gunang - spread, image_blend, image_alpha);}
	
#define BigWolf_hurt(_damage, _force, _direction)
	my_health -= _damage;
	nexthurt = current_frame + 6;
	motion_add(_direction, _force);
	sound_play_hit(sndWolfHurt, 0.3);
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;

#define BigWolf_destroy
	pickup_drop(350, 15);
	pickup_drop(50, 0);
	pickup_drop(30, 0);
	speed = 0;
	var _x = x;
	var _y = y;
	var _t = team;
	var _c = self;
	var _d = direction;
	 // Boss Win Music:
	with(MusCont) alarm_set(1, 1);

//thanks TE
#define boss_intro
intro = true;
wait(5);
with(MusCont){
	alarm_set(2, 1);
	alarm_set(3, -1);
}
with(script_bind_begin_step(boss_intro_step, 0)){
	boss    = "BigWolf";
	loops   = 0;
	intro   = true;
	sprites = [
		[`Sprites/${boss}Main.png`, sprBossIntro,          0],
		[`Sprites/${boss}Back.png`, sprBossIntroBackLayer, 0],
		[`Sprites/${boss}Name.png`, sprBossName,           0]
	];
	
	 // Preload Sprites:
	with(sprites){
		if(!file_loaded(self[0])){
			file_load(self[0]);
		}
	}
}
sound_play(sndBigDogIntro);

//thanks again, TE
#define boss_intro_step
	if(intro){
		intro = false;
		
		 // Preload Sprites:
		with(sprites){
			if(!file_loaded(self[0])){
				other.intro = true;
				break;
			}
		}
		
		 // Boss Intro Time:
		if(!intro && UberCont.opt_bossintros == true && GameCont.loops <= loops){
			 // Replace Big Bandit's Intro:
			with(sprites){
				if(file_exists(self[0])){
					sprite_replace_image(self[1], self[0], self[2]);
				}
			}
			
			 // Call Big Bandit's Intro:
			var	_lastSub   = GameCont.subarea,
				_lastLoop  = GameCont.loops,
				_lastIntro = UberCont.opt_bossintros;
				
			GameCont.loops          = 0;
			UberCont.opt_bossintros = true;
			
			with(instance_create(0, 0, BanditBoss)){
				with(self){
					event_perform(ev_alarm, 6);
				}
				sound_stop(sndBigBanditIntro);
				instance_delete(id);
			}
			
			with(MusCont){
				alarm_set(3, -1);
			}
			
			GameCont.subarea        = _lastSub;
			GameCont.loops          = _lastLoop;
			UberCont.opt_bossintros = _lastIntro;
		}
		sound_play_music(global.song);
	}
	
	 // End:
	else{
		with(sprites){
			sprite_restore(self[1]);
		}
		instance_destroy();
	}

// TE to the rescue again
#define boss_hp(_hp)
	var _players = 0;
	for(var i = 0; i < maxp; i++){
		_players += player_is_active(i);
	}
	return round(_hp * (1 + (1/3 * GameCont.loops)) * (1 + (0.5 * (_players - 1))));