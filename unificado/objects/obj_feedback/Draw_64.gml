draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(alpha);

// Desenho da caixa (Retângulo preto com borda e alfa base no texto)
var txt_w = string_width(texto) + 40;
var txt_h = string_height(texto) + 20;
var box_x = gui_w - (txt_w / 2) - 20; 
var box_y = gui_h - 40;

draw_set_color(c_black);
draw_rectangle(box_x - (txt_w / 2), box_y - (txt_h / 2), box_x + (txt_w / 2), box_y + (txt_h / 2), false);

draw_set_color(c_white);
draw_rectangle(box_x - (txt_w / 2), box_y - (txt_h / 2), box_x + (txt_w / 2), box_y + (txt_h / 2), true);

draw_text(box_x, box_y, texto);

draw_set_alpha(1);
draw_set_color(c_white);
