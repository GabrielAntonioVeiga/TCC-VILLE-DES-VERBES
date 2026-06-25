draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var btn_x = display_get_width()/2;
var btn_y = display_get_height()/2;

draw_set_color(c_white);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_text(gui_w/2, gui_h/2 - 50, credits_text);

/// ==========================
/// BOTÃO SAIR (PLACA DE MADEIRA)
/// ==========================
var voltar_y = gui_h - 100;
var scale_x = 0.15;
var scale_y = 0.5;
var btn_color = hover_voltar ? c_gray : c_white; // Escurece a madeira no hover
var visual_w = sprite_get_height(botao) * scale_y;
var visual_h = sprite_get_width(botao) * scale_x;
var draw_x = (gui_w / 2) + (visual_w / 2);
var draw_y = voltar_y - (visual_h / 2);
draw_sprite_ext(botao, 0, draw_x, draw_y, scale_x, scale_y, 270, btn_color, 1);
if (hover_voltar) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}
draw_text(gui_w/2, voltar_y, obter_string("menu_sair"));
draw_set_color(c_white);