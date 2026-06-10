// 0. Pegue as dimensões originais do sprite botao
var spr_w = sprite_get_width(botao);
var spr_h = sprite_get_height(botao);

// 1. Separamos as escalas. 
var scale_x = 0.15; // Controla a ALTURA na tela (reduzido pela metade)
var scale_y = 0.5;  // Controla a LARGURA na tela (mantido como estava)

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(menu_texts); i++)
{
    var btn_x = menu_x;
    var btn_y = menu_y + i * button_spacing;
    var selected = (i == selected_index);

    // Definir a cor baseada no estado do menu
    var btn_color = c_white;
    if (!menu_enabled[i]) {
        btn_color = c_gray;
    } else if (selected) {
        btn_color = make_color_rgb(255, 200, 220); // Rosa
    }

    // 2. A compensação matemática agora usa scale_x e scale_y
    var draw_x = btn_x + ((spr_h * scale_y) / 2); 
    var draw_y = btn_y - ((spr_w * scale_x) / 2); 

    // Desenha o sprite aplicando scale_x e scale_y separadamente
    draw_sprite_ext(botao, 0, draw_x, draw_y, scale_x, scale_y, 270, btn_color, 1);

    // 3. Desenhar o texto
    draw_set_color(c_white);
    draw_text(btn_x, btn_y, menu_texts[i]);
}