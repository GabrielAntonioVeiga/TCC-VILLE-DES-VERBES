if (variable_global_exists("previous_room") && global.previous_room == room) {
    global.previous_room = -1;
    if (variable_global_exists("save_slot")) {
        carregar_jogo_temp(global.save_slot);
    }
}

if (variable_global_exists("loaded_save")) {
    if (global.loaded_save != -1) {
        x = global.loaded_save.posicaoX;
        y = global.loaded_save.posicaoY;
        
        // Puxa a sprite q de fato ele deve carregar (se existir a variavel no dict)
        if (variable_struct_exists(global.loaded_save, "avatar")) {
            global.player_char = global.loaded_save.avatar;
            sprite_index = global.player_char;
        }

        if (variable_struct_exists(global.loaded_save, "direcao")) {
            facing = global.loaded_save.direcao;
        }
        
        // Previne dele carregar infinitamente na proxima troca de room
        global.loaded_save = -1; 
    }
}

// ================= AJUSTE DE CAMERA E SALA =================
if (room == rm_dining) {
    room_width = 2552;
    room_height = 1612;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1500, 1500);
}
else if (room == rm_atelier) {
    room_width = 2552;
    room_height = 1640;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1500, 1500);
}

// Centraliza a câmera no player imediatamente ao entrar na room
var w_view = camera_get_view_width(view_camera[0]);
var h_view = camera_get_view_height(view_camera[0]);
var target_x = clamp(x - w_view / 2, 0, room_width - w_view);
var target_y = clamp(y - h_view / 2, 0, room_height - h_view);
camera_set_view_pos(view_camera[0], target_x, target_y);
