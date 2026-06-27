menu_texts = [
     "menu_iniciar",
     "menu_config",
     "menu_creditos",
     "menu_sair"
];

menu_enabled = [];
for (var i = 0; i < array_length(menu_texts); i++) {
    menu_enabled[i] = true;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

button_w = 400; // este valor define a largura visual da sua placa de madeira
button_h = 56;
button_spacing = 72;

menu_x = gui_w / 2;
menu_y = (gui_h / 2) - ((button_h * array_length(menu_texts)) / 2); 

selected_index = 0;

carregar_configuracoes();

draw_set_font(fnt_padrao);
show_debug_message("obj_menu criado.");