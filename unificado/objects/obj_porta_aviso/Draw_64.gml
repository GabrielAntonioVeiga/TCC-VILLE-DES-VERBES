var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var cx = gui_w/2;
var cy = gui_h/2;

draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, gui_w, gui_h, false); // Fundo escuro
draw_set_alpha(1);

draw_set_color(c_white);
draw_roundrect(cx - 300, cy - 150, cx + 300, cy + 150, false);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_text(cx, cy - 80, "PORTA TRANCADA!");
draw_set_color(c_black);
draw_text(cx, cy, "Voce precisa completar o objetivo da sala atual\npara prosseguir para o proximo nivel.");
draw_text(cx, cy + 80, "(Aperte ENTER ou clique para fechar)");
