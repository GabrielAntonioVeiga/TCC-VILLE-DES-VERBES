/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 1EA3E833
/// @DnDArgument : "code" "// ================= INPUT =================$(13_10)var can_move = (global.dialogo == false);$(13_10)$(13_10)var RightKey = can_move ? keyboard_check(vk_right) : 0;$(13_10)var LeftKey  = can_move ? keyboard_check(vk_left) : 0;$(13_10)var UpKey    = can_move ? keyboard_check(vk_up) : 0;$(13_10)var DownKey  = can_move ? keyboard_check(vk_down) : 0;$(13_10)$(13_10)// ================= ACELERAÇÃO =================$(13_10)if (RightKey) xspeed += accel;$(13_10)if (LeftKey)  xspeed -= accel;$(13_10)if (DownKey)  yspeed += accel;$(13_10)if (UpKey)    yspeed -= accel;$(13_10)$(13_10)// ================= LIMITA VELOCIDADE =================$(13_10)xspeed = clamp(xspeed, -maxspd, maxspd);$(13_10)yspeed = clamp(yspeed, -maxspd, maxspd);$(13_10)$(13_10)// Limite velocidade na diagonal$(13_10)var spd = point_distance(0, 0, xspeed, yspeed);$(13_10)$(13_10)if (spd > maxspd) {$(13_10)    var dir = point_direction(0, 0, xspeed, yspeed);$(13_10)    xspeed = lengthdir_x(maxspd, dir);$(13_10)    yspeed = lengthdir_y(maxspd, dir);$(13_10)}$(13_10)$(13_10)// ================= Mobilidade da Camera =========$(13_10)var x_view = camera_get_view_x(view_camera[0]);$(13_10)var y_view = camera_get_view_y(view_camera[0]);$(13_10)var w_view = camera_get_view_width(view_camera[0]);$(13_10)var h_view = camera_get_view_height(view_camera[0]);$(13_10)$(13_10)// Configurações de intensidade$(13_10)var suavidade = 0.1; // Quanto menor, mais lenta/suave é a camera$(13_10)var look_ahead = 10; // O quanto a camera olha para a frente/antecipa o movimento$(13_10)$(13_10)// Calculamos o destino ideal (Centro do player + um deslocamento baseado na velocidade)$(13_10)var go_to_x = (x - w_view / 2) + (xspeed * look_ahead / maxspd);$(13_10)var go_to_y = (y - h_view / 2) + (yspeed * look_ahead / maxspd);$(13_10)$(13_10)// Interpolação (suavização) entre a posição atual e a posição de destino$(13_10)var new_x = lerp(x_view, go_to_x, suavidade);$(13_10)var new_y = lerp(y_view, go_to_y, suavidade);$(13_10)$(13_10)// Impedir que a camera saia dos limites da sala (Room)$(13_10)new_x = clamp(new_x, 0, room_width - w_view);$(13_10)new_y = clamp(new_y, 0, room_height - h_view);$(13_10)$(13_10)// Aplica a nova posição à camera$(13_10)camera_set_view_pos(view_camera[0], new_x, new_y);$(13_10)$(13_10)// ================= ATRITO =================$(13_10)if (!RightKey && !LeftKey) {$(13_10)    if (abs(xspeed) < fric) xspeed = 0;$(13_10)    else xspeed -= sign(xspeed) * fric;$(13_10)}$(13_10)$(13_10)if (!UpKey && !DownKey) {$(13_10)    if (abs(yspeed) < fric) yspeed = 0;$(13_10)    else yspeed -= sign(yspeed) * fric;$(13_10)}$(13_10)$(13_10)// ================= DIREÇÃO =================$(13_10)if (RightKey)      facing = DIR.RIGHT;$(13_10)else if (LeftKey)  facing = DIR.LEFT;$(13_10)else if (UpKey)    facing = DIR.UP;$(13_10)else if (DownKey)  facing = DIR.DOWN;$(13_10)$(13_10)// ================= COLISÕES =================$(13_10)if (place_meeting(x + xspeed, y, Obstaculo)) {$(13_10)    xspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x, y + yspeed, Obstaculo)) {$(13_10)    yspeed = 0;$(13_10)}$(13_10)if (place_meeting(x + xspeed, y, obj_npc_missao)) {$(13_10)    xspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x, y + yspeed, obj_npc_missao)) {$(13_10)    yspeed = 0;$(13_10)}$(13_10)if (place_meeting(x + xspeed, y, ObjObstaculoQuiz)) {$(13_10)    xspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x, y + yspeed, obj_parede_invisivel)) {$(13_10)    yspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x + xspeed, y, obj_parede_invisivel)) {$(13_10)    xspeed = 0;$(13_10)}$(13_10)$(13_10)if (place_meeting(x, y + yspeed, ObjObstaculoQuiz)) {$(13_10)    yspeed = 0;$(13_10)}$(13_10)$(13_10)$(13_10)$(13_10)// ================= MOVIMENTO FINAL =================$(13_10)x += xspeed;$(13_10)y += yspeed;$(13_10)$(13_10)// ================= ESTADO DE MOVIMENTO =================$(13_10)moving = (abs(xspeed) > 0.05) || (abs(yspeed) > 0.05);$(13_10)$(13_10)// ================= SOM DE PASSOS =================$(13_10)if (anim_frame == 1 || anim_frame == 3)$(13_10){$(13_10)    if (!audio_is_playing(som_passo))$(13_10)    {$(13_10)        som_passo = audio_play_sound($(13_10)            passos[irandom(array_length(passos)-1)],$(13_10)            1,$(13_10)            false$(13_10)        );$(13_10)    }$(13_10)}$(13_10)$(13_10)// ================= ANIMAÇÃO =================$(13_10)// cada direção ocupa 4 frames$(13_10)// RIGHT=0, DOWN=1, LEFT=2, UP=3$(13_10)var dir_base = facing * 4;$(13_10)$(13_10)if (moving) {$(13_10)    anim_timer++;$(13_10)$(13_10)    if (anim_timer >= anim_delay) {$(13_10)        anim_timer = 0;$(13_10)        anim_frame = (anim_frame + 1) mod 4;$(13_10)    }$(13_10)}$(13_10)else {$(13_10)    // idle$(13_10)    anim_timer = 0;$(13_10)    anim_frame = 0;$(13_10)}$(13_10)$(13_10)// aplica frame correto$(13_10)image_index = dir_base + anim_frame;$(13_10)$(13_10)#region Diálogo e Quiz$(13_10)var _hud_aberta = false;$(13_10)if (instance_exists(obj_hud)) {$(13_10)    _hud_aberta = (obj_hud.state != "closed");$(13_10)}$(13_10)$(13_10)if (!_hud_aberta) {$(13_10)    $(13_10)    if (distance_to_object(ParenteNpc) <= global.range) {$(13_10)        if (keyboard_check_pressed(ord("E")) && global.dialogo == false $(13_10)            && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {$(13_10)            var npc = instance_nearest(x, y, ParenteNpc);$(13_10)            $(13_10)            if (npc.object_index != obj_npc_missao) {$(13_10)                var _dialogoInst = instance_create_layer(x, y, "Dialogo", Dialogo);$(13_10)                if (variable_instance_exists(npc, "nome")) {$(13_10)                    _dialogoInst.nomeNpc = npc.nome;$(13_10)                } else {$(13_10)                    _dialogoInst.nomeNpc = "";$(13_10)                }$(13_10)                global.dialogo = true; $(13_10)            }$(13_10)        }$(13_10)    }$(13_10)$(13_10)  if (distance_to_object(ObjObstaculoQuiz) <= global.range) {$(13_10)    var _instancia_perto = instance_nearest(x, y, ObjObstaculoQuiz);$(13_10)$(13_10)    if (keyboard_check_pressed(ord("E")) && global.dialogo == false $(13_10)        && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {$(13_10)        $(13_10)        var _verbo_escolhido = "";$(13_10)        $(13_10)        if (variable_instance_exists(_instancia_perto, "meu_quiz_id")) {$(13_10)            if (is_array(_instancia_perto.meu_quiz_id)) {$(13_10)                if (!variable_instance_exists(_instancia_perto, "quiz_sorteado_fixo")) {$(13_10)                    var _sorteio = irandom(array_length(_instancia_perto.meu_quiz_id) - 1);$(13_10)                    _instancia_perto.quiz_sorteado_fixo = _instancia_perto.meu_quiz_id[_sorteio];$(13_10)                }$(13_10)                _verbo_escolhido = _instancia_perto.quiz_sorteado_fixo; $(13_10)            } else {$(13_10)                _verbo_escolhido = _instancia_perto.meu_quiz_id; $(13_10)            }$(13_10)        }$(13_10)        $(13_10)        var _q = instance_create_layer(0, 0, "interacao", obj_quiz);$(13_10)        _q.quiz_id = _verbo_escolhido;$(13_10)        _q.pergunta_id = _verbo_escolhido;$(13_10)        $(13_10)        global.dialogo = true;$(13_10)        exit; // 🆕 impede qualquer outro código no mesmo frame$(13_10)    }$(13_10)}$(13_10)}"
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

// Limite velocidade na diagonal
var spd = point_distance(0, 0, xspeed, yspeed);

if (spd > maxspd) {
    var dir = point_direction(0, 0, xspeed, yspeed);
    xspeed = lengthdir_x(maxspd, dir);
    yspeed = lengthdir_y(maxspd, dir);
}

// ================= Mobilidade da Camera =========
var x_view = camera_get_view_x(view_camera[0]);
var y_view = camera_get_view_y(view_camera[0]);
var w_view = camera_get_view_width(view_camera[0]);
var h_view = camera_get_view_height(view_camera[0]);

// Configurações de intensidade
var suavidade = 0.1; // Quanto menor, mais lenta/suave é a camera
var look_ahead = 10; // O quanto a camera olha para a frente/antecipa o movimento

// Calculamos o destino ideal (Centro do player + um deslocamento baseado na velocidade)
var go_to_x = (x - w_view / 2) + (xspeed * look_ahead / maxspd);
var go_to_y = (y - h_view / 2) + (yspeed * look_ahead / maxspd);

// Interpolação (suavização) entre a posição atual e a posição de destino
var new_x = lerp(x_view, go_to_x, suavidade);
var new_y = lerp(y_view, go_to_y, suavidade);

// Impedir que a camera saia dos limites da sala (Room)
new_x = clamp(new_x, 0, room_width - w_view);
new_y = clamp(new_y, 0, room_height - h_view);

// Aplica a nova posição à camera
camera_set_view_pos(view_camera[0], new_x, new_y);

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
if (place_meeting(x + xspeed, y, obj_npc_missao)) {
    xspeed = 0;
}

if (place_meeting(x, y + yspeed, obj_npc_missao)) {
    yspeed = 0;
}
if (place_meeting(x + xspeed, y, ObjObstaculoQuiz)) {
    xspeed = 0;
}

if (place_meeting(x, y + yspeed, obj_parede_invisivel)) {
    yspeed = 0;
}

if (place_meeting(x + xspeed, y, obj_parede_invisivel)) {
    xspeed = 0;
}

if (place_meeting(x, y + yspeed, ObjObstaculoQuiz)) {
    yspeed = 0;
}



// ================= MOVIMENTO FINAL =================
x += xspeed;
y += yspeed;

// ================= ESTADO DE MOVIMENTO =================
moving = (abs(xspeed) > 0.05) || (abs(yspeed) > 0.05);

// ================= SOM DE PASSOS =================
if (anim_frame == 1 || anim_frame == 3)
{
    if (!audio_is_playing(som_passo))
    {
        som_passo = audio_play_sound(
            passos[irandom(array_length(passos)-1)],
            1,
            false
        );
    }
}

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
var _hud_aberta = false;
if (instance_exists(obj_hud)) {
    _hud_aberta = (obj_hud.state != "closed");
}

if (!_hud_aberta) {
    
    if (distance_to_object(ParenteNpc) <= global.range) {
        if (keyboard_check_pressed(ord("E")) && global.dialogo == false 
            && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
            var npc = instance_nearest(x, y, ParenteNpc);
            
            if (npc.object_index != obj_npc_missao) {
                var _dialogoInst = instance_create_layer(x, y, "Dialogo", Dialogo);
                if (variable_instance_exists(npc, "nome")) {
                    _dialogoInst.nomeNpc = npc.nome;
                } else {
                    _dialogoInst.nomeNpc = "";
                }
                global.dialogo = true; 
            }
        }
    }

  if (distance_to_object(ObjObstaculoQuiz) <= global.range) {
    var _instancia_perto = instance_nearest(x, y, ObjObstaculoQuiz);

    if (keyboard_check_pressed(ord("E")) && global.dialogo == false 
        && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        var _verbo_escolhido = "";
        
        if (variable_instance_exists(_instancia_perto, "meu_quiz_id")) {
            if (is_array(_instancia_perto.meu_quiz_id)) {
                if (!variable_instance_exists(_instancia_perto, "quiz_sorteado_fixo")) {
                    var _sorteio = irandom(array_length(_instancia_perto.meu_quiz_id) - 1);
                    _instancia_perto.quiz_sorteado_fixo = _instancia_perto.meu_quiz_id[_sorteio];
                }
                _verbo_escolhido = _instancia_perto.quiz_sorteado_fixo; 
            } else {
                _verbo_escolhido = _instancia_perto.meu_quiz_id; 
            }
        }
        
        var _q = instance_create_layer(0, 0, "interacao", obj_quiz);
        _q.quiz_id = _verbo_escolhido;
        _q.pergunta_id = _verbo_escolhido;
        
        global.dialogo = true;
        exit; // 🆕 impede qualquer outro código no mesmo frame
    }
}
}

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 12F0E123
/// @DnDArgument : "code" "// ================= TROCA DE SKIN =================$(13_10)if (variable_global_exists("player_char")) {$(13_10)    sprite_index = global.player_char;$(13_10)}$(13_10)$(13_10)var Skin1Key = keyboard_check_pressed(ord("1"));$(13_10)var Skin2Key = keyboard_check_pressed(ord("2"));$(13_10)$(13_10)if (Skin1Key) {$(13_10)    global.player_char = francine;$(13_10)} else if (Skin2Key) {$(13_10)    global.player_char = jacques;$(13_10)}"
// ================= TROCA DE SKIN =================
if (variable_global_exists("player_char")) {
    sprite_index = global.player_char;
}

var Skin1Key = keyboard_check_pressed(ord("1"));
var Skin2Key = keyboard_check_pressed(ord("2"));

if (Skin1Key) {
    global.player_char = francine;
} else if (Skin2Key) {
    global.player_char = jacques;
}