#define init
global.head = sprite_add("Head.png", 1, 18, 14);
global.headBack = sprite_add("HeadBack.png", 3, 18, 14);
global.headHurt = sprite_add("HeadHurt.png", 1, 18, 14);
//I have to load the rad body part to have an easy check for extra rad drops
global.radBody = sprite_add("Body Variations/rad.png", 3, 19, 14);
global.body = [
	{spr:sprite_add("Body Variations/base.png", 3, 19, 15),chance:150},
	{spr:sprite_add("Body Variations/fly.png", 3, 19, 14),chance:3},
	{spr:sprite_add("Body Variations/metal.png", 3, 19, 13),chance:2},
	{spr:sprite_add("Body Variations/blanket.png", 3, 19, 15),chance:6},
	{spr:sprite_add("Body Variations/meat.png", 3, 19, 16),chance:4},
	{spr:global.radBody,chance:1}
];
global.partList = [];
for(var i = 0; i < array_length(global.body); i++){
	repeat(global.body[i].chance){
		array_push(global.partList, global.body[i].spr);
	}
}
global.bodyHurt = sprite_add("BodyHurt.png", 1, 18, 13);
global.tail = sprite_add("Tail.png", 4, 14, 14);
global.tailRad = sprite_add("RadTail.png", 4, 14, 14);
global.tailHurt = sprite_add("TailHurt.png", 1, 14, 14);
global.dead = sprite_add("Dead.png", 1, 16, 15);
global.ball = sprite_add("AcidBall.png", 1, 11, 11);
global.song = sound_add("NuclearThrone_BigBandit_DuneRemix.ogg");

global.bbandit = sprite_add("blanket bandit idle.png", 4, 13, 14);
global.bbandithide = sprite_add("blanket bandit hide.png", 5, 13, 14);
global.bbanditwep = sprite_add("blanket bandit weapon.png", 1, 7, 3);
global.bbandithurt = sprite_add("blanket bandit hurt.png", 2, 13, 14);
global.bbanditdead = sprite_add("blanket bandit dead.png", 1, 13, 14);

global.crack = sprite_add("Crack.png", 5, 32, 32);

global.shadows = [];
    
global.override = 0; //set to 1 to get the vanilla boss, set to 2 to get the bosses+ boss

#define boss_chance
//1/2 chance, with fixed RNG
var _lastSeed = random_get_seed();
random_set_seed(GameCont.baseseed + GameCont.hard);
random_set_seed(ceil(random(100000) * random(100000)));
var rand = irandom(1);
random_set_seed(_lastSeed);
return rand;

#define step
if(!instance_exists(GenCont) && GameCont.area == 1 && GameCont.subarea == 3 && instance_exists(Wall)){
	with(instances_matching_ne(WantBoss, "Giga", 1)){
		Giga = 1;
		if((boss_chance() < 1 && global.override != 1) || global.override == 2){
			var floorTiles = instances_matching(Wall, "visible", true);
			var pos = floorTiles[irandom(array_length(floorTiles) - 1)];
			var attempts = 0;
			while(attempts < 1000){
				var success = true;
				with(Player){
					if(point_distance(x,y,pos.x,pos.y) < 300 - (attempts / 10)){
						success = false;
					}
				}
				if(success){break;}
				pos = floorTiles[irandom(array_length(floorTiles) - 1)];
				attempts++;
			}
			pos = instance_nearest(pos.x,pos.y, Floor);
			with(instance_create(pos.x,pos.y, CustomEnemy)){
				name = "GigaMaggot";
				boss = true;
				
				 // For Sani's bosshudredux:
				bossname = "GIGA MAGGOT";
				col = c_yellow;
				
				team = 1;
				intro = 0;
				my_health = boss_hp(200 * ((GameCont.loops/2) + 1));
				maxhealth = boss_hp(200 * ((GameCont.loops/2) + 1));
				sprite_index = global.head;
				spr_idle = global.head;
				spr_hurt = global.headHurt;
				spr_dead = global.dead;
				hitid = [global.head, "Giga Maggot"];
				depth = -8;
				on_step = MBStep;
				on_draw = MBDraw;
				on_destroy = MBStep;
				on_hurt = MBHurt;
				raddrop = 5;
				z = -20;
				zspeed = -20;
				jumpStart = [x,y];
				jumpEnd = [x,y];
				jumpTime = 15;
				jumpTimer = 0;
				crack = 0;
				snap = 0;
				grav = 1/4;
				size = 4;
				canfly = 1;
				canmelee = true;
				meleedamage = 3;
				friction = 1;
				chunks = [];
				var bandits = [];
				if(GameCont.loops > 0){
					repeat(GameCont.loops*2){
						var r = 0;
						while(r == 0){
							r = irandom(8 * ((GameCont.loops/2) + 1) - 2) + 1;
							for(var i = 0; i < array_length(bandits); i++){
								if(bandits[i] == r){
									r = 0;
									break;
								}
							}
						}
						array_push(bandits, r);
					}
				}
				repeat(8 * ((GameCont.loops/2) + 1)){
					with(instance_create(x,y,CustomEnemy)){
						name = "GigaMaggotPart";
						team = 1;
						my_health = other.maxhealth;
						maxhealth = other.maxhealth;
						candie = false;
						depth = -7;
						z = other.z;
						grav = 1/4;
						prevx = x;
						prev2x = x;
						prevy = y;
						prev2y = y;
						prevz = z;
						prev2z = z;
						var bodyPart = global.partList[irandom(array_length(global.partList) - 1)];
						sprite_index = bodyPart;
						spr_idle = bodyPart;
						spr_hurt = global.bodyHurt;
						spr_dead = global.dead;
						hitid = [global.head, "Giga Maggot"];
						on_draw = chunkDraw;
						on_hurt = MBHurt;
						raddrop = 5 + 5 * (bodyPart == global.radBody);
						size = 4;
						canmelee = true;
						canfly = 1;
						meleedamage = 1;
						friction = 1;
						bandit = noone;
						for(var i = 0; i < array_length(bandits); i++){
							if(bandits[i] == array_length(other.chunks)){
								bandit = instance_create(x,y,CustomObject);
								bandit.sprite_index = global.bbandit;
								bandit.image_speed = 0.4;
								bandit.on_draw = banditDraw;
								bandit.wkick = 0;
								bandit.spr_gun = global.bbanditwep;
								bandit.gunangle = other.direction;
								bandit.right = other.right;
								bandit.target = noone;
								bandit.depth = depth - 1;
								break;
							}
						}
						array_push(other.chunks, self);
					}
				}
				with(instance_create(x,y,CustomEnemy)){
					name = "GigaMaggotTail";
					team = 1;
					my_health = other.maxhealth;
					maxhealth = other.maxhealth;
					candie = false;
					depth = -7;
					z = other.z;
					grav = 1/4;
					prevx = x;
					prev2x = x;
					prevy = y;
					prev2y = y;
					prevz = z;
					prev2z = z;
					raddrop = 5;
					var tail = global.tail;
					if(random(20) < 1){
						tail = global.tailRad;
						raddrop += 5;
					}
					sprite_index = tail;
					spr_idle = tail;
					spr_hurt = global.tailHurt;
					spr_dead = global.dead;
					hitid = [global.head, "Giga Maggot"];
					on_draw = chunkDraw;
					on_hurt = MBHurt;
					size = 4;
					canmelee = true;
					canfly = 1;
					meleedamage = 4;
					friction = 1;
					bandit = noone;
					array_push(other.chunks, self);
				}
			}
			with(WantBoss){
				instance_destroy();
			}
			break;
		}
	}
}

#define MBStep
if(z >= 0 && jumpTimer <= 0){
	if(!intro && distance_to_object(Player) < 120 && fork()){
		boss_intro();
		exit;
	}
	repeat(30){with(instance_create(x,y,Dust)){speed = random(5);direction = random(360);}}
	instance_create(x,y,PortalClear);
	sound_play(sndWallBreakRock);
	zspeed = 2 + 2 * my_health / maxhealth;
	jumpStart = [x,y];
	direction = point_direction(x,y,target.x, target.y) + random(60) - 30;
	var length = 60 + random(35);
	var near = instance_nearest(jumpStart[0] + lengthdir_x(length, direction), jumpStart[1] + lengthdir_y(length, direction), Floor);
	jumpEnd = [near.x, near.y];
	jumpTime = (zspeed / grav) * 2;
	jumpTimer = 1;
	if(irandom(3) == 1){
		zspeed += 2;
		jumpEnd = jumpStart;
		snap = 1;
		if(fork())
		{
			with(instance_create(x, y-8-z, Exploder))
			{
				//name = "3dbullet";
				
				var bulletip = instance_nearest(x, y, Player);
				var bullepdir = random(360);
				var bulletdist = random(360);
				var rdir = random(360);
				var rdist = random(32);
				
				if(bulletip != noone)
				{
					var rdist = random(bulletip.speed*10);
					var bulletdir = point_direction(x, y, bulletip.x+lengthdir_x(rdist, rdir), bulletip.y+lengthdir_y(rdist, rdir));
					var bulletdist = point_distance(x, y, bulletip.x+lengthdir_x(rdist, rdir), bulletip.y+lengthdir_y(rdist, rdir))/30;
				}
				
				depth = -9;
				team = other.team;
				speed = bulletdist;
				direction = bulletdir;
				friction = 0;
				image_angle = direction;
				z = other.z-4;
				oz = z;
				zspeed = -6;
				sprite_index = global.ball;
				spr_idle = global.ball;
				spr_walk = global.ball;
				hitid = [global.head, "Giga Maggot"];
				canfly = true;
				var msk = global.ball;
				mask_index = mskNone;
				spr_shadow = mskNone;
				spr_dead = mskNone;
				bloom = instance_create(x,y+z,CustomObject);
				bloom.sprite_index = sprite_index;
				bloom.image_xscale = image_xscale*2;
				bloom.image_yscale = image_yscale*2;
				bloom.image_alpha = image_alpha*0.1;
				bloom.depth = -6;
				shadow = instance_create(x,y+z,CustomObject);
				shadow.sprite_index = shd24;
				shadow.image_alpha = 0.4;
				shadow.depth = 5;
				
				while(instance_exists(self))
				{
					speed = bulletdist;
					zspeed += 8/30;
					z += zspeed;
					y += zspeed;
					shadow.x = x + hspeed_raw;
					shadow.y = y-z + vspeed_raw;
					bloom.x = x + hspeed_raw;
					bloom.y = y + vspeed_raw;
					sprite_index = global.ball;
					bloom.sprite_index = sprite_index;
					bloom.image_xscale = image_xscale*2;
					bloom.image_yscale = image_yscale*2;
					bloom.image_alpha = image_alpha*0.1;
					image_angle = point_direction(x, y, x+hspeed, y+vspeed+zspeed);
					bloom.image_angle = image_angle;
					mask_index = mskNone;
					
					if(zspeed >= 0
					&& z >= -4)
					{
						mask_index = msk;
						if(distance_to_object(Wall) <= 0)
						{
							with(instance_create(x, y, SmallExplosion))
							{
								team = other.team;
								sprite_index = sprAcidStreak;
							}
						}
						with(shadow){instance_destroy();}
						with(bloom){instance_destroy();}
						instance_destroy();
					}
					if(instance_exists(self)
					&& z > oz)
					{
						pickup_drop(100, 0);
						with(shadow){instance_destroy();}
						with(bloom){instance_destroy();}
						instance_destroy();
					}
					
					wait(1);
				}
			}
			exit;
		}
	}
}
if(z >= 0){
	x = lerp(jumpStart[0], jumpEnd[0], jumpTimer/jumpTime);
	y = lerp(jumpStart[1], jumpEnd[1], jumpTimer/jumpTime);
	if(jumpStart[1] > jumpEnd[1]){
		spr_idle = global.headBack;
	}else{
		spr_idle = global.head;
	}
	jumpTimer += current_time_scale;
	zspeed -= current_time_scale * grav;
}else{
	if(jumpTimer > 0){
		if(!intro && distance_to_object(Player) < 120 && fork()){
			boss_intro();
			exit;
		}
		repeat(30){with(instance_create(x,y,Dust)){speed = random(5);direction = random(360);}}
		instance_create(x,y,PortalClear);
		sound_play(sndWallBreak);
		jumpStart = [x,y];
		direction = -1;
		var tries = 0;
		while(direction == -1){
			direction = random(360);
			var length = 30 + random(25);
			var near = instance_nearest(jumpStart[0] + lengthdir_x(length, direction), jumpStart[1] + lengthdir_y(length, direction), Floor);
			jumpEnd = [near.x, near.y];
			with(Player){
				if(distance_to_point(near.x,near.y) < 16){
					if(tries < 20){direction = -1;}
				}
			}
			tries++;
		}
		jumpTime = (zspeed / grav) * 2;
		jumpTimer = -1;
		if(snap == 1){
			snap = 2;
		}else{
			snap = 0;
		}
	}
	x = lerp(jumpStart[0], jumpEnd[0], jumpTimer/jumpTime);
	y = lerp(jumpStart[1], jumpEnd[1], jumpTimer/jumpTime);
	jumpTimer--;
	zspeed += current_time_scale * grav;
}
if(zspeed > 1){image_index = 0;}else if(zspeed < 1){image_index = 2;}else{image_index = 1;}
image_speed = 0;
z += zspeed;
if(z >= 0 && z < 10){mask_index = spr_idle;}else{mask_index = mskNone;}
if(z < 0){
	if(irandom(2) == 0){
		instance_create(x,y,Dust);
	}
	visible = false;
}else{
	visible = true;
}
var damage = 0;
if(array_length(chunks)){
	for(var i = array_length(chunks) - 1; i > 0; i--;){
		if(instance_exists(chunks[i]) && instance_exists(chunks[i-1])){
			var _c = chunks[i];
			if(i == array_length(chunks) - 1){
				if(chunks[i-1].z > _c.z + 2){_c.image_index = 0;}else if(chunks[i-1].z < _c.z - 2){_c.image_index = 2;}else{_c.image_index = 1;}
				_c.image_speed = 0;
			}
			_c.x = _c.prevx;
			_c.y = _c.prevy;
			_c.z = _c.prevz;
			_c.prevx = _c.prev2x;
			_c.prevy = _c.prev2y;
			_c.prevz = _c.prev2z;
			_c.prev2x = chunks[i-1].x;
			_c.prev2y = chunks[i-1].y;
			_c.prev2z = chunks[i-1].z;
			if(instance_exists(_c.bandit)){
				with(_c.bandit){
					x = _c.x;
					y = _c.y - _c.z - 18;
					right = _c.x > _c.prevx ? -1 : 1;
					if(wkick > 0){wkick -= current_time_scale;}
					if((_c.z >= 0 || (i != array_length(other.chunks) - 1 && instance_exists(other.chunks[i+1]) && other.chunks[i+1].z >= 0)) && other.snap != 1){
						visible = true;
						if(_c.z < ((_c.z - _c.prevz + other.grav) * 16)){
							if(sprite_index != global.bbandithide){
								image_index = 0;
								target = instance_nearest(x,y,Player);
								if(instance_exists(target)){
									gunangle = point_direction(x,y-10,target.x,target.y);
									if(fork()){
										repeat(3){
											if(!instance_exists(self) || !instance_exists(_c)){
												exit;
											}
											sound_play(sndEnemyFire);
											wkick = 6;
											with(instance_create(x,y,EnemyBullet1)){
												team = _c.team;
												creator = _c;
												speed = 4;
												direction = other.gunangle;
												image_angle = direction;
												hitid = [global.bbandit, "Blanket Bandit"];
											}
											with(instance_create(x,y,EnemyBullet1)){
												team = _c.team;
												creator = _c;
												speed = 4;
												direction = other.gunangle - 25;
												image_angle = direction;
												hitid = [global.bbandit, "Blanket Bandit"];
											}
											with(instance_create(x,y,EnemyBullet1)){
												team = _c.team;
												creator = _c;
												speed = 4;
												direction = other.gunangle + 25;
												image_angle = direction;
												hitid = [global.bbandit, "Blanket Bandit"];
											}
											wait(3);
										}
										exit;
									}
								}
							}
							sprite_index = global.bbandithide;
							if(image_index > image_number - 1){
								image_index = image_number - 1;
							}
						}else if(sprite_index == global.bbandithide && image_index < 2){
							sprite_index = global.bbandit;
							image_speed = 0.4;
						}
					}else{
						visible = false;
						image_speed = -0.4;
						image_index = image_number - 1;
					}
				}
			}
			if(snap == 1 && _c.x == x && _c.y == y){
				_c.z = z - 10 * (i+1);
				_c.prevx = x;
				_c.prevy = y;
			}else if(snap == 2 && _c.z >= 0 && _c.prev2z < 0){
				_c.z = _c.prev2z;
			}
			_c.xprevious = _c.x;
			_c.yprevious = _c.y;
			if("my_health" in _c){
				if(_c.z >= -1 && _c.z <= 1){
					repeat(5) with(instance_create(_c.x,_c.y,Dust)){speed = random(5);direction = random(360);depth = other.depth+1;}
				}
				if(_c.my_health < _c.maxhealth && fork()){
					instance_create(_c.x,_c.y-_c.z,AcidStreak);
					instance_create(_c.x,_c.y-_c.z,AcidStreak);
					instance_create(_c.x,_c.y-_c.z,AcidStreak);
					instance_create(_c.x,_c.y-_c.z,AcidStreak);
					_c.sprite_index = _c.spr_hurt;
					chunks[i-1].sprite_index = chunks[i-1].spr_hurt;
					wait(8);
					if(instance_exists(_c) && "spr_idle" in _c){_c.sprite_index = _c.spr_idle;}
					if(instance_exists(self) && "chunks" in self && instance_exists(chunks[i-1]) && "spr_idle" in chunks[i-1]){chunks[i-1].sprite_index = chunks[i-1].spr_idle;}
					exit;
				}
				if(_c.maxhealth - _c.my_health > damage){
					damage = _c.maxhealth - _c.my_health;
				}
				_c.my_health = _c.maxhealth;
				if(_c.z >= 0 && _c.z < 10){_c.mask_index = _c.spr_idle;}else{_c.mask_index = mskNone;}
				if(_c.z < 0){
					_c.visible = false;
				}else{
					_c.visible = true;
					array_push(global.shadows, [_c.x, _c.y, _c.z]);
				}
			}
		}
	}
	if(instance_exists(chunks[0])){
		var _c = chunks[0];
		_c.x = _c.prevx;
		_c.y = _c.prevy;
		_c.z = _c.prevz;
		_c.prevx = _c.prev2x;
		_c.prevy = _c.prev2y;
		_c.prevz = _c.prev2z;
		_c.prev2x = x;
		_c.prev2y = y;
		_c.prev2z = z;
		if(snap == 1 && _c.x == x && _c.y == y){
			_c.z = z - 10;
			_c.prevx = x;
			_c.prevy = y;
		}else if(snap == 2 && _c.z >= 0 && _c.prev2z < 0){
			_c.z = _c.prev2z;
		}
		_c.xprevious = _c.x;
		_c.yprevious = _c.y;
		if("my_health" in _c){
			if(_c.z >= -1 && _c.z <= 1){repeat(5) with(instance_create(_c.x,_c.y,Dust)){speed = random(5);direction = random(360);}}
			if(_c.my_health < _c.maxhealth && fork()){instance_create(_c.x,_c.y-_c.z,AcidStreak);_c.sprite_index = _c.spr_hurt;wait(8);if(instance_exists(self) && "chunks" in self && instance_exists(_c)){_c.sprite_index = _c.spr_idle;}exit;}
			if(_c.maxhealth - _c.my_health > damage){damage = _c.maxhealth - _c.my_health; nexthurt = 1;}
			_c.my_health = _c.maxhealth;
			if(_c.z >= 0 && _c.z < 10){_c.mask_index = _c.spr_idle;}else{_c.mask_index = mskNone;}
			if(_c.z < 0){
				_c.visible = false;
			}else{
				_c.visible = true;
				array_push(global.shadows, [_c.x, _c.y, _c.z]);
			}
		}
		if(instance_exists(chunks[array_length(chunks) - 1]) && instance_exists(chunks[array_length(chunks) - 2]) && chunks[array_length(chunks) - 1].image_index == 1 && chunks[array_length(chunks) - 1].y - chunks[array_length(chunks) - 2].y > 0){chunks[array_length(chunks) - 1].image_index = 3}
	}
}
if(damage > 0){
	my_health -= damage;
	sprite_index = spr_hurt;
	nexthurt = current_frame + 6;
	for(var i = array_length(chunks) - 1; i >= 0; i--;){
		if(instance_exists(chunks[i])){
			chunks[i].nexthurt = nexthurt;
		}
	}
}
if(nexthurt < current_frame){sprite_index = spr_idle;}
if(z > 0){
	crack = min(crack+current_time_scale,15);
	//script_bind_draw(MBShadow, 5, jumpEnd[0], jumpEnd[1], min(4,max(0,crack/3)));
}else {
	crack = max(crack-current_time_scale,0);
	if(crack/3 > 1-current_time_scale && crack/3 < 1+current_time_scale){
		repeat(6){instance_create(jumpEnd[0],jumpEnd[1],Dust).speed = 4;}
	}
	script_bind_draw(MBShadow, 5, jumpEnd[0], jumpEnd[1], min(4,max(0,4-crack/3)));
}
if(my_health <= 0){
	 // Boss Win Music:
	with(MusCont) alarm_set(1, 1);
	repeat(10){
		with(instance_create(x,y-z,AcidStreak)){
			speed = 5 + random(10);
			direction = random(360);
			image_angle = direction;
		}
	}
	sound_play_pitchvol(sndMaggotSpawnDie, 0.25, 1.95);
	pickup_drop(200, 0);
	with(chunks){
		if(instance_exists(self)){
			sound_play_pitchvol(sndMaggotSpawnDie, 0.25, 1.95);
			pickup_drop(30, 0);
			if("name" in self && name == "GigaMaggotTail"){
				repeat(10){
					with(instance_create(x,y-z,AcidStreak)){
						speed = 5 + random(10);
						direction = random(360);
						image_angle = direction;
					}
				}
			}
			if("bandit" in self && instance_exists(bandit)){
				bandit.sprite_index = global.bbandithurt;
				bandit.z = z;
				bandit.zspeed = 5;
				bandit.grav = grav;
				bandit.jumpStart = [bandit.x,bandit.y + z];
				direction = random(360);
				var length = 20 + random(45);
				var near = instance_nearest(bandit.jumpStart[0] + lengthdir_x(length, direction), bandit.jumpStart[1] + lengthdir_y(length, direction), Floor);
				bandit.jumpEnd = [near.x, near.y];
				bandit.jumpTime = (bandit.zspeed / bandit.grav) * 2;
				bandit.jumpTimer = 1;
				if(fork()){
					with(bandit){
						while(z >= 0){
							if(image_index > image_number - 1){image_speed = 0;}
							x = lerp(jumpStart[0], jumpEnd[0], jumpTimer/jumpTime);
							y = lerp(jumpStart[1], jumpEnd[1], jumpTimer/jumpTime) - z;
							z += zspeed * current_time_scale;
							zspeed -= grav * current_time_scale;
							image_angle += 15 * current_time_scale;
							gunangle += 15 * current_time_scale;
							jumpTimer += current_time_scale;
							wait(0);
							if(!instance_exists(self)){exit;}
						}
						repeat(2){
							with(instance_create(x,y,Rad)){
								direction = random(360);
								speed = 3;
							};
						}
						with(instance_create(x,y,Corpse)){
							sound_play(sndEnemyDie);
							sprite_index = global.bbanditdead;
							depth -= 1;
						}
						instance_destroy();
					}
					exit;
				}
			}
			if("my_health" in self){
				my_health = 0;
				candie = true;
				repeat(3){
					instance_create(x,y-z,AcidStreak);
				}
				if(z < 0){
					spr_dead = mskNone;
				}
				if(distance_to_object(Floor) > 20){
					instance_delete(self);
				}
			}
			else{instance_destroy();}
		}
		wait(4 - min(GameCont.loops, 3));
	}
	exit;
}

#define MBShadow(_x,_y,_index)
	draw_sprite_ext(global.crack, _index, _x, _y, 1, 1, 0, c_white, 1);
	instance_destroy();

#define draw_shadows
for(var i = 0; i < array_length(global.shadows); i++){
	var x = global.shadows[i][0];
	var y = global.shadows[i][1];
	var z = global.shadows[i][2];
	var spr = shd64B;
	if(z > 16){
		spr = shd64;
	}else if(z > 20){
		spr = shd48;
	}else if(z > 32){
		spr = shd32;
	}else if(z > 48){
		spr = shd24;
	}else if(z > 64){
		spr = shd16;
	}
	draw_sprite_ext(spr, 0, x, y, 1, 1, 0, c_white, 1);
}
global.shadows = [];

#define MBDraw
y -= z;
draw_self();
y += z;
	
#define MBHurt(_damage, _force, _direction)
	my_health -= _damage;
	nexthurt = current_frame + 6;
	sound_play_pitch(sndBigMaggotHit, 0.6);
	
	x = xprevious;
	y = yprevious;
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;

#define chunkDraw
y -= z;
draw_self();
y += z;

#define banditDraw
// Draw gun behind if aiming upward
if gunangle < 180{
	draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
}
// Draw self
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
// Draw gun ahead if aiming downward
if gunangle >= 180{
	draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
}

//thanks TE
#define boss_intro
intro = true;
wait(5);
with(MusCont){
	alarm_set(2, 1);
	alarm_set(3, -1);
}
with(script_bind_begin_step(boss_intro_step, 0)){
	boss    = "GigaMaggot";
	loops   = 0;
	intro   = true;
	sprites = [
		[`${boss}Main.png`, sprBossIntro,          0],
		[`${boss}Back.png`, sprBossIntroBackLayer, 0],
		[`${boss}Name.png`, sprBossName,           0]
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