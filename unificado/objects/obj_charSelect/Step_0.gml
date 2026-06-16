var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var spacing = 300;
var start_x = gui_w/2 - (spacing/2);
var hovered_index = -1;

// Mapeando a hitboxes do Char
for(var i=0; i<2; i++) {
    var cx = start_x + (i * spacing);
    var cy = gui_h/2;

    if (mx > cx - 80 && mx < cx + 80 && my > cy - 120 && my < cy + 120) {
        hovered_index = i;
        break;
    }
}

// Mapeando do botão voltar
var voltar_y = gui_h - 100;
if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && 
    my > voltar_y - 20 && my < voltar_y + 20) {
    hovered_index = 2;
}

if (hovered_index != -1) {
    selected = hovered_index;
}

if (keyboard_check_pressed(vk_left)) selected--;
if (keyboard_check_pressed(vk_right)) selected++;
if (keyboard_check_pressed(vk_down)) selected = 2;
if (keyboard_check_pressed(vk_up) && selected == 2) selected = 0;

selected = clamp(selected, 0, 2);

if (keyboard_check_pressed(vk_enter)) || (keyboard_check_pressed(vk_space)) || (hovered_index != -1 && mouse_check_button_pressed(mb_left)) {
    if (selected == 2) {
        room_goto(rm_menu);
    } else {
        global.player_char = chars[selected];
        room_goto(rm_jantar);
    }
}
