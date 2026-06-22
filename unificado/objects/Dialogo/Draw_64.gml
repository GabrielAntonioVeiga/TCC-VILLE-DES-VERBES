var guiLargura = display_get_gui_width();
var guiAltura = display_get_gui_height();

var xx = 0;
var yy = guiAltura - 200;

var textoAlarme = string_copy(texto[pagina], 0, caractere);

draw_set_alpha(0.7); 
draw_rectangle_colour(xx, yy, guiLargura, guiAltura, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1.0); 

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text_ext(xx + 32, yy + 32, textoAlarme, 32, guiLargura - 64);

draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_color(c_yellow);

draw_text(guiLargura - 32, guiAltura - 16, "E ->");