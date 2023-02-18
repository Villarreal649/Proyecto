#define init
global.idle = sprite_add("Sprites/big sniper idle.png", 4, 32, 50);
global.walk = sprite_add("Sprites/big sniper walk.png", 6, 32, 50);
global.hurt = sprite_add("Sprites/big sniper hurt.png", 3, 32, 50);
global.dead = sprite_add("Sprites/big sniper dead.png", 9, 40, 58);
global.gun = sprite_add("Sprites/big sniper gun.png", 1, 8, 8);
global.bigBullet = sprite_add("Sprites/big sniper bullet.png", 2, 25, 25);
global.pierceBullet = sprite_add("Sprites/pierce sniper bullet.png", 2, 12, 25);
global.nade = sprite_add("Sprites/FireGrenade.png", 1, 8, 8);
global.song = sound_add("NTSniperRemix.ogg");
    
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
if(!instance_exists(GenCont) && GameCont.area == 3 && GameCont.subarea == 3){
	with(instances_matching_ne(BecomeScrapBoss, "BossesPlusCheck", 1)){
		BossesPlusCheck = 1;
		if((boss_chance() < 1 && global.override != 1) || global.override == 2){
			instance_create(x,y,PortalClear).mask_index = global.idle;
			with(instance_create(x,y, CustomEnemy)){
				name = "BigSniper";
				boss = true;
				
				 // For Sani's bosshudredux:
				bossname = "BIG SNIPER";
				col = c_red;
				
				team = 1;
				intro = 0;
				my_health = boss_hp(250);
				maxhealth = boss_hp(250);
				spr_idle = global.idle;
				spr_walk = global.walk;
				spr_hurt = global.hurt;
				spr_dead = global.dead;
				spr_gun = global.gun;
				spr_shadow = shd32;
				sprite_index = spr_idle;
				image_speed = 0.4;
				wkick = 0;
				gunangle = random(360);
				targetangle = gunangle;
				maxspeed = 3;
				walk = 0;
				friction = 0.8;
				depth = -2;
				laser = 1;
				searchDist = 250;
				introwait = 0;
				levelHP = 0;
				with(enemy){
					other.levelHP += my_health;
				}
				alrm0 = 0;
				alrm1 = 0;
				alrm2 = 0;
				size = 3;
				hitid = [global.idle, "Big Sniper"];
				on_step = BigSniper_step;
				on_draw = BigSniper_draw;
				on_hurt = BigSniper_hurt;
				on_destroy = BigSniper_destroy;
				raddrop = 50;
				nadeAmmo = 1;
			}
			instance_delete(self);
			break;
		}
	}
}
	
#define scr_target
	// Edit this as you see fit to match the complexity of your enemy
	if instance_exists(Player){
		var n = instance_nearest(x,y,Player);
		if !collision_line(x,y,n.x,n.y,Wall,0,1){
			target = n;
		}else target = -4;
	}
#define BigSniper_step
	if((image_index + image_speed_raw >= image_number || image_index + image_speed_raw < 0) && sprite_index == spr_hurt){
		sprite_index = spr_idle;
	}
	if(!intro){
		if("rotDir" not in self){rotDir = irandom(1) * 2 - 1;}
		if(introwait <= 0){
			targetangle += current_time_scale * 2 * min(maxhealth/my_health, 10) * rotDir * ("leadsleep" in self && leadsleep > 0 ? 0.25 : 1);
		}else{
			introwait -= current_time_scale;
		}
		direction = gunangle;
		var _levelHP = 0;
		with(enemy){
			_levelHP += my_health;
		}
		searchDist = 150 * (11-(_levelHP/levelHP)*6-(my_health/maxhealth)*4)
		script_bind_draw(BigSniper_searchDraw, -7, self);
		list = instances_matching_gt(Player, "my_health", 0);
		for(var i = array_length(list) - 1; i >= 0; i--){
			if ((distance_to_object(list[i]) < 30 || distance_to_object(list[i]) < searchDist-30 && abs(angle_difference(gunangle,point_direction(x,y,list[i].x,list[i].y))) < 15) && !collision_line(x + lengthdir_x(searchDist/2, gunangle),y + lengthdir_y(searchDist/2, gunangle),list[i].x,list[i].y,Wall,0,1) || my_health/maxhealth < 0.6){
				targetangle = point_direction(x,y-10,list[i].x,list[i].y);
				if(fork()){
					boss_intro();
					leadsleep = 0;
					alrm0 = 10;
					exit;
				}
				break;
			}
		}
		right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	}
	if(alrm0 > 0){
		alrm0 -= current_time_scale;
		target = instance_nearest(x,y,Player);
		if alrm0 <= 0{
			if(instance_exists(target)){
				targetangle = point_direction(x,y-10,target.x,target.y);
			}
			if instance_exists(target) && distance_to_object(Player) < 300{
				if random(2) < 1 && distance_to_object(target) > 48{
					nadeAmmo = min(nadeAmmo + 1, 2);
					if(!collision_line(x,y,target.x,target.y,Wall,0,1) && random(2) < 1){
						alrm1 = 25;
						sound_play_pitchvol(sndSniperTarget,0.4,4.2);
						alrm0 = 50 - min(GameCont.loops, 20);
					}else{
						alrm2 = 20;
						sound_play_pitchvol(sndSniperTarget,0.6,4.2);
						alrm0 = 40 - min(GameCont.loops, 20);
					}
				}else if random(3) < 2 && distance_to_object(target) < 200 && nadeAmmo > 0{
					nadeAmmo--;
					alrm0 = 25 - min(GameCont.loops, 5);
					sound_play_pitchvol(sndGrenadeHitWall, 1.5, 1.5);
					repeat(GameCont.loops + 1){
						with(instance_create(x,y - 12,CustomProjectile)){
							team = other.team;
							creator = other;
							timer = 0;
							speed = min(distance_to_object(Player) / 64 * random_range(0.75, 1.5), 12);
							zspeed = 0;
							z = 0;
							direction = point_direction(x,y,other.target.x + hspeed * random_range(0, 3+GameCont.loops),other.target.y + vspeed * random_range(0, 3+GameCont.loops)) + random_range(-35-GameCont.loops*5, 35+GameCont.loops*5);
							image_angle = direction;
							image_speed = 0.4;
							sprite_index = global.nade;
							mask_index = mskNone;
							on_step = nade_step;
							on_draw = nade_draw;
							on_destroy = nade_destroy;
							depth = -8;
							hitid = [global.idle, "Big Sniper"];
							shadow = instance_create(x,y+z,CustomObject);
							shadow.sprite_index = shd16;
							shadow.image_alpha = 0.4;
						}
					}
				}else{
					// Set direction to circle player if far enough away, or move away if too close
					if distance_to_object(target) > 128{
						direction = targetangle + (random_range(30,60) * choose(-1,1)); // Circles the player;
					}else direction = -targetangle + (random_range(30,60) * choose(-1,1)); // Moves away from them if too close
					walk = 25;
					alrm0 = walk - 10;
				}
			}else{
				// No target, just idle
				targetangle = random(360);
				direction = targetangle;
				walk = 30 + random(20);
				alrm0 = walk + random(10);
			}
		}
	}
	if(alrm1 > 0){
		alrm1 -= current_time_scale;
		if alrm1 <= 0{
			sound_play_pitchvol(sndSniperFire,random_range(0.6,0.8), 2.5);
			wkick = 5;
			with(instance_create(x + lengthdir_x(32, gunangle),y - 12 + lengthdir_y(32, gunangle),CustomProjectile)){
				timer = 250 + 50 * GameCont.loops;
				hitstun = 0;
				team = other.team;
				creator = other;
				speed = 0;
				damage = 3;
				typ = 1;
				direction = other.gunangle;
				image_angle = direction;
				sprite_index = global.bigBullet;
				mask_index = mskBullet2;
				on_step = bigBullet_step;
				on_hit = bigBullet_hit;
				on_draw = bigBullet_draw;
				on_wall = bigBullet_wall;
				on_destroy = bigBullet_destroy;
				hitid = [global.idle, "Big Sniper"];
			}
		}
	}
	if(alrm2 > 0){
		alrm2 -= current_time_scale;
		if alrm2 <= 0{
			sound_play_pitchvol(sndSniperFire,random_range(1.4,1.6), 1.5);
			wkick = 5;
			with(instance_create(x + lengthdir_x(32, gunangle),y - 12 + lengthdir_y(32, gunangle),CustomProjectile)){
				walls = 16;
				team = other.team;
				creator = other;
				speed = 14;
				damage = 4;
				typ = 1;
				direction = other.gunangle;
				image_angle = direction;
				sprite_index = global.pierceBullet;
				mask_index = mskBullet2;
				on_step = pierceBullet_step;
				on_hit = pierceBullet_hit;
				on_wall = pierceBullet_wall;
				hitid = [global.idle, "Big Sniper"];
			}
		}
	}
	
	gunangle = (gunangle - angle_difference(gunangle, targetangle) * 0.15 + 360) % 360;
	
	// If walk > 0, walk. Assigns sprites accordingly.
	if(walk > 0){
		walk -= current_time_scale;
		speed += current_time_scale;
		if sprite_index != spr_hurt sprite_index = spr_walk;
	}else{
		if speed < 1 && sprite_index != spr_hurt{
			sprite_index = spr_idle;
		}
	}
	// Limits speed
	speed = clamp(-maxspeed,speed,maxspeed);
	// Flips the sprite
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;

//Thank you Xef, that elite turret code was useful
#define BigSniper_searchDraw(obj)
with(obj){
	draw_set_blend_mode(bm_subtract);
	draw_set_alpha(0.05);
	draw_set_colour(make_color_rgb(0,150,200));
	draw_primitive_begin(pr_trianglefan);
	draw_vertex(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - 8 + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle));
	var primitiveangle = -15
	repeat(round(10*4/3 + 1)) {
		draw_vertex(x+lengthdir_x(searchDist,gunangle+primitiveangle), y-10+lengthdir_y(searchDist,gunangle+primitiveangle));
		primitiveangle += 15/round(10*2/3);
	}
	draw_primitive_end();
	draw_set_colour(make_color_rgb(0,200,255));
	draw_primitive_begin(pr_trianglefan);
	draw_vertex(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - 8 + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle));
	var primitiveangle = -15
	repeat(round(10*4/3 + 1)) {
		draw_vertex(x+lengthdir_x(searchDist*2/3,gunangle+primitiveangle), y-10+lengthdir_y(searchDist*2/3,gunangle+primitiveangle));
		primitiveangle += 15/round(10*2/3);
	}
	draw_primitive_end();
	draw_set_blend_mode(bm_normal);
	draw_set_alpha(1);
}
instance_destroy();
	
#define BigSniper_draw
	var gunoffset = 12;
	// Draw gun behind if aiming upward
	if gunangle < 180{
		draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y - gunoffset + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
	}
	// Draw self
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	// Draw gun ahead if aiming downward
	if gunangle >= 180{
		draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y - gunoffset + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
	}
	draw_set_color(c_red);
	draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle, 800, 1);
	if(!intro){
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle) + lengthdir_x(searchDist/2, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle) + lengthdir_y(searchDist/2, gunangle), gunangle+180, searchDist/2, 2);
	}
	if(alrm1 > 0){
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle + alrm1, 800, 1);
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle - alrm1, 800, 1);
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle + alrm1/2, 800, 1);
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle - alrm1/2, 800, 1);
	}
	if(alrm2 > 0){
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle + cos(alrm2/10) * 5 * sin(alrm2/6-0.2), 800, 1);
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle - cos(alrm2/10) * 5 * sin(alrm2/6-0.2), 800, 1);
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle + sin(alrm2/10) * 5 * sin(alrm2/6-0.2), 800, 1);
		draw_lasersight(x + lengthdir_x(-wkick,gunangle) + lengthdir_x(right * 4, gunangle + 90) + lengthdir_x(24, gunangle),y - gunoffset + lengthdir_y(-wkick, gunangle) + lengthdir_y(right * 4, gunangle + 90) + lengthdir_y(24, gunangle), gunangle - sin(alrm2/10) * 5 * sin(alrm2/6-0.2), 800, 1);
	}
	
#define BigSniper_hurt(_damage, _force, _direction)
	my_health -= _damage;
	nexthurt = current_frame + 6;
	motion_add(_direction, _force);
	sound_play_pitchvol(sndSniperHit, 0.5, 2);
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;
	
	if(!intro){
		targetangle = _direction - 180;
		introwait = 30;
	}

#define BigSniper_destroy
	pickup_drop(350, 15);
	pickup_drop(50, 0);
	pickup_drop(30, 0);
	speed = 0;
	var _x = x;
	var _y = y;
	var _t = team;
	var _c = self;
	var _d = direction;
	if(fork()){
		with(Corpse){
			if(alarm_get(0) > -1){
				alarm_set(0, 150);
			}
		}
		wait(50);
		with(instance_nearest(_x,_y,Corpse)){
			alarm_set(0, 75);
		}
		exit;
	}
	for(var i = 10; i < 150; i += 10){
		for(var i2 = 0; i2 < 360; i2 += 90){
			with(instance_create(_x,_y,TrapFire)){
				direction = i + i2 + _d + 45;
				image_angle = direction;
				speed = log2(i/20)*0.4;
				team = _t;
				creator = _c;
				image_speed /= 2;
				hitid = [global.idle, "Big Sniper"];
				if(fork()){
					var __x = x;
					var __y = y;
					wait(10);
					var i = 1;
					repeat(5){
						wait(ceil(15/i));
						i++;
						if(instance_exists(self)){
							__x = x;
							__y = y;
							instance_create(x,y,SmallExplosion).hitid = [global.idle, "Big Sniper"];
							sound_play_pitchvol(sndExplosion, 1.4, 0.5);
						}
					}
					with(instance_create(__x,__y,Explosion)){
						hitid = [global.idle, "Big Sniper"];
						team = _t;
					}
					sound_play(sndExplosion);
					exit;
				}
			}
		}
		wait(1);
	}
	 // Boss Win Music:
	with(MusCont) alarm_set(1, 1);
	
#define nade_step
	shadow.x = x;
	shadow.y = y;
	timer += current_time_scale;
	z += zspeed;
	image_angle = timer * 10;
	if(timer < 15 && !instance_exists(creator)){speed = 0;}
	if(timer < 10 && instance_exists(creator)){
		x = creator.x + cos(timer/3.14159) * 12 * creator.right;
		y = creator.y + sin(timer/3.14159) * 6 - 6;
	}else if(timer < 15 && instance_exists(creator)){
		x = creator.x + cos((timer-5)*2/3.14159) * 12 * creator.right;
		y = creator.y - sin((timer-5)*2/3.14159) * 6 - 6;
	}else if(z == 0 && zspeed == 0){
		zspeed = 6;
	}else if(z <= 0){
		instance_destroy();
	}else{
		zspeed -= current_time_scale/4;
	}
	
#define nade_draw
	y -= z;
	draw_self();
	y += z;
	
#define nade_destroy
	sound_play(sndFlareExplode);
	with(shadow){instance_destroy();}
	if(distance_to_object(Floor) < 20){
		instance_create(x,y,Explosion);
		var _x = x;
		var _y = y;
		var _t = team;
		var _c = creator;
		var _d = direction;
		pickup_drop(30, 0);
		for(var i = 10; i < 360; i += 55){
			for(var i2 = 0; i2 < 360; i2 += 90){
				with(instance_create(_x,_y,TrapFire)){
					direction = i + i2 + _d + 45;
					image_angle = direction;
					speed = log2(i/20)*0.5;
					team = _t;
					creator = _c;
					hitid = [global.idle, "Big Sniper"];
				}
			}
		}
	}
	
#define bigBullet_step
	if(image_index > image_number - 2 || image_speed == 0){
		image_index = image_number - 1;
		image_speed = 0;
	}
	image_angle = direction;
	timer--;
	hitstun--;
	if(instance_exists(creator) && team != creator.team){timer = min(timer, 30);}
	var counter = 0;
	if(hitstun <= 0){
		repeat(4){
			xprevious = x;
			yprevious = y;
			speed = min(5, GameCont.loops/2 + 2) * current_time_scale;
			x += hspeed;
			y += vspeed;
			var _dir = direction;
			if(place_meeting(x,y,hitme)) with(hitme){
				if(place_meeting(x,y,other) && team != other.team && projectile_canhit_np(self)){
					projectile_hit(self, other.damage, other.force, other.direction);
					if("lasthit" in self) lasthit = other.hitid;
				}
			}
			move_bounce_solid(false);
			speed = 0;
			if(direction != _dir){
				image_index = 0;
				sound_play_pitch(sndShotgun, 1.4);
				repeat(3){
					with(instance_create(x,y,EnemyBullet3)){
						creator = other.creator;
						team = other.team;
						direction = _dir + 180 + random_range(-60, 60);
						image_angle = direction;
						speed = 8;
					}
				}
				hitstun = 5;
				timer -= 15;
				break;
			}
			with(instance_create(x,y,Effect)){
				sprite_index = other.sprite_index;
				image_index = 1;
				image_speed = 0;
				speed = 0;
				direction = other.direction;
				image_angle = direction;
				image_alpha = 1 - (counter + 1) * 0.1 * current_time_scale;
				image_yscale = image_alpha;
				if(fork()){
					while(instance_exists(self) && image_alpha > 0){
						wait(0);
						if(instance_exists(self)){
							image_alpha -= 0.4 * current_time_scale;
							image_yscale = image_alpha;
						}
					}
					if(instance_exists(self)){
						instance_destroy();
					}
					exit;
				}
			}
			counter++;
		}
	}
	if(timer <= 0){
		instance_destroy();
	}
	
#define bigBullet_wall

#define bigBullet_hit
repeat(3){
	with(instance_create(x,y,EnemyBullet3)){
		creator = other.creator;
		team = other.team;
		direction = other.direction + 180 + random_range(-60, 60);
		image_angle = direction;
		speed = 8;
		hitid = [global.idle, "Big Sniper"];
	}
}
instance_destroy();

#define bigBullet_draw
draw_self();

#define bigBullet_destroy
for(var i = 0; i < 360; i += 60){
	with(instance_create(x,y,EnemyBullet3)){
		creator = other.creator;
		team = other.team;
		direction = i + random_range(-20, 20);
		image_angle = direction;
		speed = 8;
	}
}

#define pierceBullet_step
	if(image_index > image_number - 2 || image_speed == 0){
		image_index = image_number - 1;
		image_speed = 0;
	}
	image_angle = direction;
	speed = 16;
	walls -= 0.5 * current_time_scale;

#define pierceBullet_hit
	var _inst = other;
	if(speed > 0 && projectile_canhit(_inst)){
		projectile_hit(_inst, damage, force, direction);
	}

//got the idea for FloorExplos from defpack
#define pierceBullet_wall
speed = 4;
if(--walls > 0){with other {instance_create(x,y,FloorExplo);instance_destroy();}}else{instance_destroy();}

//thanks TE
#define boss_intro
intro = true;
wait(5);
with(MusCont){
	alarm_set(2, 1);
	alarm_set(3, -1);
}
with(script_bind_begin_step(boss_intro_step, 0)){
	boss    = "BigSniper";
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
	
//..and yet again.
#define draw_lasersight(_x, _y, _dir, _disMax, _width)
	/*
		Performs hitscan and draws a laser sight line
		Returns the line's ending position
	*/
	
	var	_dis  = _disMax,
		_disX = lengthdir_x(_dis, _dir),
		_disY = lengthdir_y(_dis, _dir);
		
	 // Major Hitscan Mode (Start at max, halve distance until no collision line):
	while(_dis >= 1 && collision_line(_x, _y, _x + _disX, _y + _disY, Wall, false, false)){
		_dis  /= 2;
		_disX /= 2;
		_disY /= 2;
	}
	
	 // Minor Hitscan Mode (Increment until walled):
	if(_dis < _disMax){
		var	_disAdd  = max(2, _dis / 32),
			_disAddX = lengthdir_x(_disAdd, _dir),
			_disAddY = lengthdir_y(_disAdd, _dir);
			
		while(_dis > 0 && !position_meeting(_x + _disX, _y + _disY, Wall)){
			_dis  -= _disAdd;
			_disX += _disAddX;
			_disY += _disAddY;
		}
	}
	
	 // Draw:
	draw_line_width(
		_x - 1,
		_y - 1,
		_x - 1 + _disX,
		_y - 1 + _disY,
		_width
	);
	
	return [_x + _disX, _y + _disY];