if (!visible) exit;

// =========================================================================
// --- NOVO: ATUALIZAÇÃO DA HUD EM TEMPO REAL ---
// Se este objeto for o Jerome e a missão estiver em andamento (estado 1)
if (variable_instance_exists(id, "missao_id") && missao_id != "") {
    if (estado == 1) {
        var _contagem_hud = 0;
        
        // Conta quantos quizzes dessa área já foram feitos
        for (var i = 0; i < array_length(alvos_area); i++) {
            if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) && global.quizzes_concluidos[$ alvos_area[i]] == true) {
                _contagem_hud++;
            }
        }
        
        // Atualiza o texto da HUD em tempo real para o jogador acompanhar!
        global.objetivo_atual = "Missão: Acerte " + string(quantidade_necessaria) + " quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ")";
    }
}
// =========================================================================


if (collision_circle(x, y, global.range, Player, false, true)) {
    
    // 1. BALÃO "E" PARA TODOS (Móveis e NPCs)
    if (balao_e == noone) {
        balao_e = instance_create_depth(x, y, -9999, interacao);
        var largura_balao = balao_e.sprite_width;
        var altura_balao = balao_e.sprite_height;
        balao_e.x = x + (sprite_width / 2) - sprite_xoffset - (largura_balao / 2) + balao_e.sprite_xoffset;
        balao_e.y = bbox_top - altura_balao - 20; 
    }
  
    // 2. LÓGICA AO APERTAR "E"
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        // --- SE FOR O JEROME (Checa se ele tem a variável missao_id) ---
        if (variable_instance_exists(id, "missao_id") && missao_id != "") {
            
            if (!variable_global_exists("status_missoes")) {
                global.status_missoes = {};
            }
            if (!variable_global_exists("erros_quiz")) {
                global.erros_quiz = {}; 
            }

            var _texto_escolhido = []; 

            if (estado == 0) {
                array_copy(_texto_escolhido, 0, texto_inicio, 0, array_length(texto_inicio)); 
                estado = 1; 
            }
            else if (estado == 1) {
                var _completados = 0;
                
                for (var i = 0; i < array_length(alvos_area); i++) {
                    if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) && global.quizzes_concluidos[$ alvos_area[i]] == true) {
                        _completados++;
                    }
                }
                
                if (_completados >= quantidade_necessaria) {
                    var _total_erros = 0;
                    for (var i = 0; i < array_length(alvos_area); i++) {
                        var _alvo = alvos_area[i];
                        if (variable_struct_exists(global.erros_quiz, _alvo)) {
                            _total_erros += global.erros_quiz[$ _alvo];
                        }
                    }
                    
                    var _total_tentativas = _completados + _total_erros;
                    var _taxa_acerto = 0;
                    if (_total_tentativas > 0) {
                        _taxa_acerto = (_completados / _total_tentativas) * 100;
                    }
                    
                    if (_taxa_acerto >= taxa_minima) {
                        array_copy(_texto_escolhido, 0, texto_concluido, 0, array_length(texto_concluido));
                        array_push(_texto_escolhido, "(Sua taxa de acerto foi: " + string(round(_taxa_acerto)) + "% - Aprovado!)");
                        estado = 2;
                        global.objetivo_atual = "Nenhum objetivo no momento. Explore livremente!";
                    } else {
                        array_copy(_texto_escolhido, 0, texto_falha, 0, array_length(texto_falha));
                        array_insert(_texto_escolhido, 1, "(Você acertou " + string(round(_taxa_acerto)) + "%. O mínimo exigido é " + string(taxa_minima) + "%.)");
                        estado = 0;
                        for (var i = 0; i < array_length(alvos_area); i++) {
                            var _alvo = alvos_area[i];
                            variable_struct_remove(global.quizzes_concluidos, _alvo);
                            variable_struct_remove(global.erros_quiz, _alvo);
                        }
                        global.objetivo_atual = "Você falhou. Refaça a missão prestando mais atenção!";
                    }
                } else {
                    array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));
                    var _faltam = quantidade_necessaria - _completados;
                    array_push(_texto_escolhido, "(Faltam " + string(_faltam) + " quizzes para eu avaliar sua nota.)");
                }
            }
            else if (estado == 2) {
                array_copy(_texto_escolhido, 0, texto_pos_missao, 0, array_length(texto_pos_missao));
            }

            global.status_missoes[$ missao_id] = estado;
            global.dialogo = true;
            
            var _inst_dialogo = instance_create_depth(0, 0, -9999, Dialogo);
            _inst_dialogo.texto = _texto_escolhido;
            
            if (variable_instance_exists(id, "nome")) {
                _inst_dialogo.nomeNpc = nome;
            } else {
                _inst_dialogo.nomeNpc = "";
            }
        }
    }
    
} else {
    if (balao_e != noone) {
        instance_destroy(balao_e);
        balao_e = noone;
    }
}