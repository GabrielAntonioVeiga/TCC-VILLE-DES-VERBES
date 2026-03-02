/// --- CREATE EVENT ---

// Movimento
xspeed = 0;
yspeed = 0;

accel = 0.5;
maxspd = 4;
fric   = 0.2;

// Direções
enum DIR { RIGHT, DOWN, LEFT, UP }
facing = DIR.DOWN;

// Animação
anim_frame = 0;     
anim_timer = 0;
anim_delay = 8;     

moving = false;

// Desliga animação automática do sprite
image_speed = 0;
