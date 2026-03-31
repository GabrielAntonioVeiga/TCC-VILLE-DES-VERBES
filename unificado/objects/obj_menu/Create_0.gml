/// obj_menu - Create
// Texto do menu (em Português)
//window_set_size(900,900); //gambiarra
menu_texts = [
    "Jogar",
    "Configurações",
    "Créditos",
    "Sair"
];

// Estado (habilitado / desabilitado)
menu_enabled = [];
for (var i = 0; i < array_length(menu_texts); i++) {
    menu_enabled[i] = true;
}

// posições / estilo
/*isso aqui vai defirir a resposividade do jogo... vulgo é possivel dar ruim*/
button_w = 520;
button_h = 56;
menu_x = display_get_width() / 2 - button_w/2;
menu_y = display_get_height()/2 - (button_h * array_length(menu_texts));
button_spacing = 72;
selected_index = 0;

// input
/*
input_cooldown = 0.12;
input_timer = 0;
*/


// Fonte (use a sua fonte se tiver). Se não tiver, usa fonte padrão.
/*

if (asset_get_index("fnt_menu") != -1) {
    menu_font = fnt_padrao;
} else {
    menu_font = -1;
}
*/
draw_set_font(fnt_padrao); //isso aqui tá meio gambiarra, mas como foi setado no começo, o jogo inteiro mudou d fonte


// debug
show_debug_message("obj_menu criado.");