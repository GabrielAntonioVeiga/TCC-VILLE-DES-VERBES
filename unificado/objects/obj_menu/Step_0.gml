var hover_index = -1;

for (var i = 0; i < array_length(menu_texts); i++)
{
    var btn_y = menu_y + i * button_spacing;

    var left = menu_x - button_w/2;
    var right = menu_x + button_w/2;

    var top = btn_y - button_h/2;
    var bottom = btn_y + button_h/2;

    if (mouse_x > left && mouse_x < right && mouse_y > top && mouse_y < bottom)
    {
        hover_index = i;
        break;
    }
}

if (hover_index != -1)
{
    selected_index = hover_index;
}