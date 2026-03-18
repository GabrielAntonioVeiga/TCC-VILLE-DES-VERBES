draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(menu_texts); i++)
{
    var btn_x = menu_x;
    var btn_y = menu_y + i * button_spacing;

    var selected = (i == selected_index);

    if (!menu_enabled[i])
        draw_set_color(c_gray);
    else if (selected)
        draw_set_color(make_color_rgb(255,200,220));
    else
        draw_set_color(c_white);

    draw_rectangle(
        btn_x - button_w/2,
        btn_y - button_h/2,
        btn_x + button_w/2,
        btn_y + button_h/2,
        false
    );

    draw_set_color(c_black);
    draw_rectangle(
        btn_x - button_w/2,
        btn_y - button_h/2,
        btn_x + button_w/2,
        btn_y + button_h/2,
        true
    );

    draw_text(btn_x, btn_y, menu_texts[i]);
}