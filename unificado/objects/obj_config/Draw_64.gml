draw_set_halign(fa_center);
draw_set_color(c_white);

var gui_w = display_get_gui_width();

draw_text(gui_w/2, 100, "CONFIGURAÇÕES");
draw_text(gui_w/2, 200 + (array_length(options)+1)*60, "Volume: " + string(global.volume));

for(var i = 0; i < array_length(options); i++)
{
    if i == selected
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);

    draw_text(gui_w/2, 200 + i * 60, options[i]);
}
