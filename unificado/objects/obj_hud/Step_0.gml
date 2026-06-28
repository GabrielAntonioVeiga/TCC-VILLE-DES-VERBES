var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();


var _sala_agora = room_get_name(room);
if (_sala_agora != _sala_anterior) {
    _sala_anterior = _sala_agora;
    missao_timer = room_speed * 10;
}


if (missao_timer > 0) {
    missao_timer--;
    mission_open = true;
    if (missao_timer <= 0) {
        mission_open = false;
    }
}

// 🆕 FEATURE 3 — Tick do flash
if (flash_timer > 0) flash_timer--;
if (flash_timer <= 0) flash_botao = -1;

// ══════════════════════════════════════════

if (state == "closed") {
    
    var _sala_atual = room_get_name(room);
    
    if (!variable_global_exists("ambiente_completado")) global.ambiente_completado = {};
    if (!variable_global_exists("objetivo_ambiente"))   global.objetivo_ambiente = "";
    if (!variable_global_exists("quadros_coletados"))   global.quadros_coletados = {};
    
    var _nome_da_sala_formatado = "Ambiente";
    
    if (variable_instance_exists(id, "lista_quadros")) {
        for (var i = 0; i < array_length(lista_quadros); i++) {
            if (lista_quadros[i].sala_id == _sala_atual) {
                _nome_da_sala_formatado = lista_quadros[i].nome;
                break;
            }
        }
    }
    
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
                
                if (_movel_concluido) _quizzes_respondidos++;
            }
            
            if (_quizzes_respondidos >= _total_quizzes_sala) {
                global.ambiente_completado[$ _sala_atual] = true;
                global.objetivo_ambiente = "Exploração da " + _nome_da_sala_formatado + ": 100% Concluída!";
                
                if (!variable_struct_exists(global.quadros_coletados, _sala_atual)
                    || global.quadros_coletados[$ _sala_atual] == false) {
                    global.quadros_coletados[$ _sala_atual] = true;
                    var _popup = instance_create_depth(0, 0, -9999, obj_popup_quadro);
                    _popup.sala_id = _sala_atual;
                    
                    // 🆕 Flash no botão Álbum ao ganhar quadro
                    flash_botao = 1;
                    flash_timer = room_speed * 3;
                }
            } 
            else {
                global.objetivo_ambiente = "Exploração da " + _nome_da_sala_formatado + ": " 
                    + string(_quizzes_respondidos) + "/" + string(_total_quizzes_sala) + " móveis.";
            }
        }
    }
    
    // ── Botões da HUD ──
    var btn_w = 120;
    var start_y = (gui_h / 2) - ((array_length(hud_buttons) * 50) / 2);
    
    if (global.dialogo == true && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        if (!variable_global_exists("dialog_lock") || !global.dialog_lock) {
            global.dialogo = false;
        }
    }
    
    var clicked_any = false;

    if (mouse_check_button_pressed(mb_left)) {
        if (global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
            for (var i = 0; i < array_length(hud_buttons); i++) {
                var by = start_y + (i * 50);
                if (mx > gui_w - btn_w && mx < gui_w && my > by - 20 && my < by + 20) {
                    clicked_any = true;
                    switch(i) {
                        case 0: // Missão
                            mission_open = !mission_open;
                            missao_timer = 0; // cancela timer ao clicar manualmente
                            break;
                        case 1: // Álbum
                            state = "album";
                            global.dialogo = true;
                            mission_open = false;
                            missao_timer = 0;
                            break;
                        case 2: // Notas
                            state = "notes";
                            global.dialogo = true;
                            mission_open = false;
                            missao_timer = 0;
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