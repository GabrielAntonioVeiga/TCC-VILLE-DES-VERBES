var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gui_w = display_get_gui_width();

if (confirm_mode) {
    if (keyboard_check_pressed(vk_escape)) {
        confirm_mode = false;
        delete_target = -1;
    }
    if (keyboard_check_pressed(vk_enter)) {
        apagar_save_slot(delete_target);
        confirm_mode = false;
        delete_target = -1;
    }
} else {
    // Detecçao do Hitbox do mouse pelas palavras no Draw_64
    var hovered_index = -1;
    for (var i = 0; i <= slots; i++) {
        var btn_y = 200 + i * 60;
        // Caixa de colisão baseada na largura de 300 e altura 40
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

    selected = clamp(selected,0,slots);

    // Deletar um save - Confirmação (2 etapas)
    if (keyboard_check_pressed(vk_delete) || (hovered_index != -1 && mouse_check_button_pressed(mb_right))) {
        if (selected < slots && file_exists("save"+string(selected)+".sav")) {
            confirm_mode = true;
            delete_target = selected;
        }
    }

    // Ação Confirmar slot / Voltar
    if keyboard_check_pressed(vk_enter) || (hovered_index != -1 && mouse_check_button_pressed(mb_left))
    {
        if selected < slots
        {
            global.save_slot = selected;
            // Se o save existir, executa o método para setar dados, carregar e saltar pro Room 
            if (file_exists("save"+string(selected)+".sav")) {
                carregar_jogo_slot(selected);
            } else {
                room_goto(rm_CharacterSelection);
            }
        }
        else
        {
            room_goto(rm_menu);
        }
    }
}