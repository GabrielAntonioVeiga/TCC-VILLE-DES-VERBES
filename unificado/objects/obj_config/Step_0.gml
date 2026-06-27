var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var gui_w = display_get_gui_width();

var hovered_index = -1;
for (var i = 0; i < array_length(options); i++) {
    var btn_y = 200 + i * 90;
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

var act_right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_enter);
var act_left = keyboard_check_pressed(vk_left);

if (hovered_index != -1 && mouse_check_button_pressed(mb_left)) {
    if (hovered_index <= 2) {
        if (mx > gui_w/2) act_right = true;
        else act_left = true;
    } else {
        act_right = true;
    }
}

if (act_right || act_left)
{
    var dir = act_right ? 1 : -1;
    switch(selected)
    {
        case 0: // Volume
            global.volume = clamp(global.volume + (0.1 * dir), 0, 1);
            audio_master_gain(global.volume);
            salvar_configuracoes();
        break;

        case 1: // Velocidade do Texto (1=Rapido, 2=Normal, 4=Lento)
            if (dir > 0) {
                if (global.text_speed == 1) global.text_speed = 2;
                else if (global.text_speed == 2) global.text_speed = 4;
                else global.text_speed = 1;
            } else {
                if (global.text_speed == 1) global.text_speed = 4;
                else if (global.text_speed == 2) global.text_speed = 1;
                else global.text_speed = 2;
            }
            salvar_configuracoes();
        break;

        case 2: // Idioma
            if (global.language == "pt") global.language = "fr";
            else global.language = "pt";
            salvar_configuracoes();
        break;

        case 3: // Tela cheia
            window_set_fullscreen(!window_get_fullscreen());
            global.fullscreen = window_get_fullscreen();
            salvar_configuracoes();
        break;

        case 4: // Voltar
            if (act_right) { // apenas se confirmou (enter ou click)
                if (variable_global_exists("previous_room") && global.previous_room != rm_config) {
                    room_goto(global.previous_room);
                } else {
                    room_goto(rm_menu);
                }
            }
        break;
    }
}