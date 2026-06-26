var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var raw_click = mouse_check_button_pressed(mb_left);
var click = raw_click && !click_lock;

if (mouse_check_button_released(mb_left)) {
    click_lock = false;
}
if (click) {
    click_lock = true;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var total_width = (slots * slot_w) + ((slots - 1) * spacing);
var base_x = (gui_w / 2) - (total_width / 2);

var hovering = false;

// ==========================
// POPUP
// ==========================
if (confirm_mode) {
    var px = gui_w / 2;
    var py = gui_h / 2;

    var sim = point_in_rectangle(mx, my, px - 160, py + 20, px - 20, py + 70);
    var nao = point_in_rectangle(mx, my, px + 20, py + 20, px + 160, py + 70);

    if (sim || nao) hovering = true;

    if (click) {
        if (sim) {
            apagar_save_slot(delete_target);
            slot_playtime[delete_target] = "00:00:00";
            confirm_mode = false;
            delete_target = -1;
            exit;
        }

        if (nao) {
            confirm_mode = false;
            delete_target = -1;
            exit;
        }
    }

    window_set_cursor(hovering ? cr_handpoint : cr_default);
    exit;
}

// ==========================
// SLOTS
// ==========================
for (var i = 0; i < slots; i++) {

    var start_x = base_x + (i * (slot_w + spacing));
    var y_botoes = start_y + slot_h + 10;

    if (existe_save_slot(i)) {

        // APAGAR
        var apagar_x1 = start_x + slot_w - btn_w;
        var apagar_x2 = start_x + slot_w;

        var hover_apagar = point_in_rectangle(mx, my, apagar_x1, y_botoes, apagar_x2, y_botoes + btn_h);

        if (hover_apagar) hovering = true;

        if (click && hover_apagar) {
            confirm_mode = true;
            delete_target = i;
            exit;
        }

        // CARREGAR
        var carregar_x1 = start_x;
        var carregar_x2 = start_x + btn_w;

        var hover_carregar = point_in_rectangle(mx, my, carregar_x1, y_botoes, carregar_x2, y_botoes + btn_h);

        if (hover_carregar) hovering = true;

        if (click && hover_carregar) {
            global.save_slot = i;
            carregar_jogo_slot(i);
            exit;
        }

    } else {

        // NOVO JOGO
        var novo_x1 = start_x + (slot_w/2) - 75;
        var novo_x2 = start_x + (slot_w/2) + 75;

        var hover_novo = point_in_rectangle(mx, my, novo_x1, y_botoes, novo_x2, y_botoes + btn_h);

        if (hover_novo) hovering = true;
if (click && hover_novo) {
    global.save_slot = i;
    // já existiam:
    global.pergunta_atual_id    = {}; 
    global.notas                = [];
    global.quizzes_concluidos   = {};
    global.portas_desbloqueadas = {};
    global.tempo_jogado         = 0;
    // 🆕 adiciona estas três:
    global.ambiente_completado  = {};
    global.status_missoes       = {};
    global.quadros_coletados    = {
        rm_jantar:        false,
        rm_atelie:        false,
        rm_corredor:      false,
        rm_lavanderia:    false,
        rm_banheiro:      false,
        rm_quarto:        false,
        missao_angelique: false
    };
    room_goto(rm_cutscene);
    exit;
}
    }
}

/// ==========================
/// BOTÃO VOLTAR
/// ==========================
var voltar_w = 180;
var voltar_h = 50;

var voltar_x1 = gui_w/2 - voltar_w/2;
var voltar_y1 = start_y + slot_h + 100;

var voltar_x2 = voltar_x1 + voltar_w;
var voltar_y2 = voltar_y1 + voltar_h;

var hover_voltar = point_in_rectangle(mx, my, voltar_x1, voltar_y1, voltar_x2, voltar_y2);

if (hover_voltar) hovering = true;

if (click && hover_voltar) {
    room_goto(rm_menu); // volta pro menu principal
    exit;
}