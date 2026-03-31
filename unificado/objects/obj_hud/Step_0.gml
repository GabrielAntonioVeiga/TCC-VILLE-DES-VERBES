var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (state == "closed") {
    var btn_w = 120;
    var start_y = (gui_h / 2) - ((array_length(hud_buttons)*50) / 2);
    
    // Libera jogador se nao ha janelas (Dialogo ou quizzes tbm trancam)
    if (global.dialogo == true && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        if (!variable_global_exists("dialog_lock") || !global.dialog_lock) { // Caso ja n tenha flag maior
            global.dialogo = false;
        }
    }

    if (mouse_check_button_pressed(mb_left)) {
        for(var i=0; i<array_length(hud_buttons); i++) {
            var by = start_y + (i * 50);
            
            // Intersecção Simples Botão HUD Lateral Ajustada para Margem Direito
            if (mx > gui_w - btn_w && mx < gui_w && my > by - 20 && my < by + 20) {
                switch(i) {
                    case 0: // Missão
                        mission_open = !mission_open;
                        break;
                    case 1: // Álbum
                        state = "album";
                        global.dialogo = true;
                        mission_open = false;
                        break;
                    case 2: // Notas
                        state = "notes";
                        global.dialogo = true;
                        mission_open = false;
                        break;
                    case 3: // Configurações
                        global.previous_room = room; 
                        room_goto(rm_config);
                        break;
                    case 4: // Salvar
                        salvar_jogo_slot(global.save_slot);
                        break;
                    case 5: // Sair ao menu Principal
                        room_goto(rm_menu);
                        break;
                }
            }
        }
    }
} else {
    // Intersecção do Botão Voltar dos Overlays
    var voltar_y = gui_h - 100;
    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_escape)) {
        var btn_hit = (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && my > voltar_y - 20 && my < voltar_y + 20);
        if (btn_hit || keyboard_check_pressed(vk_escape)) {
            state = "closed";
            global.dialogo = false;
        }
    }
}
