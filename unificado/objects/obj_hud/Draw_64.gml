draw_set_font(fnt_padrao);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// ================= ESTADO BASE DA HUD (DIREITA) =================
if (state == "closed") {
    var btn_w = 120;
    var start_y = (gui_h / 2) - ((array_length(hud_buttons)*50) / 2);
    
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(gui_w - btn_w, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    for (var i = 0; i < array_length(hud_buttons); i++) {
        var by = start_y + (i * 50);
        var hover = (mx > gui_w - btn_w && mx < gui_w && my > by - 20 && my < by + 20);
        
        if (i == flash_botao && flash_timer > 0) {
            draw_set_color((flash_timer mod 16 < 8) ? c_yellow : c_white);
        } else if (hover) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }
        draw_text(gui_w - (btn_w/2), by, hud_buttons[i]);
    }
    draw_set_color(c_white);
    
    if (mission_open) {
        var m_w = 280;
        var m_h = 130; 
        var mission_btn_y = start_y + (0 * 50); 
        
        draw_set_alpha(0.8);
        draw_set_color(c_ltgray);
        draw_rectangle(gui_w - btn_w - m_w, mission_btn_y - (m_h/2), gui_w - btn_w, mission_btn_y + (m_h/2), false); 
        draw_set_alpha(1.0);
        
        draw_set_color(c_black);
        var centro_x = gui_w - btn_w - (m_w/2);
        
        var texto_npc = variable_global_exists("objetivo_atual") ? global.objetivo_atual : "História: Livre no momento.";
        var texto_amb = variable_global_exists("objetivo_ambiente") ? global.objetivo_ambiente : "";
        
        var texto_final = texto_npc;
        if (texto_amb != "") {
            texto_final += "\n\n" + texto_amb;
        }
        
        draw_text_ext(centro_x, mission_btn_y, texto_final, 20, m_w - 20);
    }
}
// ================= ESTADOS DE OVERLAY (ALBUM / NOTAS) =================
else {
    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var voltar_y = gui_h - 100;
    
    if (state == "album") {
        draw_set_color(c_white);
        draw_text(gui_w/2, 60, "ÁLBUM DE PINTURAS");
        
        var _chaves = [
            "rm_jantar",
            "rm_atelie",
            "rm_corredor",
            "rm_lavanderia",
            "rm_banheiro",
            "rm_quarto",
            "missao_angelique"
        ];
        
        var _nomes = [
            "Sala de Jantar",
            "Ateliê",
            "Corredor",
            "Lavanderia",
            "Banheiro",
            "Quarto",
            "Missão: Angélique"
        ];
        
        // 🆕 Referência direta ao asset em vez de string
        var _sprites = [
            spr_quadro_jantar,
            spr_quadro_atelie,
            spr_quadro_corredor,
            spr_quadro_lavanderia,
            spr_quadro_banheiro,
            spr_quadro_quarto,
            spr_quadro_angelique
        ];
        
        var total_slots = 7;
        var cols = 3;
        var slot_w = 220;
        var slot_h = 160;
        var spacing = 30;
        
        var total_w = (cols * slot_w) + ((cols - 1) * spacing);
        var base_x = (gui_w / 2) - (total_w / 2);
        var base_y = 130;
        
        var _quadros_ok = variable_global_exists("quadros_coletados");
        
        for (var i = 0; i < total_slots; i++) {
            var col = i mod cols;
            var row = floor(i / cols);
            
            var start_x = base_x + (col * (slot_w + spacing));
            var start_y = base_y + (row * (slot_h + spacing));
            
            var _chave = _chaves[i];
            var _coletado = _quadros_ok
                && variable_struct_exists(global.quadros_coletados, _chave)
                && global.quadros_coletados[$ _chave] == true;
            
            if (_coletado) {
                var _spr = _sprites[i];
                
                // Debug temporário — remove depois de confirmar que está funcionando
                show_debug_message("Slot " + string(i) + " | Sprite index: " + string(_spr));
                
                if (_spr != -1) {
                    draw_sprite_stretched(_spr, 0, start_x, start_y, slot_w, slot_h);
                } else {
                    draw_set_color(c_green);
                    draw_set_alpha(0.5);
                    draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, false);
                    draw_set_alpha(1.0);
                }
                draw_set_color(c_yellow);
                draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, true);
                draw_set_color(c_yellow);
                draw_text(start_x + slot_w/2, start_y + slot_h + 15, _nomes[i]);
            } else {
                draw_set_color(c_dkgray);
                draw_set_alpha(0.5);
                draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, false);
                draw_set_alpha(1.0);
                draw_set_color(c_white);
                draw_rectangle(start_x, start_y, start_x + slot_w, start_y + slot_h, true);
                draw_set_color(c_gray);
                draw_text(start_x + slot_w/2, start_y + slot_h/2 - 10, "?");
                draw_text(start_x + slot_w/2, start_y + slot_h/2 + 20, _nomes[i]);
            }
        }
        
        var _total_coletados = 0;
        if (_quadros_ok) {
            for (var i = 0; i < total_slots; i++) {
                if (variable_struct_exists(global.quadros_coletados, _chaves[i])
                    && global.quadros_coletados[$ _chaves[i]] == true) {
                    _total_coletados++;
                }
            }
        }
        draw_set_color(c_white);
        draw_text(gui_w/2, voltar_y - 40,
            string(_total_coletados) + "/" + string(total_slots) + " quadros coletados");
        
        if (_total_coletados == 0) {
            draw_set_color(c_gray);
            draw_text(gui_w/2, gui_h/2 + 80, "Falta muito a estudar ainda!");
        }
        
        if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && my > voltar_y - 20 && my < voltar_y + 20) {
            draw_set_color(c_yellow);
        } else draw_set_color(c_white);
        draw_text(gui_w/2, voltar_y, "Voltar");
    }
    
    else if (state == "notes") {
        draw_set_color(c_white);
        draw_text(gui_w/2, 60, "BLOCO DE NOTAS");
        
        var _pronomes = ["Todos", "Je", "Tu", "Il/Elle/On", "Nous", "Vous", "Ils/Elles"];
        
        if (!variable_instance_exists(id, "filtro_pronome")) {
            filtro_pronome = 0;
        }
        
        var _total_pronomes = array_length(_pronomes);
        var _fil_total_w = _total_pronomes * 100;
        var _fil_start_x = (gui_w / 2) - (_fil_total_w / 2) + 50;
        var _fil_y = 110;
        
        for (var i = 0; i < _total_pronomes; i++) {
            var _fx = _fil_start_x + (i * 100);
            
            if (filtro_pronome == i) {
                draw_set_color(c_yellow);
                draw_set_alpha(0.2);
                draw_rectangle(_fx - 40, _fil_y - 16, _fx + 40, _fil_y + 16, false);
                draw_set_alpha(1.0);
                draw_set_color(c_yellow);
            } else {
                draw_set_color(c_white);
            }
            draw_text(_fx, _fil_y, _pronomes[i]);
            
            if (mouse_check_button_pressed(mb_left)
                && mx > _fx - 40 && mx < _fx + 40
                && my > _fil_y - 16 && my < _fil_y + 16) {
                filtro_pronome = i;
                pagina_notas = 0;
            }
        }
        draw_set_color(c_white);
        
        var _notas_filtradas = [];
        if (variable_global_exists("notas")) {
            for (var i = 0; i < array_length(global.notas); i++) {
                if (filtro_pronome == 0) {
                    array_push(_notas_filtradas, global.notas[i]);
                } else {
                    if (string_pos(_pronomes[filtro_pronome], global.notas[i]) > 0) {
                        array_push(_notas_filtradas, global.notas[i]);
                    }
                }
            }
        }
        
        var _total = array_length(_notas_filtradas);
        
        if (_total == 0) {
            draw_set_color(c_gray);
            if (filtro_pronome == 0) {
                draw_text(gui_w/2, gui_h/2, "Nenhuma anotação disponível ainda.");
            } else {
                draw_text(gui_w/2, gui_h/2, "Nenhuma anotação para " + _pronomes[filtro_pronome] + ".");
            }
        } else {
            var _inicio = pagina_notas * itens_por_pagina;
            var _fim = min(_inicio + itens_por_pagina, _total);
            
            for (var i = _inicio; i < _fim; i++) {
                var _y = 220 + ((i - _inicio) * 160);
                draw_set_color(c_white);
                draw_text(gui_w/2, _y, _notas_filtradas[i]);
            }
            
            var pag_y = gui_h - 160;
            
            if (pagina_notas > 0) {
                if (mx > (gui_w/2) - 250 && mx < (gui_w/2) - 150 && my > pag_y - 20 && my < pag_y + 20) {
                    draw_set_color(c_yellow);
                    if (mouse_check_button_pressed(mb_left)) pagina_notas--;
                } else draw_set_color(c_white);
                draw_text((gui_w/2) - 200, pag_y, "< Anterior");
            }
            
            if (_fim < _total) {
                if (mx > (gui_w/2) + 150 && mx < (gui_w/2) + 250 && my > pag_y - 20 && my < pag_y + 20) {
                    draw_set_color(c_yellow);
                    if (mouse_check_button_pressed(mb_left)) pagina_notas++;
                } else draw_set_color(c_white);
                draw_text((gui_w/2) + 200, pag_y, "Próximo >");
            }
        }
        
        draw_set_color(c_white);
        if (mx > (gui_w/2) - 150 && mx < (gui_w/2) + 150 && my > voltar_y - 20 && my < voltar_y + 20) {
            draw_set_color(c_yellow);
        } else draw_set_color(c_white);
        draw_text(gui_w/2, voltar_y, "Voltar");
    }
}