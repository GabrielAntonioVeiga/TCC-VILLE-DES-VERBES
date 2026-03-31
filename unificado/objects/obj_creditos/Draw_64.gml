draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var btn_x = display_get_width()/2;
var btn_y = display_get_height()/2;

draw_set_color(c_white);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_text(gui_w/2, gui_h/2 - 50, credits_text);

var voltar_y = gui_h - 100;
if (hover_voltar) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}
draw_text(gui_w/2, voltar_y, "Voltar");
draw_set_color(c_white);