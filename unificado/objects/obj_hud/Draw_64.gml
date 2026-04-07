draw_set_font(fnt_padrao);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// ================= ESTADO BASE DA HUD (DIREITA) =================
if (state == "closed") {
    // 1. FUNDO DA BARRA DA HUD (RF015)
    var btn_w = 120;
    var start_y = (gui_h / 2) - ((array_length(hud_buttons)*50) / 2);
    
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(gui_w - btn_w, 0, gui_w, gui_h, false); // Tira da direita ao max
    draw_set_alpha(1.0);
    
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    // 2. DESENHA ATALHOS / BOTOES
    for(var i=0; i<array_length(hud_buttons); i++) {
        var by = start_y + (i * 50);
        
        // Cores no hover! (RNF)
        if (mx > gui_w - btn_w && mx < gui_w && my > by - 20 && my < by + 20) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }
        
        draw_text(gui_w - (btn_w/2), by, hud_buttons[i]);
    }
    draw_set_color(c_white);
    
    // 3. COLLAPSIBLE DE MISSAO (RF009)
    if (mission_open) {
        var m_w = 280;
        var m_h = 100;
        var mission_btn_y = start_y + (0 * 50); // Posiçao Y exata do "Missão" (indice 0)
        
        draw_set_alpha(0.8);
        draw_set_color(c_ltgray); // Coloração diferente do menu
        // Expande vindo da barra pra esquerda
        draw_rectangle(gui_w - btn_w - m_w, mission_btn_y - (m_h/2), gui_w - btn_w, mission_btn_y + (m_h/2), false); 
        draw_set_alpha(1.0);
        
        draw_set_color(c_black);
        draw_text(gui_w - btn_w - (m_w/2), mission_btn_y, current_mission);
        draw_set_color(c_white);
    }
} 
// ================= ESTADOS DE OVERLAY (ALBUM / NOTAS) =================
else {
    // Escurece o fundo pra focar no Painel
    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var voltar_y = gui_h - 100;
    
    if (state == "album") {
        draw_set_color(c_white);
        draw_text(gui_w/2, 100, "ÁLBUM DE PINTURAS");
        draw_text(gui_w/2, gui_h/2, "Falta muito a estudar ainda"); // RNF27
        
        // Botão voltar hover do Album
        if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && my > voltar_y - 20 && my < voltar_y + 20) {
            draw_set_color(c_yellow);
        } else draw_set_color(c_white);
        
        draw_text(gui_w/2, voltar_y, "Voltar");
    }
   else if (state == "notes") {
        draw_set_color(c_white);
        draw_text(gui_w/2, 100, "BLOCO DE NOTAS");
        
      
        var _total = array_length(global.notas);
        
        if (_total == 0) {
       
            draw_text(gui_w/2, gui_h/2, "Nenhuma anotação disponível ainda."); 
        } else {
            // Cálculos da paginação
            var _inicio = pagina_notas * itens_por_pagina;
            var _fim = min(_inicio + itens_por_pagina, _total);
            
            // Desenha as notas da página atual
            for (var i = _inicio; i < _fim; i++) {
                var _y = 200 + ((i - _inicio) * 160);
                draw_text(gui_w/2, _y, global.notas[i]);
            }
            
           
            var pag_y = gui_h - 160; 
            
            // Botão "Anterior"
            if (pagina_notas > 0) {
                if (mx > (gui_w/2) - 250 && mx < (gui_w/2) - 150 && my > pag_y - 20 && my < pag_y + 20) {
                    draw_set_color(c_yellow);
                    if (mouse_check_button_pressed(mb_left)) pagina_notas--;
                } else draw_set_color(c_white);
                draw_text((gui_w/2) - 200, pag_y, "< Anterior");
            }
            
            // Botão "Próximo"
            if (_fim < _total) {
                if (mx > (gui_w/2) + 150 && mx < (gui_w/2) + 250 && my > pag_y - 20 && my < pag_y + 20) {
                    draw_set_color(c_yellow);
                    if (mouse_check_button_pressed(mb_left)) pagina_notas++;
                } else draw_set_color(c_white);
                draw_text((gui_w/2) + 200, pag_y, "Próximo >");
            }
        }
        draw_set_color(c_white); // Reseta a cor para o botão voltar
        
        // ================= BOTÃO VOLTAR ORIGINAL =================
        // Botão voltar hover de Notas
        if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && my > voltar_y - 20 && my < voltar_y + 20) {
            draw_set_color(c_yellow);
        } else draw_set_color(c_white);
        
        draw_text(gui_w/2, voltar_y, "Voltar");
    }
}