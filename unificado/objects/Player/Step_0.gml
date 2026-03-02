/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 6C19CB98
/// @DnDArgument : "code" "// ================= INPUT =================$(13_10)var RightKey = keyboard_check(vk_right);$(13_10)var LeftKey  = keyboard_check(vk_left);$(13_10)var UpKey    = keyboard_check(vk_up);$(13_10)var DownKey  = keyboard_check(vk_down);$(13_10)$(13_10)// ================= ACELERAÇÃO =================$(13_10)if (RightKey) xspeed += accel;$(13_10)if (LeftKey)  xspeed -= accel;$(13_10)if (DownKey)  yspeed += accel;$(13_10)if (UpKey)    yspeed -= accel;$(13_10)$(13_10)// ================= LIMITA VELOCIDADE =================$(13_10)xspeed = clamp(xspeed, -maxspd, maxspd);$(13_10)yspeed = clamp(yspeed, -maxspd, maxspd);$(13_10)$(13_10)// ================= ATRITO =================$(13_10)if (!RightKey && !LeftKey) {$(13_10)    if (abs(xspeed) < fric) xspeed = 0;$(13_10)    else xspeed -= sign(xspeed) * fric;$(13_10)}$(13_10)$(13_10)if (!UpKey && !DownKey) {$(13_10)    if (abs(yspeed) < fric) yspeed = 0;$(13_10)    else yspeed -= sign(yspeed) * fric;$(13_10)}$(13_10)$(13_10)// ================= DIREÇÃO =================$(13_10)if (RightKey)      facing = DIR.RIGHT;$(13_10)else if (LeftKey)  facing = DIR.LEFT;$(13_10)else if (UpKey)    facing = DIR.UP;$(13_10)else if (DownKey)  facing = DIR.DOWN;$(13_10)$(13_10)// ================= COLISÕES =================$(13_10)if (place_meeting(x + xspeed, y, Obstaculo)) {$(13_10)    xspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x, y + yspeed, Obstaculo)) {$(13_10)    yspeed = 0;$(13_10)}$(13_10)$(13_10)// ================= MOVIMENTO FINAL =================$(13_10)x += xspeed;$(13_10)y += yspeed;$(13_10)$(13_10)// ================= ESTADO DE MOVIMENTO =================$(13_10)moving = (abs(xspeed) > 0.05) || (abs(yspeed) > 0.05);$(13_10)$(13_10)// ================= ANIMAÇÃO =================$(13_10)// cada direção ocupa 4 frames$(13_10)// RIGHT=0, DOWN=1, LEFT=2, UP=3$(13_10)var dir_base = facing * 4;$(13_10)$(13_10)if (moving) {$(13_10)    anim_timer++;$(13_10)$(13_10)    if (anim_timer >= anim_delay) {$(13_10)        anim_timer = 0;$(13_10)        anim_frame = (anim_frame + 1) mod 4;$(13_10)    }$(13_10)}$(13_10)else {$(13_10)    // idle$(13_10)    anim_timer = 0;$(13_10)    anim_frame = 0;$(13_10)}$(13_10)$(13_10)// aplica frame correto$(13_10)image_index = dir_base + anim_frame;"
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