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
        var mission_btn_y = start_y + (0 * 50); // Posiçao Y exata do "Missão"
        
        draw_set_alpha(0.8);
        draw_set_color(c_ltgray);
        draw_rectangle(gui_w - btn_w - m_w, mission_btn_y - (m_h/2), gui_w - btn_w, mission_btn_y + (m_h/2), false); 
        draw_set_alpha(1.0);
        
        draw_set_color(c_black);
        
        // A CORREÇÃO ESTÁ AQUI: Usa a variável global e quebra a linha para caber na caixa
    var centro_x = gui_w - btn_w - (m_w/2);
        
        // Verifica se a variável existe. Se não existir, usa um texto provisório para não crashar!
        var texto_missao = variable_global_exists("objetivo_atual") ? global.objetivo_atual : "Nenhum objetivo no momento. Explore livremente!";
        
        draw_text_ext(centro_x, mission_btn_y, texto_missao, 20, m_w - 20)
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
        
        var total_albuns = 29;
        var albuns_por_pagina = 6;
        var cols = 3;
        var slot_w = 260;
        var slot_h = 180;
        var spacing = 40;
        
        var total_w = (cols * slot_w) + ((cols - 1) * spacing);
        var base_x = (gui_w / 2) - (total_w / 2);
        var base_y = 220;
        
        var _inicio = pagina_album * albuns_por_pagina;
        var _fim = min(_inicio + albuns_por_pagina, total_albuns);
        
        for (var i = _inicio; i < _fim; i++) {
            var idx = i - _inicio;
            var col = idx % cols;
            var row = floor(idx / cols);
            
            var start_x = base_x + (col * (slot_w + spacing));
            var start_y = base_y + (row * (slot_h + spacing));
            
            // Fundo escuro
            draw_set_color(c_dkgray);
            draw_set_alpha(0.5);
            draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, false);
            draw_set_alpha(1.0);
            
            // Borda
            draw_set_color(c_white);
            draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, true);
            
            // Texto
            draw_text(start_x + slot_w/2, start_y + slot_h/2 - 10, "?" + " (" + string(i+1) + ")");
            draw_text(start_x + slot_w/2, start_y + slot_h/2 + 20, "Bloqueado");
        }
        
        // Paginação do Álbum
        var pag_y = voltar_y; 
        
        // Botão "Anterior"
        if (pagina_album > 0) {
            if (mx > (gui_w/2) - 250 && mx < (gui_w/2) - 150 && my > pag_y - 20 && my < pag_y + 20) {
                draw_set_color(c_yellow);
                if (mouse_check_button_pressed(mb_left)) pagina_album--;
            } else draw_set_color(c_white);
            draw_text((gui_w/2) - 200, pag_y, "< Anterior");
        }
        
        // Botão "Próximo"
        if (_fim < total_albuns) {
            if (mx > (gui_w/2) + 150 && mx < (gui_w/2) + 250 && my > pag_y - 20 && my < pag_y + 20) {
                draw_set_color(c_yellow);
                if (mouse_check_button_pressed(mb_left)) pagina_album++;
            } else draw_set_color(c_white);
            draw_text((gui_w/2) + 200, pag_y, "Próximo >");
        }
        draw_set_color(c_white);
        
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