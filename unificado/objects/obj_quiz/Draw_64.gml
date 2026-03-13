/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 54968FC8
/// @DnDArgument : "code" "$(13_10)var centro_x = display_get_gui_width() / 2;$(13_10)var centro_y = display_get_gui_height() / 2;$(13_10)$(13_10)$(13_10)draw_set_color(c_black);$(13_10)draw_set_alpha(0.8);$(13_10)draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);$(13_10)draw_set_alpha(1);$(13_10)$(13_10)$(13_10)var met_largura = 350; $(13_10)var met_altura = 250;  $(13_10)draw_set_color(make_color_rgb(30, 30, 30)); $(13_10)draw_rectangle(centro_x - met_largura, centro_y - met_altura, centro_x + met_largura, centro_y + met_altura, false);$(13_10)draw_set_color(c_white);$(13_10)draw_rectangle(centro_x - met_largura, centro_y - met_altura, centro_x + met_largura, centro_y + met_altura, true); // Borda branca$(13_10)$(13_10)$(13_10)draw_set_halign(fa_center);$(13_10)draw_set_valign(fa_middle);$(13_10)$(13_10)$(13_10)if (estado == "perguntando") {$(13_10)    $(13_10)   $(13_10)    draw_set_color(c_yellow);$(13_10)    draw_text(centro_x, centro_y - 140, "Temps du Verbe: " + tempo_verbal);$(13_10)    $(13_10)  $(13_10)    draw_set_color(c_white);$(13_10)    var texto_desenhado = string_copy(pergunta, 1, caractere);$(13_10)    draw_text(centro_x, centro_y - 80, texto_desenhado);$(13_10)    $(13_10)  $(13_10)    if (caractere >= string_length(pergunta)) {$(13_10)        $(13_10)       $(13_10)        for (var i = 0; i < array_length(opcoes); i++) {$(13_10)            var texto_opcao = opcoes[i];$(13_10)            var op_y = centro_y + (i * 40);$(13_10)            $(13_10)            if (i == opcao_selecionada) {$(13_10)                draw_set_color(c_yellow);$(13_10)                texto_opcao = "> " + texto_opcao + " <"; $(13_10)            } else {$(13_10)                draw_set_color(c_white);$(13_10)            }$(13_10)            draw_text(centro_x, op_y, texto_opcao);$(13_10)        }$(13_10)        $(13_10)      $(13_10)        var btn_des_x1 = centro_x - 160, btn_des_y1 = centro_y + 160, btn_des_x2 = centro_x - 10, btn_des_y2 = centro_y + 200;$(13_10)        var btn_conf_x1 = centro_x + 10, btn_conf_y1 = centro_y + 160, btn_conf_x2 = centro_x + 160, btn_conf_y2 = centro_y + 200;$(13_10)        $(13_10)       $(13_10)        draw_set_color(make_color_rgb(200, 50, 50)); $(13_10)        draw_rectangle(btn_des_x1, btn_des_y1, btn_des_x2, btn_des_y2, false);$(13_10)        draw_set_color(c_white);$(13_10)        draw_rectangle(btn_des_x1, btn_des_y1, btn_des_x2, btn_des_y2, true); $(13_10)        draw_text((btn_des_x1 + btn_des_x2) / 2, (btn_des_y1 + btn_des_y2) / 2, "Abandonner");$(13_10)$(13_10)       $(13_10)        draw_set_color(make_color_rgb(50, 200, 50)); $(13_10)        draw_rectangle(btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2, false);$(13_10)        draw_set_color(c_white);$(13_10)        draw_rectangle(btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2, true); $(13_10)        $(13_10)        draw_set_color(c_black); $(13_10)        draw_text((btn_conf_x1 + btn_conf_x2) / 2, (btn_conf_y1 + btn_conf_y2) / 2, "Confirmer");$(13_10)    }$(13_10)    $(13_10)} $(13_10)$(13_10)else if (estado == "feedback") {$(13_10)    $(13_10)$(13_10)    if (opcao_selecionada == resposta_correta) draw_set_color(c_lime);$(13_10)    else draw_set_color(c_red);$(13_10)    $(13_10)$(13_10)    var texto_desenhado = string_copy(mensagem_feedback, 1, caractere);$(13_10)    draw_text(centro_x, centro_y, texto_desenhado);$(13_10)    $(13_10)$(13_10)    if (caractere >= string_length(mensagem_feedback)) {$(13_10)        draw_set_color(c_white);$(13_10)        draw_text(centro_x, centro_y + 100, "Clique na tela ou pressione [E] para continuar");$(13_10)    }$(13_10)}$(13_10)$(13_10)$(13_10)draw_set_halign(fa_left);$(13_10)draw_set_valign(fa_top);"

var centro_x = display_get_gui_width() / 2;
var centro_y = display_get_gui_height() / 2;


draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);


var met_largura = 350; 
var met_altura = 250;  
draw_set_color(make_color_rgb(30, 30, 30)); 
draw_rectangle(centro_x - met_largura, centro_y - met_altura, centro_x + met_largura, centro_y + met_altura, false);
draw_set_color(c_white);
draw_rectangle(centro_x - met_largura, centro_y - met_altura, centro_x + met_largura, centro_y + met_altura, true); // Borda branca


draw_set_halign(fa_center);
draw_set_valign(fa_middle);


if (estado == "perguntando") {
    
   
    draw_set_color(c_yellow);
    draw_text(centro_x, centro_y - 140, "Temps du Verbe: " + tempo_verbal);
    
  
    draw_set_color(c_white);
    var texto_desenhado = string_copy(pergunta, 1, caractere);
    draw_text(centro_x, centro_y - 80, texto_desenhado);
    
  
    if (caractere >= string_length(pergunta)) {
        
       
        for (var i = 0; i < array_length(opcoes); i++) {
            var texto_opcao = opcoes[i];
            var op_y = centro_y + (i * 40);
            
            if (i == opcao_selecionada) {
                draw_set_color(c_yellow);
                texto_opcao = "> " + texto_opcao + " <"; 
            } else {
                draw_set_color(c_white);
            }
            draw_text(centro_x, op_y, texto_opcao);
        }
        
      
        var btn_des_x1 = centro_x - 160, btn_des_y1 = centro_y + 160, btn_des_x2 = centro_x - 10, btn_des_y2 = centro_y + 200;
        var btn_conf_x1 = centro_x + 10, btn_conf_y1 = centro_y + 160, btn_conf_x2 = centro_x + 160, btn_conf_y2 = centro_y + 200;
        
       
        draw_set_color(make_color_rgb(200, 50, 50)); 
        draw_rectangle(btn_des_x1, btn_des_y1, btn_des_x2, btn_des_y2, false);
        draw_set_color(c_white);
        draw_rectangle(btn_des_x1, btn_des_y1, btn_des_x2, btn_des_y2, true); 
        draw_text((btn_des_x1 + btn_des_x2) / 2, (btn_des_y1 + btn_des_y2) / 2, "Abandonner");

       
        draw_set_color(make_color_rgb(50, 200, 50)); 
        draw_rectangle(btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2, false);
        draw_set_color(c_white);
        draw_rectangle(btn_conf_x1, btn_conf_y1, btn_conf_x2, btn_conf_y2, true); 
        
        draw_set_color(c_black); 
        draw_text((btn_conf_x1 + btn_conf_x2) / 2, (btn_conf_y1 + btn_conf_y2) / 2, "Confirmer");
    }
    
} 

else if (estado == "feedback") {
    

    if (opcao_selecionada == resposta_correta) draw_set_color(c_lime);
    else draw_set_color(c_red);
    

    var texto_desenhado = string_copy(mensagem_feedback, 1, caractere);
    draw_text(centro_x, centro_y, texto_desenhado);
    

    if (caractere >= string_length(mensagem_feedback)) {
        draw_set_color(c_white);
        draw_text(centro_x, centro_y + 100, "Clique na tela ou pressione [E] para continuar");
    }
}


draw_set_halign(fa_left);
draw_set_valign(fa_top);