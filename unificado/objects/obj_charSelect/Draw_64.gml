draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_text_transformed(gui_w/2, 100, obter_string("char_selection"), 2, 2, 0);

var spacing = 300;
var start_x = gui_w/2 - (spacing/2);

for(var i=0; i<2; i++) {
    var cx = start_x + (i * spacing);
    var cy = gui_h/2;
    
    // Posição base onde o sprite será desenhado
    var draw_x = cx - 80;
    var draw_y = cy - 120;
    var spr_w = sprite_get_width(chars[i]);
    var spr_h = sprite_get_height(chars[i]);
    if (i == selected) {
        draw_set_color(c_yellow);
        
        var padding = 15;   // Espaço extra (margem) entre o personagem e o retângulo
        var espessura = 4;  // Grossura da linha
        
        //Calcula as pontas do retângulo somando o padding
        var x1 = draw_x - padding;
        var y1 = draw_y - padding;
        var x2 = draw_x + spr_w + padding;
        var y2 = draw_y + spr_h + padding;
        
        for (var j = 0; j < espessura; j++) {
            // Expande o retângulo 1 pixel para fora a cada repetição
            draw_rectangle(x1 - j, y1 - j, x2 + j, y2 + j, true);
        }
    }

    // Desenha o personagem
    draw_sprite(chars[i], 0, draw_x, draw_y);
    
    if (i == selected) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }
    var centro_do_personagem = draw_x + (spr_w / 2);
    
    var escala_nome = 1.5; 
    draw_text_transformed(centro_do_personagem, cy + 200, char_names[i], escala_nome, escala_nome, 0);
}


var scale_x = 0.15;
var scale_y = 0.5;

var voltar_y = gui_h - 100;
var btn_color = c_white;

if (selected == 2) {
    draw_set_color(c_yellow);
    btn_color = c_gray;
} else {
    draw_set_color(c_white);
    btn_color = c_white;
}

var visual_w = sprite_get_height(botao) * scale_y;
var visual_h = sprite_get_width(botao) * scale_x;

var draw_x = (gui_w / 2) + (visual_w / 2);
var draw_y = voltar_y - (visual_h / 2);

draw_sprite_ext(botao, 0, draw_x, draw_y, scale_x, scale_y, 270, btn_color, 1);

draw_text(gui_w/2, voltar_y, obter_string("menu_sair"));
draw_set_color(c_white);