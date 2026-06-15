draw_set_halign(fa_center);
draw_set_valign(fa_middle); // Adicionado para centralizar verticalmente de forma perfeita

var gui_w = display_get_gui_width();

// Desenhar Título do Menu
draw_set_color(c_white);
draw_text_transformed(gui_w/2, 100, obter_string("menu_config"), 2, 2, 0);

// Pegar as dimensões do sprite do botão
var spr_w = sprite_get_width(botao);
var spr_h = sprite_get_height(botao);

// Escalas do botão (separadas devido à rotação)
var scale_x = 0.2; // Controla a ALTURA visual (mantive o mesmo do menu principal)
var scale_y = 0.6;  // Controla a LARGURA visual (um pouco maior para caber as opções longas)

for(var i = 0; i < array_length(options); i++)
{
    var bx = gui_w/2;
    var by = 200 + i * 90; // Espaçamento vertical
    
    // Configurar as strings de idioma e velocidade
    var str_lang = (global.language == "pt") ? "Português" : "Français";
    var str_spd = (global.text_speed == 1) ? ((global.language == "pt") ? "Rápido" : "Rapide") : ((global.text_speed == 4) ? ((global.language == "pt") ? "Devagar" : "Lent") : ((global.language == "pt") ? "Normal" : "Normal"));
    
    // Configurar o texto de cada opção
    var option_text = "";
    if (i == 0)      option_text = obter_string("config_volume") + "      <   " + string(round(global.volume * 100)) + "%   >";
    else if (i == 1) option_text = obter_string("config_velocidade") + "      <   " + str_spd + "   >";
    else if (i == 2) option_text = obter_string("config_idioma") + "      <   " + str_lang + "   >";
    else if (i == 3) option_text = obter_string("config_telacheia");
    else if (i == 4) option_text = obter_string("config_voltar");

    // 1. Definir a cor baseada no estado da opção
    var btn_color = c_white;
    if (i == selected) {
        btn_color = make_color_rgb(255, 200, 220); // Rosa (padronizado com o menu principal)
    }

    // 2. Compensação matemática para o sprite rotacionado (origem top-left)
    var draw_x = bx + ((spr_h * scale_y) / 2); 
    var draw_y = by - ((spr_w * scale_x) / 2); 

    // Desenhar a placa de madeira (removi o alpha 0.6 para a madeira ficar sólida)
    draw_sprite_ext(botao, 0, draw_x, draw_y, scale_x, scale_y, 270, btn_color, 1);
    
    // 3. Desenhar o texto centralizado na placa
    draw_set_color(c_white); // Mantém o texto sempre branco
    draw_text(bx, by, option_text); // Desenha exatamente no 'by', sem o -10
}