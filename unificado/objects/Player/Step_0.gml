/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 1EA3E833
/// @DnDArgument : "code" "// ================= INPUT =================$(13_10)var can_move = (global.dialogo == false);$(13_10)$(13_10)var RightKey = can_move ? keyboard_check(vk_right) : 0;$(13_10)var LeftKey  = can_move ? keyboard_check(vk_left) : 0;$(13_10)var UpKey    = can_move ? keyboard_check(vk_up) : 0;$(13_10)var DownKey  = can_move ? keyboard_check(vk_down) : 0;$(13_10)$(13_10)// ================= ACELERAÇÃO =================$(13_10)if (RightKey) xspeed += accel;$(13_10)if (LeftKey)  xspeed -= accel;$(13_10)if (DownKey)  yspeed += accel;$(13_10)if (UpKey)    yspeed -= accel;$(13_10)$(13_10)// ================= LIMITA VELOCIDADE =================$(13_10)xspeed = clamp(xspeed, -maxspd, maxspd);$(13_10)yspeed = clamp(yspeed, -maxspd, maxspd);$(13_10)$(13_10)// ================= ATRITO =================$(13_10)if (!RightKey && !LeftKey) {$(13_10)    if (abs(xspeed) < fric) xspeed = 0;$(13_10)    else xspeed -= sign(xspeed) * fric;$(13_10)}$(13_10)$(13_10)if (!UpKey && !DownKey) {$(13_10)    if (abs(yspeed) < fric) yspeed = 0;$(13_10)    else yspeed -= sign(yspeed) * fric;$(13_10)}$(13_10)$(13_10)// ================= DIREÇÃO =================$(13_10)if (RightKey)      facing = DIR.RIGHT;$(13_10)else if (LeftKey)  facing = DIR.LEFT;$(13_10)else if (UpKey)    facing = DIR.UP;$(13_10)else if (DownKey)  facing = DIR.DOWN;$(13_10)$(13_10)// ================= COLISÕES =================$(13_10)if (place_meeting(x + xspeed, y, Obstaculo)) {$(13_10)    xspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x, y + yspeed, Obstaculo)) {$(13_10)    yspeed = 0;$(13_10)}$(13_10)$(13_10)// ================= MOVIMENTO FINAL =================$(13_10)x += xspeed;$(13_10)y += yspeed;$(13_10)$(13_10)// ================= ESTADO DE MOVIMENTO =================$(13_10)moving = (abs(xspeed) > 0.05) || (abs(yspeed) > 0.05);$(13_10)$(13_10)// ================= ANIMAÇÃO =================$(13_10)// cada direção ocupa 4 frames$(13_10)// RIGHT=0, DOWN=1, LEFT=2, UP=3$(13_10)var dir_base = facing * 4;$(13_10)$(13_10)if (moving) {$(13_10)    anim_timer++;$(13_10)$(13_10)    if (anim_timer >= anim_delay) {$(13_10)        anim_timer = 0;$(13_10)        anim_frame = (anim_frame + 1) mod 4;$(13_10)    }$(13_10)}$(13_10)else {$(13_10)    // idle$(13_10)    anim_timer = 0;$(13_10)    anim_frame = 0;$(13_10)}$(13_10)$(13_10)// aplica frame correto$(13_10)image_index = dir_base + anim_frame;$(13_10)$(13_10)#region Diálogo e Quiz$(13_10)if (distance_to_object(ParenteNpc) <= global.range) {$(13_10)    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(Dialogo)) {$(13_10)        var npc = instance_nearest(x, y, ParenteNpc);$(13_10)        var _dialogoInst = instance_create_layer(x, y, "Dialogo", Dialogo);$(13_10)        _dialogoInst.nomeNpc = npc.nome;$(13_10)        $(13_10)        global.dialogo = true; $(13_10)    }$(13_10)}$(13_10)$(13_10)if (distance_to_object(ObjObstaculoQuiz) <= global.range) {$(13_10)    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz)) {$(13_10)        var obstaculo = instance_nearest(x, y, ObjObstaculoQuiz);$(13_10)        var _quizInst = instance_create_layer(0, 0, "Dialogo", obj_quiz);$(13_10)        _quizInst.pergunta = obstaculo.minha_pergunta;$(13_10)		_quizInst.tempo_verbal = obstaculo.meu_tempo_verbal;$(13_10)        _quizInst.opcoes = obstaculo.minhas_opcoes;$(13_10)        _quizInst.resposta_correta =  obstaculo.minha_resposta_correta;$(13_10)        global.dialogo = true; $(13_10)    $(13_10)}$(13_10)}"
// ================= INPUT =================
var can_move = (global.dialogo == false);

var RightKey = can_move ? keyboard_check(vk_right) : 0;
var LeftKey  = can_move ? keyboard_check(vk_left) : 0;
var UpKey    = can_move ? keyboard_check(vk_up) : 0;
var DownKey  = can_move ? keyboard_check(vk_down) : 0;

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

#region Diálogo e Quiz
if (distance_to_object(ParenteNpc) <= global.range) {
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(Dialogo)) {
        var npc = instance_nearest(x, y, ParenteNpc);
        var _dialogoInst = instance_create_layer(x, y, "Dialogo", Dialogo);
        _dialogoInst.nomeNpc = npc.nome;
        
        global.dialogo = true; 
    }
}

if (distance_to_object(ObjObstaculoQuiz) <= global.range) {
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz)) {
        var obstaculo = instance_nearest(x, y, ObjObstaculoQuiz);
        var _quizInst = instance_create_layer(0, 0, "Dialogo", obj_quiz);
        _quizInst.pergunta = obstaculo.minha_pergunta;
		_quizInst.tempo_verbal = obstaculo.meu_tempo_verbal;
        _quizInst.opcoes = obstaculo.minhas_opcoes;
        _quizInst.resposta_correta =  obstaculo.minha_resposta_correta;
        global.dialogo = true; 
    
}
}

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 12F0E123
/// @DnDArgument : "code" "// ================= TROCA DE SKIN =================$(13_10)var Skin1Key = keyboard_check_pressed(ord("1"));$(13_10)var Skin2Key = keyboard_check_pressed(ord("2"));$(13_10)$(13_10)if (Skin1Key) {$(13_10)    sprite_index = francine;$(13_10)	} else if (Skin2Key) {$(13_10)    sprite_index = jacques;$(13_10)}"
// ================= TROCA DE SKIN =================
var Skin1Key = keyboard_check_pressed(ord("1"));
var Skin2Key = keyboard_check_pressed(ord("2"));

if (Skin1Key) {
    sprite_index = francine;
	} else if (Skin2Key) {
    sprite_index = jacques;
}