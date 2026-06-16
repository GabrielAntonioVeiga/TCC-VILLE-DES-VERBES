if (instance_exists(Player)) {
    if (distance_to_object(Player) < distancia_interacao) {
        if (keyboard_check_pressed(ord("E"))) {
            
            var can_transition = false;
            
            if (desbloqueada) {
                can_transition = true;
            } 
            else {
                if (missao_necessaria != "") {
                    
                    if (variable_global_exists("status_missoes") && variable_struct_exists(global.status_missoes, missao_necessaria)) {
                        if (global.status_missoes[$ missao_necessaria] == 2) {
                            can_transition = true;
                            desbloqueada = true;
                            global.portas_desbloqueadas[$ porta_id] = true;
                        }
                    }
                } else {
                    can_transition = true;
                }
            }
            
            if (can_transition) {
                var inst_trans = instance_create_depth(0, 0, -9999, obj_transicao);
                inst_trans.target_room = target_room;
                inst_trans.source_room = room;
                inst_trans.target_x = target_x;
                inst_trans.target_y = target_y;
                
                var snd = asset_get_index("snd_opening_door");
                if (snd != -1) audio_play_sound(snd, 1, false);
            } else {
                if (!instance_exists(obj_porta_aviso)) {
                    instance_create_depth(0, 0, -9999, obj_porta_aviso);
                }
            }
        }
    }
}