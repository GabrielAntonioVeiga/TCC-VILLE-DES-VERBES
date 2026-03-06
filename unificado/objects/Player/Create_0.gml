/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 4F209397
/// @DnDArgument : "code" "/// --- CREATE EVENT ---$(13_10)$(13_10)// Movimento$(13_10)xspeed = 0;$(13_10)yspeed = 0;$(13_10)$(13_10)accel = 0.5;$(13_10)maxspd = 4;$(13_10)fric   = 0.2;$(13_10)$(13_10)// Direções$(13_10)enum DIR { RIGHT, DOWN, LEFT, UP }$(13_10)facing = DIR.DOWN;$(13_10)$(13_10)// Animação$(13_10)anim_frame = 0;$(13_10)anim_timer = 0;$(13_10)anim_delay = 8;   $(13_10)$(13_10)moving = false;$(13_10)$(13_10)// Desliga animação automática do sprite$(13_10)image_speed = 0;"
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

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 7615524D
/// @DnDArgument : "code" "/// @description Execute Code$(13_10)"
/// @description Execute Code