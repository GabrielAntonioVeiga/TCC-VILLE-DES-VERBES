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
        if (variable_struct_exists(global.loaded_save, "personagem")) {
            global.player_char = global.loaded_save.personagem;
            sprite_index = global.player_char;
        }

        if (variable_struct_exists(global.loaded_save, "direcao")) {
            facing = global.loaded_save.direcao;
        }
        
        // Redireciona para a room salva se for diferente da atual
        if (variable_struct_exists(global.loaded_save, "cenario")) {
            var r_id = asset_get_index(global.loaded_save.cenario);
            if (r_id != -1 && r_id != room) {
                // Previne loop infinito: limpa loaded_save ANTES do room_goto
                global.loaded_save = -1;
                room_goto(r_id);
                exit;
            }
        }
        
        // Previne dele carregar infinitamente na proxima troca de room
        global.loaded_save = -1; 
    }
}

// ================= AJUSTE DE CAMERA E SALA =================
if (room == rm_jantar) {
    room_width = 2552;
    room_height = 1612;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1500, 1500);
}
else if (room == rm_atelie) {
    room_width = 2552;
    room_height = 1640;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1500, 1500);
}
else if (room == rm_corredor) {
    room_width = 790;
    room_height = 2200;
    
    view_enabled = true;
    view_visible[0] = true;
    // Aumenta a altura da view para permitir seguimento vertical mais cedo
    camera_set_view_size(view_camera[0], 768, 700);

    // Ajusta a escala do Player apenas no corredor (reduzido para não parecer gigante)
    image_xscale = 0.6;
    image_yscale = 0.8;
}
else if (room == rm_banheiro) {
    room_width = 1400;
    room_height = 1501;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1366, 768);
}
else if (room == rm_lavanderia) {
    room_width = 1400;
    room_height = 768;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1366, 768);
	

    image_xscale = 0.9;
    image_yscale = 0.95;    
} else if (room == rm_quarto) {
	room_width = 1400;
    room_height = 1501;
    
    view_enabled = true;
    view_visible[0] = true;
    camera_set_view_size(view_camera[0], 1400, 1088);
}

// Centraliza a câmera no player imediatamente ao entrar na room
var w_view = camera_get_view_width(view_camera[0]);
var h_view = camera_get_view_height(view_camera[0]);
var target_x = clamp(x - w_view / 2, 0, room_width - w_view);
var target_y = clamp(y - h_view / 2, 0, room_height - h_view);
camera_set_view_pos(view_camera[0], target_x, target_y);

// Restaura escala padrão do Player quando não estiver no corredor
if (room != rm_corredor && room != rm_lavanderia) {
    image_xscale = 1;
    image_yscale = 1.6153846;
}
