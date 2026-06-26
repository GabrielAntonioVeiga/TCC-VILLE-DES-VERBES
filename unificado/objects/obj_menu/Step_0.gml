var hover_index = -1;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(menu_texts); i++)
{
    var btn_y = menu_y + i * button_spacing;

    var left = menu_x - (button_w / 2);
    var right = menu_x + (button_w / 2);
    
    var top = btn_y - (button_h / 2);
    var bottom = btn_y + (button_h / 2);

    if (mx > left && mx < right && my > top && my < bottom)
    {
        hover_index = i;
        break;
    }
}

if (hover_index != -1)
{
    selected_index = hover_index;
}