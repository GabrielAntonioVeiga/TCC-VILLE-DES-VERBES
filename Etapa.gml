// ================= INPUT =================
var RightKey = keyboard_check(vk_right);
var LeftKey  = keyboard_check(vk_left);
var UpKey    = keyboard_check(vk_up);
var DownKey  = keyboard_check(vk_down);

// ================= ACELERAÇÃO =================
if (RightKey) xspeed += accel;
if (LeftKey)  xspeed -= accel;
if (DownKey)  yspeed += accel;
if (UpKey)    yspeed -= accel;

// ================= LIMITA VELOCIDADE =================
xspeed = clamp(xspeed, -maxspd, maxspd);
yspeed = clamp(yspeed, -maxspd, maxspd);

// ================= ATRITO =================
if (!RightKey && !LeftKey) {
    if (abs(xspeed) < fric) xspeed = 0;
    else xspeed -= sign(xspeed) * fric;
}

if (!UpKey && !DownKey) {
    if (abs(yspeed) < fric) yspeed = 0;
    else yspeed -= sign(yspeed) * fric;
}

// ================= DIREÇÃO =================
if (RightKey)      facing = DIR.RIGHT;
else if (LeftKey)  facing = DIR.LEFT;
else if (UpKey)    facing = DIR.UP;
else if (DownKey)  facing = DIR.DOWN;

// ================= COLISÕES =================
if (place_meeting(x + xspeed, y, Obstaculo)) {
    xspeed = 0;
}

if (place_meeting(x, y + yspeed, Obstaculo)) {
    yspeed = 0;
}

// ================= MOVIMENTO FINAL =================
x += xspeed;
y += yspeed;

// ================= ESTADO DE MOVIMENTO =================
moving = (abs(xspeed) > 0.05) || (abs(yspeed) > 0.05);

// ================= ANIMAÇÃO =================
// cada direção ocupa 4 frames
// RIGHT=0, DOWN=1, LEFT=2, UP=3
var dir_base = facing * 4;

if (moving) {
    anim_timer++;

    if (anim_timer >= anim_delay) {
        anim_timer = 0;
        anim_frame = (anim_frame + 1) mod 4;
    }
}
else {
    // idle
    anim_timer = 0;
    anim_frame = 0;
}

// aplica frame correto
image_index = dir_base + anim_frame;
