var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (state == "closed") {
    
    var _sala_atual = room_get_name(room);
    
    // Inicializa as globais se elas não existirem
    if (!variable_global_exists("ambiente_completado")) global.ambiente_completado = {};
    if (!variable_global_exists("objetivo_ambiente")) global.objetivo_ambiente = "";
    if (!variable_global_exists("quadros_coletados")) global.quadros_coletados = {};
    
    var _nome_da_sala_formatado = "Ambiente";
    
    if (variable_instance_exists(id, "lista_quadros")) {
        for (var i = 0; i < array_length(lista_quadros); i++) {
            if (lista_quadros[i].sala_id == _sala_atual) {
                _nome_da_sala_formatado = lista_quadros[i].nome;
                break;
            }
        }
    }
    
    // Verifica se a sala já foi 100% completada
    if (variable_struct_exists(global.ambiente_completado, _sala_atual) 
        && global.ambiente_completado[$ _sala_atual] == true) {
        global.objetivo_ambiente = "Exploração da " + _nome_da_sala_formatado + ": 100% Concluída!";
    } 
    else {
        var _total_quizzes_sala = instance_number(ObjObstaculoQuiz);
        
        if (_total_quizzes_sala > 0 && variable_global_exists("quizzes_concluidos")) {
            var _quizzes_respondidos = 0;
            
            for (var i = 0; i < _total_quizzes_sala; i++) {
                var _inst_quiz = instance_find(ObjObstaculoQuiz, i);
                var _movel_concluido = false;
                
                if (variable_instance_exists(_inst_quiz, "meu_quiz_id")) {
                    
                    if (is_array(_inst_quiz.meu_quiz_id)) {
                        for (var v = 0; v < array_length(_inst_quiz.meu_quiz_id); v++) {
                            var _verbo = _inst_quiz.meu_quiz_id[v];
                            if (variable_struct_exists(global.quizzes_concluidos, _verbo) 
                                && global.quizzes_concluidos[$ _verbo] == true) {
                                _movel_concluido = true;
                                break;
                            }
                        }
                    } 
                    else {
                        var _qid = _inst_quiz.meu_quiz_id;
                        if (variable_struct_exists(global.quizzes_concluidos, _qid) 
                            && global.quizzes_concluidos[$ _qid] == true) {
                            _movel_concluido = true;
                        }
                    }
                }
                
                if (_movel_concluido) {
                    _quizzes_respondidos++;
                }
            }
            
            if (_quizzes_respondidos >= _total_quizzes_sala) {
                global.ambiente_completado[$ _sala_atual] = true;
                global.objetivo_ambiente = "Exploração da " + _nome_da_sala_formatado + ": 100% Concluída!";
                
                if (!variable_struct_exists(global.quadros_coletados, _sala_atual)
                    || global.quadros_coletados[$ _sala_atual] == false) {
                    global.quadros_coletados[$ _sala_atual] = true;
                    var _popup = instance_create_depth(0, 0, -9999, obj_popup_quadro);
                    _popup.sala_id = _sala_atual;
                }
            } 
            else {
                global.objetivo_ambiente = "Exploração da " + _nome_da_sala_formatado + ": " 
                    + string(_quizzes_respondidos) + "/" + string(_total_quizzes_sala) + " móveis.";
            }
            
        } // fecha: if (_total_quizzes_sala > 0)
    } // fecha: else do ambiente_completado
    
    // ── Botões da HUD ──
    var btn_w = 120;
    var start_y = (gui_h / 2) - ((array_length(hud_buttons) * 50) / 2);
    
    // Libera jogador se não há janelas abertas
    if (global.dialogo == true && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        if (!variable_global_exists("dialog_lock") || !global.dialog_lock) {
            global.dialogo = false;
        }
    }
    
    var clicked_any = false;

    if (mouse_check_button_pressed(mb_left)) {
        
        // 🆕 Só processa cliques da HUD se não tiver diálogo/quiz aberto
        if (global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
            
            for (var i = 0; i < array_length(hud_buttons); i++) {
                var by = start_y + (i * 50);
                
                if (mx > gui_w - btn_w && mx < gui_w && my > by - 20 && my < by + 20) {
                    
                    clicked_any = true;
                   
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
                            salvar_jogo_temp(global.save_slot);
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
            
            if (clicked_any) {
                audio_play_sound(snd_menu_select, 1, false);
            }
        }
    }

} else {
    // Botão Voltar dos overlays (Álbum / Notas)
    var voltar_y = gui_h - 100;
    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_escape)) {
        var btn_hit = (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 
                       && my > voltar_y - 20 && my < voltar_y + 20);
        if (btn_hit || keyboard_check_pressed(vk_escape)) {
            state = "closed";
            global.dialogo = false;
        }
    }
}