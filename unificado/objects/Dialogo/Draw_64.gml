var guiLargura = display_get_gui_width();
var guiAltura = display_get_gui_height()

var xx = 0;
var yy = guiAltura - 200;
var corPreta = c_black;

var textoAlarme = string_copy(texto[pagina], 0, caractere);

draw_rectangle_colour(xx, yy, guiLargura, guiAltura, corPreta, corPreta, corPreta, corPreta, false);
draw_text_ext(xx + 32, yy + 32, textoAlarme, 32, guiLargura - 64);
