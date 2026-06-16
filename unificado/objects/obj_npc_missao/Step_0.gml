/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 1DFEB5D3
/// @DnDArgument : "code" "if (!visible) exit;$(13_10)$(13_10)// =========================================================================$(13_10)// --- SISTEMA AUTOMÁTICO DE OBJETIVOS DA HUD (FLUXO EM TEMPO REAL) ---$(13_10)if (variable_instance_exists(id, "missao_id") && missao_id != "") {$(13_10)    $(13_10)    // 1. Antes de falar com o Jerome pela primeira vez$(13_10)    if (estado == 0) {$(13_10)        global.objetivo_atual = "Objetivo: Fale com o Jerome";$(13_10)    }$(13_10)    $(13_10)    // 2. Missão aceita e em andamento$(13_10)    else if (estado == 1) {$(13_10)        var _contagem_hud = 0;$(13_10)        $(13_10)        // Conta quantos quizzes dessa área já foram feitos$(13_10)        for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)            if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) && global.quizzes_concluidos[$ alvos_area[i]] == true) {$(13_10)                _contagem_hud++;$(13_10)            }$(13_10)        }$(13_10)        $(13_10)        // Se ainda faltam quizzes (ex: 0/3, 1/3, 2/3)$(13_10)        if (_contagem_hud < quantidade_necessaria) {$(13_10)            global.objetivo_atual = "Missão: Resolva os quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ")";$(13_10)        } $(13_10)        // Se chegou a 3/3 mas ainda não entregou a nota para o Jerome$(13_10)        else {$(13_10)            global.objetivo_atual = "Missão: Fale com o Jerome novamente";$(13_10)        }$(13_10)    }$(13_10)    $(13_10)    // 3. Missão concluída com sucesso!$(13_10)    else if (estado == 2) {$(13_10)        global.objetivo_atual = "Siga para o Ateliê, a Angélique precisa de ajuda";$(13_10)    }$(13_10)}$(13_10)// =========================================================================$(13_10)$(13_10)$(13_10)if (collision_circle(x, y, global.range, Player, false, true)) {$(13_10)    $(13_10)    // 1. BALÃO "E" PARA TODOS (Móveis e NPCs)$(13_10)    if (balao_e == noone) {$(13_10)        balao_e = instance_create_depth(x, y, -9999, interacao);$(13_10)        var largura_balao = balao_e.sprite_width;$(13_10)        var altura_balao = balao_e.sprite_height;$(13_10)        balao_e.x = x + (sprite_width / 2) - sprite_xoffset - (largura_balao / 2) + balao_e.sprite_xoffset;$(13_10)        balao_e.y = bbox_top - altura_balao - 20; $(13_10)    }$(13_10)  $(13_10)    // 2. LÓGICA AO APERTAR "E"$(13_10)    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {$(13_10)        $(13_10)        // --- SE FOR O JEROME (Checa se ele tem a variável missao_id) ---$(13_10)        if (variable_instance_exists(id, "missao_id") && missao_id != "") {$(13_10)            $(13_10)            if (!variable_global_exists("status_missoes")) {$(13_10)                global.status_missoes = {};$(13_10)            }$(13_10)            if (!variable_global_exists("erros_quiz")) {$(13_10)                global.erros_quiz = {}; $(13_10)            }$(13_10)$(13_10)            var _texto_escolhido = []; $(13_10)$(13_10)            if (estado == 0) {$(13_10)                array_copy(_texto_escolhido, 0, texto_inicio, 0, array_length(texto_inicio)); $(13_10)                estado = 1; $(13_10)            }$(13_10)            else if (estado == 1) {$(13_10)                var _completados = 0;$(13_10)                $(13_10)                for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                    if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) && global.quizzes_concluidos[$ alvos_area[i]] == true) {$(13_10)                        _completados++;$(13_10)                    }$(13_10)                }$(13_10)                $(13_10)                if (_completados >= quantidade_necessaria) {$(13_10)                    var _total_erros = 0;$(13_10)                    for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                        var _alvo = alvos_area[i];$(13_10)                        if (variable_struct_exists(global.erros_quiz, _alvo)) {$(13_10)                            _total_erros += global.erros_quiz[$ _alvo];$(13_10)                        }$(13_10)                    }$(13_10)                    $(13_10)                    var _total_tentativas = _completados + _total_erros;$(13_10)                    var _taxa_acerto = 0;$(13_10)                    if (_total_tentativas > 0) {$(13_10)                        _taxa_acerto = (_completados / _total_tentativas) * 100;$(13_10)                    }$(13_10)                    $(13_10)                    if (_taxa_acerto >= taxa_minima) {$(13_10)                        array_copy(_texto_escolhido, 0, texto_concluido, 0, array_length(texto_concluido));$(13_10)                        array_push(_texto_escolhido, "(Sua taxa de acerto foi: " + string(round(_taxa_acerto)) + "% - Aprovado!)");$(13_10)                        estado = 2;$(13_10)                    } else {$(13_10)                        array_copy(_texto_escolhido, 0, texto_falha, 0, array_length(texto_falha));$(13_10)                        array_insert(_texto_escolhido, 1, "(Você acertou " + string(round(_taxa_acerto)) + "%. O mínimo exigido é " + string(taxa_minima) + "%.)");$(13_10)                        estado = 0;$(13_10)                        for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                            var _alvo = alvos_area[i];$(13_10)                            variable_struct_remove(global.quizzes_concluidos, _alvo);$(13_10)                            variable_struct_remove(global.erros_quiz, _alvo);$(13_10)                        }$(13_10)                    }$(13_10)                } else {$(13_10)                    array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));$(13_10)                    var _faltam = quantidade_necessaria - _completados;$(13_10)                    array_push(_texto_escolhido, "(Faltam " + string(_faltam) + " quizzes para eu avaliar sua nota.)");$(13_10)                }$(13_10)            }$(13_10)            else if (estado == 2) {$(13_10)                array_copy(_texto_escolhido, 0, texto_pos_missao, 0, array_length(texto_pos_missao));$(13_10)            }$(13_10)$(13_10)            global.status_missoes[$ missao_id] = estado;$(13_10)            global.dialogo = true;$(13_10)            $(13_10)            var _inst_dialogo = instance_create_depth(0, 0, -9999, Dialogo);$(13_10)            _inst_dialogo.texto = _texto_escolhido;$(13_10)            $(13_10)            if (variable_instance_exists(id, "nome")) {$(13_10)                _inst_dialogo.nomeNpc = nome;$(13_10)            } else {$(13_10)                _inst_dialogo.nomeNpc = "";$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)    $(13_10)} else {$(13_10)    if (balao_e != noone) {$(13_10)        instance_destroy(balao_e);$(13_10)        balao_e = noone;$(13_10)    }$(13_10)}"
if (!visible) exit;

// =========================================================================
// --- SISTEMA AUTOMÁTICO DE OBJETIVOS DA HUD (FLUXO EM TEMPO REAL) ---
if (variable_instance_exists(id, "missao_id") && missao_id != "") {
    
    // 1. Antes de falar com o Jerome pela primeira vez
    if (estado == 0) {
        global.objetivo_atual = "Objetivo: Fale com o Jerome";
    }
    
    // 2. Missão aceita e em andamento
    else if (estado == 1) {
        var _contagem_hud = 0;
        
        // Conta quantos quizzes dessa área já foram feitos
        for (var i = 0; i < array_length(alvos_area); i++) {
            if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) && global.quizzes_concluidos[$ alvos_area[i]] == true) {
                _contagem_hud++;
            }
        }
        
        // Se ainda faltam quizzes (ex: 0/3, 1/3, 2/3)
        if (_contagem_hud < quantidade_necessaria) {
            global.objetivo_atual = "Missão: Resolva os quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ")";
        } 
        // Se chegou a 3/3 mas ainda não entregou a nota para o Jerome
        else {
            global.objetivo_atual = "Missão: Fale com o Jerome novamente";
        }
    }
    
    // 3. Missão concluída com sucesso!
    else if (estado == 2) {
        global.objetivo_atual = "Siga para o Ateliê, a Angélique precisa de ajuda";
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
                    } else {
                        array_copy(_texto_escolhido, 0, texto_falha, 0, array_length(texto_falha));
                        array_insert(_texto_escolhido, 1, "(Você acertou " + string(round(_taxa_acerto)) + "%. O mínimo exigido é " + string(taxa_minima) + "%.)");
                        estado = 0;
                        for (var i = 0; i < array_length(alvos_area); i++) {
                            var _alvo = alvos_area[i];
                            variable_struct_remove(global.quizzes_concluidos, _alvo);
                            variable_struct_remove(global.erros_quiz, _alvo);
                        }
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