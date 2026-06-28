/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 1DFEB5D3
/// @DnDArgument : "code" "if (!visible) exit;$(13_10)$(13_10)// =========================================================================$(13_10)// --- SISTEMA AUTOMÁTICO DE OBJETIVOS DA HUD (FLUXO EM TEMPO REAL) ---$(13_10)if (variable_instance_exists(id, "missao_id") && missao_id != "") {$(13_10)$(13_10)    // Contagem reutilizada nos estados -1 e 1$(13_10)    var _contagem_hud = 0;$(13_10)    for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)        if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) $(13_10)            && global.quizzes_concluidos[$ alvos_area[i]] == true) {$(13_10)            _contagem_hud++;$(13_10)        }$(13_10)    }$(13_10)$(13_10)    // Calcula taxa de acerto atual para mostrar no objetivo (só Jerome)$(13_10)    var _taxa_hud = 0;$(13_10)    if (_contagem_hud > 0) {$(13_10)        var _erros_hud = 0;$(13_10)        for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)            if (variable_struct_exists(global.erros_quiz, alvos_area[i])) {$(13_10)                _erros_hud += global.erros_quiz[$ alvos_area[i]];$(13_10)            }$(13_10)        }$(13_10)        var _tent_hud = _contagem_hud + _erros_hud;$(13_10)        if (_tent_hud > 0) _taxa_hud = round((_contagem_hud / _tent_hud) * 100);$(13_10)    }$(13_10)$(13_10)    // -1 = falhou, refazendo$(13_10)    if (estado == -1) {$(13_10)        if (missao_id == "missao_angelique_corredor") {$(13_10)            if (_contagem_hud < quantidade_necessaria) {$(13_10)                global.objetivo_atual = "Missão: Continue procurando o ferro de passar!";$(13_10)            } else {$(13_10)                global.objetivo_atual = "Missão: Fale com a Angélique novamente";$(13_10)            }$(13_10)        } else {$(13_10)            if (_contagem_hud < quantidade_necessaria) {$(13_10)                global.objetivo_atual = "Missão: Resolva os quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ") — Acerto atual: " + string(_taxa_hud) + "%";$(13_10)            } else {$(13_10)                global.objetivo_atual = "Missão: Fale com o Jerome novamente — Acerto: " + string(_taxa_hud) + "%";$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)$(13_10)    // 0 = ainda não falou$(13_10)    else if (estado == 0) {$(13_10)        if (missao_id == "missao_angelique_corredor") {$(13_10)            global.objetivo_atual = "Objetivo: Fale com a Angélique";$(13_10)        } else {$(13_10)            global.objetivo_atual = "Objetivo: Fale com o Jerome";$(13_10)        }$(13_10)    }$(13_10)$(13_10)    // 1 = em andamento$(13_10)    else if (estado == 1) {$(13_10)        if (missao_id == "missao_angelique_corredor") {$(13_10)            if (_contagem_hud < quantidade_necessaria) {$(13_10)                global.objetivo_atual = "Missão: Ache o ferro de passar nas salas próximas!";$(13_10)            } else {$(13_10)                global.objetivo_atual = "Missão: Fale com a Angélique novamente";$(13_10)            }$(13_10)        } else {$(13_10)            if (_contagem_hud < quantidade_necessaria) {$(13_10)                global.objetivo_atual = "Missão: Resolva os quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ") — Acerto atual: " + string(_taxa_hud) + "%";$(13_10)            } else {$(13_10)                global.objetivo_atual = "Missão: Fale com o Jerome novamente — Acerto: " + string(_taxa_hud) + "%";$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)$(13_10)    // 2 = concluída$(13_10)    else if (estado == 2) {$(13_10)        if (missao_id == "missao_angelique_corredor") {$(13_10)            global.objetivo_atual = "Missão concluída! Continue explorando.";$(13_10)        } else {$(13_10)            global.objetivo_atual = "Siga para o Ateliê, a Angélique precisa de ajuda";$(13_10)        }$(13_10)    }$(13_10)}$(13_10)// =========================================================================$(13_10)$(13_10)$(13_10)if (collision_circle(x, y, global.range, Player, false, true)) {$(13_10)    $(13_10)    if (balao_e == noone) {$(13_10)        balao_e = instance_create_depth(x, y, -9999, interacao);$(13_10)        var largura_balao = balao_e.sprite_width;$(13_10)        var altura_balao = balao_e.sprite_height;$(13_10)        balao_e.x = x + (sprite_width / 2) - sprite_xoffset - (largura_balao / 2) + balao_e.sprite_xoffset;$(13_10)        balao_e.y = bbox_top - altura_balao - 20; $(13_10)    }$(13_10)  $(13_10)    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {$(13_10)        $(13_10)        if (variable_instance_exists(id, "missao_id") && missao_id != "") {$(13_10)            $(13_10)            if (!variable_global_exists("status_missoes")) global.status_missoes = {};$(13_10)            if (!variable_global_exists("erros_quiz"))    global.erros_quiz = {};$(13_10)$(13_10)            var _texto_escolhido = [];$(13_10)            var _verificar_agora = false;$(13_10)$(13_10)            // ── Estado -1: falhou antes ──$(13_10)            if (estado == -1) {$(13_10)                var _completados_check = 0;$(13_10)                for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                    if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) $(13_10)                        && global.quizzes_concluidos[$ alvos_area[i]] == true) {$(13_10)                        _completados_check++;$(13_10)                    }$(13_10)                }$(13_10)                if (_completados_check >= quantidade_necessaria) {$(13_10)                    estado = 1;$(13_10)                    _verificar_agora = true;$(13_10)                } else {$(13_10)                    array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));$(13_10)                    if (missao_id == "missao_angelique_corredor") {$(13_10)                        array_push(_texto_escolhido, "(Continue procurando o ferro de passar nas salas próximas!)");$(13_10)                    } else {$(13_10)                        array_push(_texto_escolhido, "(Você completou " + string(_completados_check) + "/" + string(quantidade_necessaria) + " quizzes. Faltam " + string(quantidade_necessaria - _completados_check) + ".)");$(13_10)                    }$(13_10)                    // estado permanece -1$(13_10)                }$(13_10)            }$(13_10)$(13_10)            // ── Estado 0: primeira vez ──$(13_10)            else if (estado == 0) {$(13_10)                array_copy(_texto_escolhido, 0, texto_inicio, 0, array_length(texto_inicio)); $(13_10)                estado = 1; $(13_10)            }$(13_10)$(13_10)            // ── Estado 1: verificar quizzes (ou forçado pelo -1 com _verificar_agora) ──$(13_10)            if (estado == 1 && (array_length(_texto_escolhido) == 0 || _verificar_agora)) {$(13_10)                var _completados = 0;$(13_10)                for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                    if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) $(13_10)                        && global.quizzes_concluidos[$ alvos_area[i]] == true) {$(13_10)                        _completados++;$(13_10)                    }$(13_10)                }$(13_10)                $(13_10)                if (_completados >= quantidade_necessaria) {$(13_10)                    var _total_erros = 0;$(13_10)                    for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                        var _alvo = alvos_area[i];$(13_10)                        if (variable_struct_exists(global.erros_quiz, _alvo)) {$(13_10)                            _total_erros += global.erros_quiz[$ _alvo];$(13_10)                        }$(13_10)                    }$(13_10)                    var _total_tentativas = _completados + _total_erros;$(13_10)                    var _taxa_acerto = 0;$(13_10)                    if (_total_tentativas > 0) {$(13_10)                        _taxa_acerto = (_completados / _total_tentativas) * 100;$(13_10)                    }$(13_10)                    $(13_10)                    if (_taxa_acerto >= taxa_minima) {$(13_10)                        // ── APROVADO ──$(13_10)                        array_copy(_texto_escolhido, 0, texto_concluido, 0, array_length(texto_concluido));$(13_10)                        array_push(_texto_escolhido, "(Sua taxa de acerto foi: " + string(round(_taxa_acerto)) + "% - Aprovado!)");$(13_10)                        estado = 2;$(13_10)                        $(13_10)                        // Quadro: só para a Angélique$(13_10)                        if (missao_id == "missao_angelique_corredor") {$(13_10)                            if (!variable_struct_exists(global.quadros_coletados, "missao_angelique")$(13_10)                                || global.quadros_coletados[$ "missao_angelique"] == false) {$(13_10)                                global.quadros_coletados[$ "missao_angelique"] = true;$(13_10)                                var _popup = instance_create_depth(0, 0, -9999, obj_popup_quadro);$(13_10)                                _popup.sala_id = "missao_angelique";$(13_10)                            }$(13_10)                        }$(13_10)                        if (instance_exists(obj_hud)) {$(13_10)                            obj_hud.flash_botao  = 0;$(13_10)                            obj_hud.flash_timer  = room_speed * 3;$(13_10)                            obj_hud.missao_timer = room_speed * 10;$(13_10)                        }$(13_10)                        $(13_10)                    } else {$(13_10)                        // ── REPROVADO ──$(13_10)                        array_copy(_texto_escolhido, 0, texto_falha, 0, array_length(texto_falha));$(13_10)                        array_insert(_texto_escolhido, 1, "(Você acertou " + string(round(_taxa_acerto)) + "%. O mínimo exigido é " + string(taxa_minima) + "%.)");$(13_10)                        estado = -1;$(13_10)                        global.status_missoes[$ missao_id] = -1;$(13_10)                        // Só zera os erros, NÃO remove quizzes_concluidos$(13_10)                        for (var i = 0; i < array_length(alvos_area); i++) {$(13_10)                            var _alvo = alvos_area[i];$(13_10)                            variable_struct_remove(global.erros_quiz, _alvo);$(13_10)                        }$(13_10)                    }$(13_10)                    $(13_10)                } else if (!_verificar_agora) {$(13_10)                    array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));$(13_10)                    if (missao_id == "missao_angelique_corredor") {$(13_10)                        array_push(_texto_escolhido, "(Continue procurando o ferro de passar nas salas próximas!)");$(13_10)                    } else {$(13_10)                        var _faltam = quantidade_necessaria - _completados;$(13_10)                        array_push(_texto_escolhido, "(Faltam " + string(_faltam) + " quizzes para eu avaliar sua nota.)");$(13_10)                    }$(13_10)                }$(13_10)            }$(13_10)$(13_10)            // ── Estado 2: pós missão ──$(13_10)            else if (estado == 2) {$(13_10)                array_copy(_texto_escolhido, 0, texto_pos_missao, 0, array_length(texto_pos_missao));$(13_10)            }$(13_10)$(13_10)            global.status_missoes[$ missao_id] = estado;$(13_10)            global.dialogo = true;$(13_10)            $(13_10)            var _inst_dialogo = instance_create_depth(0, 0, -9999, Dialogo);$(13_10)            _inst_dialogo.texto = _texto_escolhido;$(13_10)            $(13_10)            if (variable_instance_exists(id, "nome")) {$(13_10)                _inst_dialogo.nomeNpc = nome;$(13_10)            } else {$(13_10)                _inst_dialogo.nomeNpc = "";$(13_10)            }$(13_10)        }$(13_10)    }$(13_10)    $(13_10)} else {$(13_10)    if (balao_e != noone) {$(13_10)        instance_destroy(balao_e);$(13_10)        balao_e = noone;$(13_10)    }$(13_10)}"
if (!visible) exit;

// =========================================================================
// --- SISTEMA AUTOMÁTICO DE OBJETIVOS DA HUD (FLUXO EM TEMPO REAL) ---
if (variable_instance_exists(id, "missao_id") && missao_id != "") {

    // Contagem reutilizada nos estados -1 e 1
    var _contagem_hud = 0;
    for (var i = 0; i < array_length(alvos_area); i++) {
        if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) 
            && global.quizzes_concluidos[$ alvos_area[i]] == true) {
            _contagem_hud++;
        }
    }

    // Calcula taxa de acerto atual para mostrar no objetivo (só Jerome)
    var _taxa_hud = 0;
    if (_contagem_hud > 0) {
        var _erros_hud = 0;
        for (var i = 0; i < array_length(alvos_area); i++) {
            if (variable_struct_exists(global.erros_quiz, alvos_area[i])) {
                _erros_hud += global.erros_quiz[$ alvos_area[i]];
            }
        }
        var _tent_hud = _contagem_hud + _erros_hud;
        if (_tent_hud > 0) _taxa_hud = round((_contagem_hud / _tent_hud) * 100);
    }

    // -1 = falhou, refazendo
    if (estado == -1) {
        if (missao_id == "missao_angelique_corredor") {
            if (_contagem_hud < quantidade_necessaria) {
                global.objetivo_atual = "Missão: Continue procurando o ferro de passar!";
            } else {
                global.objetivo_atual = "Missão: Fale com a Angélique novamente";
            }
        } else {
            if (_contagem_hud < quantidade_necessaria) {
                global.objetivo_atual = "Missão: Resolva os quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ") — Acerto atual: " + string(_taxa_hud) + "%";
            } else {
                global.objetivo_atual = "Missão: Fale com o Jerome novamente — Acerto: " + string(_taxa_hud) + "%";
            }
        }
    }

    // 0 = ainda não falou
    else if (estado == 0) {
        if (missao_id == "missao_angelique_corredor") {
            global.objetivo_atual = "Objetivo: Fale com a Angélique";
        } else {
            global.objetivo_atual = "Objetivo: Fale com o Jerome";
        }
    }

    // 1 = em andamento
    else if (estado == 1) {
        if (missao_id == "missao_angelique_corredor") {
            if (_contagem_hud < quantidade_necessaria) {
                global.objetivo_atual = "Missão: Ache o ferro de passar nas salas próximas!";
            } else {
                global.objetivo_atual = "Missão: Fale com a Angélique novamente";
            }
        } else {
            if (_contagem_hud < quantidade_necessaria) {
                global.objetivo_atual = "Missão: Resolva os quizzes (" + string(_contagem_hud) + "/" + string(quantidade_necessaria) + ") — Acerto atual: " + string(_taxa_hud) + "%";
            } else {
                global.objetivo_atual = "Missão: Fale com o Jerome novamente — Acerto: " + string(_taxa_hud) + "%";
            }
        }
    }

    // 2 = concluída
    else if (estado == 2) {
        if (missao_id == "missao_angelique_corredor") {
            global.objetivo_atual = "Missão concluída! Continue explorando.";
        } else {
            global.objetivo_atual = "Siga para o Ateliê, a Angélique precisa de ajuda";
        }
    }
}
// =========================================================================


if (collision_circle(x, y, global.range, Player, false, true)) {
    
    if (balao_e == noone) {
        balao_e = instance_create_depth(x, y, -9999, interacao);
        var largura_balao = balao_e.sprite_width;
        var altura_balao = balao_e.sprite_height;
        balao_e.x = x + (sprite_width / 2) - sprite_xoffset - (largura_balao / 2) + balao_e.sprite_xoffset;
        balao_e.y = bbox_top - altura_balao - 20; 
    }
  
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        if (variable_instance_exists(id, "missao_id") && missao_id != "") {
            
            if (!variable_global_exists("status_missoes")) global.status_missoes = {};
            if (!variable_global_exists("erros_quiz"))    global.erros_quiz = {};

            var _texto_escolhido = [];
            var _verificar_agora = false;

            // ── Estado -1: falhou antes ──
            if (estado == -1) {
                var _completados_check = 0;
                for (var i = 0; i < array_length(alvos_area); i++) {
                    if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) 
                        && global.quizzes_concluidos[$ alvos_area[i]] == true) {
                        _completados_check++;
                    }
                }
                if (_completados_check >= quantidade_necessaria) {
                    estado = 1;
                    _verificar_agora = true;
                } else {
                    array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));
                    if (missao_id == "missao_angelique_corredor") {
                        array_push(_texto_escolhido, "(Continue procurando o ferro de passar nas salas próximas!)");
                    } else {
                        array_push(_texto_escolhido, "(Você completou " + string(_completados_check) + "/" + string(quantidade_necessaria) + " quizzes. Faltam " + string(quantidade_necessaria - _completados_check) + ".)");
                    }
                    // estado permanece -1
                }
            }

            // ── Estado 0: primeira vez ──
            else if (estado == 0) {
                array_copy(_texto_escolhido, 0, texto_inicio, 0, array_length(texto_inicio)); 
                estado = 1; 
            }

            // ── Estado 1: verificar quizzes (ou forçado pelo -1 com _verificar_agora) ──
            if (estado == 1 && (array_length(_texto_escolhido) == 0 || _verificar_agora)) {
                var _completados = 0;
                for (var i = 0; i < array_length(alvos_area); i++) {
                    if (variable_struct_exists(global.quizzes_concluidos, alvos_area[i]) 
                        && global.quizzes_concluidos[$ alvos_area[i]] == true) {
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
                        // ── APROVADO ──
                        array_copy(_texto_escolhido, 0, texto_concluido, 0, array_length(texto_concluido));
                        array_push(_texto_escolhido, "(Sua taxa de acerto foi: " + string(round(_taxa_acerto)) + "% - Aprovado!)");
                        estado = 2;
                        
                        // Quadro: só para a Angélique
                        if (missao_id == "missao_angelique_corredor") {
                            if (!variable_struct_exists(global.quadros_coletados, "missao_angelique")
                                || global.quadros_coletados[$ "missao_angelique"] == false) {
                                global.quadros_coletados[$ "missao_angelique"] = true;
                                var _popup = instance_create_depth(0, 0, -9999, obj_popup_quadro);
                                _popup.sala_id = "missao_angelique";
                            }
                        }
                        if (instance_exists(obj_hud)) {
                            obj_hud.flash_botao  = 0;
                            obj_hud.flash_timer  = room_speed * 3;
                            obj_hud.missao_timer = room_speed * 10;
                        }
                        
                    } else {
                        // ── REPROVADO ──
                        array_copy(_texto_escolhido, 0, texto_falha, 0, array_length(texto_falha));
                        array_insert(_texto_escolhido, 1, "(Você acertou " + string(round(_taxa_acerto)) + "%. O mínimo exigido é " + string(taxa_minima) + "%.)");
                        estado = -1;
                        global.status_missoes[$ missao_id] = -1;
                        // Só zera os erros, NÃO remove quizzes_concluidos
                        for (var i = 0; i < array_length(alvos_area); i++) {
                            var _alvo = alvos_area[i];
                            variable_struct_remove(global.erros_quiz, _alvo);
                        }
                    }
                    
                } else if (!_verificar_agora) {
                    array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));
                    if (missao_id == "missao_angelique_corredor") {
                        array_push(_texto_escolhido, "(Continue procurando o ferro de passar nas salas próximas!)");
                    } else {
                        var _faltam = quantidade_necessaria - _completados;
                        array_push(_texto_escolhido, "(Faltam " + string(_faltam) + " quizzes para eu avaliar sua nota.)");
                    }
                }
            }

            // ── Estado 2: pós missão ──
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