if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter)) {
    global.dialogo = false;
    instance_destroy();
}
