var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var total_width = (slots * slot_w) + ((slots - 1) * spacing);
var base_x = (gui_w / 2) - (total_width / 2);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// TÍTULO
draw_set_color(c_white);
draw_text_transformed(gui_w/2, 100, "SELEÇÃO DE JOGO", 1.5, 1.5, 0);

// ==========================
// SLOTS
// ==========================
for (var i = 0; i < slots; i++) {

    var start_x = base_x + (i * (slot_w + spacing));
    var y_botoes = start_y + slot_h + 10;

    var existe = existe_save_slot(i);

    var txt = "Slot " + string(i+1) + (existe ? " - Ativo" : " - Vazio");
    draw_set_color(c_white);
    draw_text(start_x + slot_w/2, start_y - 30, txt);

    draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, true);

    if (existe) {

        // CARREGAR
        var hover = point_in_rectangle(mx, my, start_x, y_botoes, start_x + btn_w, y_botoes + btn_h);
        draw_set_color(hover ? make_color_rgb(70,140,200) : make_color_rgb(45,100,150));
        draw_rectangle(start_x, y_botoes, start_x + btn_w, y_botoes + btn_h, false);
        draw_set_color(c_white);
        draw_text(start_x + btn_w/2, y_botoes + btn_h/2, "CARREGAR");

        // APAGAR
        var ax1 = start_x + slot_w - btn_w;
        var ax2 = start_x + slot_w;
        var hover2 = point_in_rectangle(mx, my, ax1, y_botoes, ax2, y_botoes + btn_h);
        draw_set_color(hover2 ? make_color_rgb(220,80,70) : make_color_rgb(180,50,40));
        draw_rectangle(ax1, y_botoes, ax2, y_botoes + btn_h, false);
        draw_set_color(c_white);
        draw_text(start_x + slot_w - btn_w/2, y_botoes + btn_h/2, "APAGAR");

    } else {

        var nx1 = start_x + (slot_w/2) - 75;
        var nx2 = start_x + (slot_w/2) + 75;

        var hover3 = point_in_rectangle(mx, my, nx1, y_botoes, nx2, y_botoes + btn_h);
        draw_set_color(hover3 ? c_gray : c_dkgray);
        draw_rectangle(nx1, y_botoes, nx2, y_botoes + btn_h, false);
        draw_set_color(c_white);
        draw_text(start_x + slot_w/2, y_botoes + btn_h/2, "NOVO JOGO");
    }
}

// ==========================
// POPUP
// ==========================
if (confirm_mode) {

    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);

    var px = gui_w/2;
    var py = gui_h/2;

    draw_set_color(make_color_rgb(240,235,210));
    draw_rectangle(px - 220, py - 100, px + 220, py + 100, false);

    draw_set_color(c_black);
    draw_rectangle(px - 220, py - 100, px + 220, py + 100, true);

    draw_text(px, py - 30, "TEM CERTEZA QUE DESEJA APAGAR?");

    // SIM
    var sim = point_in_rectangle(mx, my, px - 160, py + 20, px - 20, py + 70);
    draw_set_color(sim ? make_color_rgb(70,140,200) : make_color_rgb(45,100,150));
    draw_rectangle(px - 160, py + 20, px - 20, py + 70, false);
    draw_set_color(c_white);
    draw_text(px - 90, py + 45, "SIM");

    // NÃO
    var nao = point_in_rectangle(mx, my, px + 20, py + 20, px + 160, py + 70);
    draw_set_color(nao ? make_color_rgb(220,80,70) : make_color_rgb(180,50,40));
    draw_rectangle(px + 20, py + 20, px + 160, py + 70, false);
    draw_set_color(c_white);
    draw_text(px + 90, py + 45, "NÃO");
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

// Cor com hover
draw_set_color(hover_voltar ? make_color_rgb(200,200,200) : make_color_rgb(120,120,120));
draw_rectangle(voltar_x1, voltar_y1, voltar_x2, voltar_y2, false);

// Texto
draw_set_color(c_white);
draw_text(gui_w/2, voltar_y1 + voltar_h/2, "VOLTAR");