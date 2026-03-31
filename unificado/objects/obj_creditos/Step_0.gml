var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var voltar_y = gui_h - 100;

hover_voltar = false;

if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && 
    my > voltar_y - 20 && my < voltar_y + 20) {
    hover_voltar = true;
}

if keyboard_check_pressed(vk_escape) || (hover_voltar && mouse_check_button_pressed(mb_left))
{
    room_goto(rm_menu);
}