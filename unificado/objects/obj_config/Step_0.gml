var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var gui_w = display_get_gui_width();

var hovered_index = -1;
for (var i = 0; i < array_length(options); i++) {
    var btn_y = 200 + i * 60;
    if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && 
        my > btn_y - 20 && my < btn_y + 20) {
        hovered_index = i;
        break;
    }
}

if (hovered_index != -1) {
    selected = hovered_index;
}

if keyboard_check_pressed(vk_up) selected--;
if keyboard_check_pressed(vk_down) selected++;

selected = clamp(selected,0,array_length(options)-1);

if keyboard_check_pressed(vk_enter) || (hovered_index != -1 && mouse_check_button_pressed(mb_left))
{
    switch(selected)
    {
        case 0:
            global.volume = min(global.volume+0.1,1);
        break;

        case 1:
            global.volume = max(global.volume-0.1,0);
        break;

        case 2:
            //window_set_fullscreen(!window_get_fullscreen());
        break;

        case 3:
            if (variable_global_exists("previous_room") && global.previous_room != rm_config) {
                room_goto(global.previous_room);
            } else {
                room_goto(rm_menu);
            }
        break;
    }
}