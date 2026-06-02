/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 1DFEB5D3
/// @DnDArgument : "code" "// 1. BLINDAGEM ANTI-CRASH$(13_10)if (!variable_global_exists("status_missoes")) exit;$(13_10)$(13_10)// (Removemos o if (!visible) exit; para funcionar sempre!)$(13_10)$(13_10)// 2. CHECA SE O PLAYER CHEGOU PERTO$(13_10)if (collision_circle(x, y, global.range, Player, false, true)) {$(13_10)    $(13_10)    // Cria o balão "E" de forma fixa e segura, sem depender do sprite$(13_10)    if (balao_e == noone) {$(13_10)        balao_e = instance_create_depth(x, y, -9999, interacao);$(13_10)        balao_e.x = x; $(13_10)        balao_e.y = y - 60; // Sobe o balão 60 pixels. Ajuste se precisar!$(13_10)    }$(13_10)  $(13_10)    // 3. APERTOU "E"$(13_10)    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {$(13_10)        $(13_10)        var _texto_escolhido = []; $(13_10)$(13_10)        if (estado == 0) {$(13_10)            _texto_escolhido = texto_inicio; $(13_10)            estado = 1; $(13_10)            global.objetivo_atual = "Missão: Complete pelo menos " + string(quantidade_necessaria) + " quizzes.";$(13_10)        }$(13_10)        else if (estado == 1) {$(13_10)            var _completados = 0;$(13_10)            $(13_10)            for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) && global.quizzes_concluidos[$ alvos_area[i]] == true) {$(13_10)                    _completados++;$(13_10)                }$(13_10)            }$(13_10)            $(13_10)            if (_completados >= quantidade_necessaria) {$(13_10)                var _total_erros = 0;$(13_10)                for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                    var _alvo = alvos_area[i];$(13_10)                    if (variable_struct_exists(global.erros_quiz, _alvo)) {$(13_10)                        _total_erros += global.erros_quiz[$ _alvo];$(13_10)                    }$(13_10)                }$(13_10)                $(13_10)                var _total_tentativas = _completados + _total_erros;$(13_10)                var _taxa_acerto = 0;$(13_10)                if (_total_tentativas > 0) {$(13_10)                    _taxa_acerto = (_completados / _total_tentativas) * 100;$(13_10)                }$(13_10)                $(13_10)                if (_taxa_acerto >= taxa_minima) {$(13_10)                    array_copy(_texto_escolhido, 0, texto_concluido, 0, array_length(texto_concluido));$(13_10)                    array_push(_texto_escolhido, "(Sua taxa de acerto foi: " + string(round(_taxa_acerto)) + "% - Aprovado!)");$(13_10)                    estado = 2;$(13_10)                    global.objetivo_atual = "Nenhum objetivo no momento. Explore livremente!";$(13_10)                } else {$(13_10)                    array_copy(_texto_escolhido, 0, texto_falha, 0, array_length(texto_falha));$(13_10)                    array_insert(_texto_escolhido, 1, "(Você acertou " + string(round(_taxa_acerto)) + "%. O mínimo exigido é " + string(taxa_minima) + "%.)");$(13_10)                    estado = 0;$(13_10)                    for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                        var _alvo = alvos_area[i];$(13_10)                        variable_struct_remove(global.quizzes_concluidos, _alvo);$(13_10)                        variable_struct_remove(global.erros_quiz, _alvo);$(13_10)                    }$(13_10)                    global.objetivo_atual = "Você falhou. Refaça a missão prestando mais atenção!";$(13_10)                }$(13_10)            } else {$(13_10)                array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));$(13_10)                var _faltam = quantidade_necessaria - _completados;$(13_10)                array_push(_texto_escolhido, "(Faltam " + string(_faltam) + " quizzes para eu avaliar sua nota.)");$(13_10)            }$(13_10)        }$(13_10)        else if (estado == 2) {$(13_10)            _texto_escolhido = texto_pos_missao;$(13_10)        }$(13_10)$(13_10)        if (missao_id != "") {$(13_10)            global.status_missoes[$ missao_id] = estado;$(13_10)        }$(13_10)        global.dialogo = true;$(13_10)        $(13_10)        var _inst_dialogo = instance_create_depth(0, 0, -9999, Dialogo);$(13_10)        _inst_dialogo.texto = _texto_escolhido;$(13_10)        _inst_dialogo.nomeNpc = nome;$(13_10)    }$(13_10)    $(13_10)} else {$(13_10)    if (balao_e != noone) {$(13_10)        instance_destroy(balao_e);$(13_10)        balao_e = noone;$(13_10)    }$(13_10)}"
// 1. BLINDAGEM ANTI-CRASH
if (!variable_global_exists("status_missoes")) exit;

// (Removemos o if (!visible) exit; para funcionar sempre!)

// 2. CHECA SE O PLAYER CHEGOU PERTO
if (collision_circle(x, y, global.range, Player, false, true)) {
    
    // Cria o balão "E" de forma fixa e segura, sem depender do sprite
    if (balao_e == noone) {
        balao_e = instance_create_depth(x, y, -9999, interacao);
        balao_e.x = x; 
        balao_e.y = y - 60; // Sobe o balão 60 pixels. Ajuste se precisar!
    }
  
    // 3. APERTOU "E"
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        var _texto_escolhido = []; 

        if (estado == 0) {
            _texto_escolhido = texto_inicio; 
            estado = 1; 
            global.objetivo_atual = "Missão: Complete pelo menos " + string(quantidade_necessaria) + " quizzes.";
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
            _texto_escolhido = texto_pos_missao;
        }

        if (missao_id != "") {
            global.status_missoes[$ missao_id] = estado;
        }
        global.dialogo = true;
        
        var _inst_dialogo = instance_create_depth(0, 0, -9999, Dialogo);
        _inst_dialogo.texto = _texto_escolhido;
        _inst_dialogo.nomeNpc = nome;
    }
    
} else {
    if (balao_e != noone) {
        instance_destroy(balao_e);
        balao_e = noone;
    }
}