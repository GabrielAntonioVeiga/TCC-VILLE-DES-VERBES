/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 61EB7522
/// @DnDArgument : "code" "// 1. Inicializa o efeito de máquina de escrever$(13_10)if (inicializar == false) {$(13_10)    inicializar = true;$(13_10)    alarm[0] = 1;$(13_10)}$(13_10)$(13_10)// 2. Coordenadas do mouse e da tela $(13_10)var mx = device_mouse_x_to_gui(0);$(13_10)var my = device_mouse_y_to_gui(0);$(13_10)var centro_x = display_get_gui_width() / 2;$(13_10)var centro_y = display_get_gui_height() / 2;$(13_10)$(13_10)// 3. Lógica principal do Quiz$(13_10)if (estado == "perguntando") {$(13_10)    $(13_10)    // --- ATALHOS DE TECLADO ---$(13_10)    if (keyboard_check_pressed(vk_escape)) {$(13_10)        global.dialogo = false;$(13_10)        instance_destroy();$(13_10)        exit;$(13_10)    }$(13_10)$(13_10)    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {$(13_10)        opcao_selecionada--;$(13_10)        if (opcao_selecionada < 0) opcao_selecionada = array_length(opcoes) - 1;$(13_10)    }$(13_10)    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {$(13_10)        opcao_selecionada++;$(13_10)        if (opcao_selecionada >= array_length(opcoes)) opcao_selecionada = 0;$(13_10)    }$(13_10)$(13_10)    // --- CLIQUE NAS OPÇÕES (TEXTO) ---$(13_10)    if (caractere >= string_length(pergunta)) {$(13_10)        for (var i = 0; i < array_length(opcoes); i++) {$(13_10)            var op_y = centro_y + (i * 40);$(13_10)            if (point_in_rectangle(mx, my, centro_x - 120, op_y - 15, centro_x + 120, op_y + 15)) {$(13_10)                // Checa o clique diretamente aqui$(13_10)                if (mouse_check_button_pressed(mb_left)) {$(13_10)                    opcao_selecionada = i;$(13_10)                }$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)$(13_10)    // --- ÁREAS DOS BOTÕES ---$(13_10)    var btn_des_x1 = centro_x - 160, btn_des_y1 = centro_y + 160, btn_des_x2 = centro_x - 10, btn_des_y2 = centro_y + 200;$(13_10)    var btn_conf_x1 = centro_x + 10, btn_conf_y1 = centro_y + 160, btn_conf_x2 = centro_x + 160, btn_conf_y2 = centro_y + 200;$(13_10)$(13_10)    // Checa o clique e a área ao mesmo tempo$(13_10)    var clicou_desistir = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_des_x1, btn_des_y1, btn_des_x2, btn_des_y2);$(13_10)    var clicou_confirmar = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2);$(13_10)$(13_10)    // --- AÇÕES DOS BOTÕES ---$(13_10)    if (clicou_confirmar || keyboard_check_pressed(ord("E"))) {$(13_10)        if (caractere < string_length(pergunta)) {$(13_10)            caractere = string_length(pergunta); $(13_10)        } else {$(13_10)            estado = "feedback";$(13_10)            caractere = 0; $(13_10)            if (opcao_selecionada == resposta_correta) {$(13_10)                mensagem_feedback = "Tres bien! Você acertou!";$(13_10)            } else {$(13_10)                mensagem_feedback = "Incorreto!\nA resposta certa era: " + opcoes[resposta_correta];$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)$(13_10)    if (clicou_desistir) {$(13_10)        global.dialogo = false;$(13_10)        instance_destroy();$(13_10)        exit;$(13_10)    }$(13_10)    $(13_10)} else if (estado == "feedback") {$(13_10)$(13_10)    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"))) {$(13_10)        if (caractere < string_length(mensagem_feedback)) {$(13_10)            caractere = string_length(mensagem_feedback);$(13_10)        } else {$(13_10)            global.dialogo = false;$(13_10)            instance_destroy();$(13_10)            io_clear();$(13_10)        }$(13_10)    }$(13_10)}"
// 1. Inicializa o efeito de máquina de escrever
if (inicializar == false) {
    inicializar = true;
    alarm[0] = 1;
}

// 2. Coordenadas do mouse e da tela 
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var centro_x = display_get_gui_width() / 2;
var centro_y = display_get_gui_height() / 2;

// 3. Lógica principal do Quiz
if (estado == "perguntando") {
    
    // --- ATALHOS DE TECLADO ---
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

    // --- CLIQUE NAS OPÇÕES (TEXTO) ---
    if (caractere >= string_length(pergunta)) {
        for (var i = 0; i < array_length(opcoes); i++) {
            var op_y = centro_y + (i * 40);
            if (point_in_rectangle(mx, my, centro_x - 120, op_y - 15, centro_x + 120, op_y + 15)) {
                // Checa o clique diretamente aqui
                if (mouse_check_button_pressed(mb_left)) {
                    opcao_selecionada = i;
                }
            }
        }
    }

    // --- ÁREAS DOS BOTÕES ---
    var btn_des_x1 = centro_x - 160, btn_des_y1 = centro_y + 160, btn_des_x2 = centro_x - 10, btn_des_y2 = centro_y + 200;
    var btn_conf_x1 = centro_x + 10, btn_conf_y1 = centro_y + 160, btn_conf_x2 = centro_x + 160, btn_conf_y2 = centro_y + 200;

    // Checa o clique e a área ao mesmo tempo
    var clicou_desistir = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_des_x1, btn_des_y1, btn_des_x2, btn_des_y2);
    var clicou_confirmar = mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2);

    // --- AÇÕES DOS BOTÕES ---
    if (clicou_confirmar || keyboard_check_pressed(ord("E"))) {
        if (caractere < string_length(pergunta)) {
            caractere = string_length(pergunta); 
        } else {
            estado = "feedback";
            caractere = 0; 
            if (opcao_selecionada == resposta_correta) {
                mensagem_feedback = "Tres bien! Você acertou!";
            } else {
                mensagem_feedback = "Incorreto!\nA resposta certa era: " + opcoes[resposta_correta];
            }
        }
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