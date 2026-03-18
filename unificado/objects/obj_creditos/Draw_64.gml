draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var btn_x = display_get_width()/2;
var btn_y = display_get_height()/2;

draw_set_color(c_white);

draw_text(x, y, credits_text);

draw_text(x, display_get_height()-40, "Pressione ESC ou clique para voltar");