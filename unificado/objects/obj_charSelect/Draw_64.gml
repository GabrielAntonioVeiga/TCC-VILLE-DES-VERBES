draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_text(gui_w/2, 100, "Selecione o Personagem");

var spacing = 300;
var start_x = gui_w/2 - (spacing/2);

for(var i=0; i<2; i++) {
    var cx = start_x + (i * spacing);
    var cy = gui_h/2;

    if (i == selected) {
        draw_set_color(c_yellow);
        draw_rectangle(cx - 80, cy - 120, cx + 80, cy + 120, true);
    }

    draw_sprite(chars[i], 0, cx, cy);
    
    if (i == selected) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }
    
    draw_text(cx, cy + 150, char_names[i]);
}

var voltar_y = gui_h - 100;
if (selected == 2) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}
draw_text(gui_w/2, voltar_y, "Voltar");
draw_set_color(c_white);
