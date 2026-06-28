/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 61EB7522
/// @DnDArgument : "code" "if (inicializar == false) {$(13_10)    inicializar = true;$(13_10)    alarm[0] = 1;$(13_10)}$(13_10)$(13_10)// --- EFEITO MÁQUINA DE ESCREVER ---$(13_10)if (estado == "perguntando") {$(13_10)    if (caractere < string_length(pergunta)) {$(13_10)        caractere += 0.5;$(13_10)    }$(13_10)} else if (estado == "feedback") {$(13_10)    if (caractere < string_length(mensagem_feedback)) {$(13_10)        caractere += 0.5;$(13_10)    }$(13_10)}$(13_10)$(13_10)var mx       = device_mouse_x_to_gui(0);$(13_10)var my       = device_mouse_y_to_gui(0);$(13_10)var centro_x = display_get_gui_width()  / 2;$(13_10)var centro_y = display_get_gui_height() / 2;$(13_10)$(13_10)if (estado == "perguntando") {$(13_10)    $(13_10)    if (keyboard_check_pressed(vk_escape)) {$(13_10)        global.dialogo = false;$(13_10)        instance_destroy();$(13_10)        exit;$(13_10)    }$(13_10)$(13_10)    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {$(13_10)        opcao_selecionada--;$(13_10)        if (opcao_selecionada < 0) opcao_selecionada = array_length(opcoes) - 1;$(13_10)    }$(13_10)    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {$(13_10)        opcao_selecionada++;$(13_10)        if (opcao_selecionada >= array_length(opcoes)) opcao_selecionada = 0;$(13_10)    }$(13_10)$(13_10)    if (caractere >= string_length(pergunta)) {$(13_10)        for (var i = 0; i < array_length(opcoes); i++) {$(13_10)            var op_y = centro_y + (i * 40);$(13_10)            if (point_in_rectangle(mx, my, centro_x - 120, op_y - 15, centro_x + 120, op_y + 15)) {$(13_10)                if (mouse_check_button_pressed(mb_left)) {$(13_10)                    opcao_selecionada = i;$(13_10)                }$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)$(13_10)    var btn_des_x1  = centro_x - 160, btn_des_y1  = centro_y + 160, btn_des_x2  = centro_x - 10,  btn_des_y2  = centro_y + 200;$(13_10)    var btn_conf_x1 = centro_x + 10,  btn_conf_y1 = centro_y + 160, btn_conf_x2 = centro_x + 160, btn_conf_y2 = centro_y + 200;$(13_10)$(13_10)    var clicou_desistir  = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_des_x1,  btn_des_y1,  btn_des_x2,  btn_des_y2);$(13_10)    var clicou_confirmar = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2)$(13_10)                           && (array_length(opcoes) > 0) && (caractere >= string_length(pergunta));$(13_10)$(13_10)    if (clicou_confirmar) {$(13_10)        $(13_10)        if (opcao_selecionada == resposta_correta) {$(13_10)            $(13_10)            // Som de acerto$(13_10)            var snd = asset_get_index(snd_correct_answer_quizz);$(13_10)            if (snd != -1) audio_play_sound(snd, 1, false);$(13_10)            $(13_10)            mensagem_feedback = "Très bien! Você acertou!";$(13_10)            if (global.quizzes_concluidos[$ quiz_id] == undefined) {$(13_10)                global.acertos_gerais += 1; $(13_10)            }$(13_10)            $(13_10)            if (variable_instance_exists(id, "pergunta_id")) {$(13_10)                if (variable_struct_exists(global.pergunta_atual_id, pergunta_id)) {$(13_10)                    variable_struct_remove(global.pergunta_atual_id, pergunta_id);$(13_10)                }$(13_10)            }$(13_10)            $(13_10)            var _txt_res = "Resposta não encontrada";$(13_10)            if (opcao_selecionada >= 0 && opcao_selecionada < array_length(opcoes)) {$(13_10)                _txt_res = opcoes[opcao_selecionada];$(13_10)            }$(13_10)            $(13_10)            var _anotacao = "Quiz: "     + string(nome_quiz)    + "\n" +$(13_10)                            "Pergunta: " + string(pergunta)      + "\n" +$(13_10)                            "Tempo: "    + string(tempo_verbal)  + " | Verbo: " + string(verbo) + "\n" +$(13_10)                            "Resposta: " + string(_txt_res);$(13_10)            $(13_10)            array_push(global.notas, _anotacao);$(13_10)            global.quizzes_concluidos[$ quiz_id] = true;$(13_10)            $(13_10)            // 🆕 Flash botão Notas (índice 2) e abre painel missão por 3s$(13_10)            if (instance_exists(obj_hud)) {$(13_10)                obj_hud.flash_botao  = 2;$(13_10)                obj_hud.flash_timer  = room_speed * 3;$(13_10)                obj_hud.missao_timer = room_speed * 3;$(13_10)            }$(13_10)            $(13_10)        } else {$(13_10)            $(13_10)            // Som de erro$(13_10)            var snd = asset_get_index(snd_wrong_answer_quizz);$(13_10)            if (snd != -1) audio_play_sound(snd, 1, false);$(13_10)            $(13_10)            mensagem_feedback = "Incorreto! Tente novamente.";$(13_10)            global.erros_gerais += 1;$(13_10)            $(13_10)            if (variable_struct_exists(global.erros_quiz, quiz_id)) {$(13_10)                global.erros_quiz[$ quiz_id] += 1;$(13_10)            } else {$(13_10)                global.erros_quiz[$ quiz_id] = 1;$(13_10)            }$(13_10)        }$(13_10)        $(13_10)        estado    = "feedback";$(13_10)        caractere = 0;$(13_10)    }$(13_10)$(13_10)    if (clicou_desistir) {$(13_10)        global.dialogo = false;$(13_10)        instance_destroy();$(13_10)        exit;$(13_10)    }$(13_10)    $(13_10)} else if (estado == "feedback") {$(13_10)$(13_10)    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"))) {$(13_10)        if (caractere < string_length(mensagem_feedback)) {$(13_10)            caractere = string_length(mensagem_feedback);$(13_10)        } else {$(13_10)            global.dialogo = false;$(13_10)            instance_destroy();$(13_10)            io_clear();$(13_10)        }$(13_10)    }$(13_10)}"
if (inicializar == false) {
    inicializar = true;
    alarm[0] = 1;
}

// --- EFEITO MÁQUINA DE ESCREVER ---
if (estado == "perguntando") {
    if (caractere < string_length(pergunta)) {
        caractere += 0.5;
    }
} else if (estado == "feedback") {
    if (caractere < string_length(mensagem_feedback)) {
        caractere += 0.5;
    }
}

var mx       = device_mouse_x_to_gui(0);
var my       = device_mouse_y_to_gui(0);
var centro_x = display_get_gui_width()  / 2;
var centro_y = display_get_gui_height() / 2;

if (estado == "perguntando") {
    
    if (keyboard_check_pressed(vk_escape)) {
        global.dialogo = false;
        instance_destroy();
        exit;
    }

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        opcao_selecionada--;
        if (opcao_selecionada < 0) opcao_selecionada = array_length(opcoes) - 1;
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        opcao_selecionada++;
        if (opcao_selecionada >= array_length(opcoes)) opcao_selecionada = 0;
    }

    if (caractere >= string_length(pergunta)) {
        for (var i = 0; i < array_length(opcoes); i++) {
            var op_y = centro_y + (i * 40);
            if (point_in_rectangle(mx, my, centro_x - 120, op_y - 15, centro_x + 120, op_y + 15)) {
                if (mouse_check_button_pressed(mb_left)) {
                    opcao_selecionada = i;
                }
            }
        }
    }

    var btn_des_x1  = centro_x - 160, btn_des_y1  = centro_y + 160, btn_des_x2  = centro_x - 10,  btn_des_y2  = centro_y + 200;
    var btn_conf_x1 = centro_x + 10,  btn_conf_y1 = centro_y + 160, btn_conf_x2 = centro_x + 160, btn_conf_y2 = centro_y + 200;

    var clicou_desistir  = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_des_x1,  btn_des_y1,  btn_des_x2,  btn_des_y2);
    var clicou_confirmar = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2)
                           && (array_length(opcoes) > 0) && (caractere >= string_length(pergunta));

    if (clicou_confirmar) {
        
        if (opcao_selecionada == resposta_correta) {
            
            // Som de acerto
            var snd = asset_get_index(snd_correct_answer_quizz);
            if (snd != -1) audio_play_sound(snd, 1, false);
            
            mensagem_feedback = "Très bien! Você acertou!";
            if (global.quizzes_concluidos[$ quiz_id] == undefined) {
                global.acertos_gerais += 1; 
            }
            
            if (variable_instance_exists(id, "pergunta_id")) {
                if (variable_struct_exists(global.pergunta_atual_id, pergunta_id)) {
                    variable_struct_remove(global.pergunta_atual_id, pergunta_id);
                }
            }
            
            var _txt_res = "Resposta não encontrada";
            if (opcao_selecionada >= 0 && opcao_selecionada < array_length(opcoes)) {
                _txt_res = opcoes[opcao_selecionada];
            }
            
            var _anotacao = "Quiz: "     + string(nome_quiz)    + "\n" +
                            "Pergunta: " + string(pergunta)      + "\n" +
                            "Tempo: "    + string(tempo_verbal)  + " | Verbo: " + string(verbo) + "\n" +
                            "Resposta: " + string(_txt_res);
            
            array_push(global.notas, _anotacao);
            global.quizzes_concluidos[$ quiz_id] = true;
            
            // 🆕 Flash botão Notas (índice 2) e abre painel missão por 3s
            if (instance_exists(obj_hud)) {
                obj_hud.flash_botao  = 2;
                obj_hud.flash_timer  = room_speed * 3;
                obj_hud.missao_timer = room_speed * 3;
            }
            
        } else {
            
            // Som de erro
            var snd = asset_get_index(snd_wrong_answer_quizz);
            if (snd != -1) audio_play_sound(snd, 1, false);
            
            mensagem_feedback = "Incorreto! Tente novamente.";
            global.erros_gerais += 1;
            
            if (variable_struct_exists(global.erros_quiz, quiz_id)) {
                global.erros_quiz[$ quiz_id] += 1;
            } else {
                global.erros_quiz[$ quiz_id] = 1;
            }
        }
        
        estado    = "feedback";
        caractere = 0;
    }

    if (clicou_desistir) {
        global.dialogo = false;
        instance_destroy();
        exit;
    }
    
} else if (estado == "feedback") {

    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"))) {
        if (caractere < string_length(mensagem_feedback)) {
            caractere = string_length(mensagem_feedback);
        } else {
            global.dialogo = false;
            instance_destroy();
            io_clear();
        }
    }
}