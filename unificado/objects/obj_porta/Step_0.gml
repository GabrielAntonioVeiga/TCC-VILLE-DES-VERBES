// RF006 & RF029 - Troca de Sala & Livre movimentação entre cenas desbloqueadas
if (instance_exists(Player)) {
    if (point_distance(x, y, Player.x, Player.y) < distancia_interacao) {
        if (keyboard_check_pressed(ord("E"))) {
			// Voltar para false e descomentar regra de bloqueio
            var can_transition = true;
            
            // RF029 Regra de Desbloqueio: checa TODOS os quizzes da sala
			/*
            if (desbloqueada) {
                can_transition = true;
            } else {
                // Verifica se existem quizzes na sala
                var total_quizzes = instance_number(ObjObstaculoQuiz);
                
                if (total_quizzes == 0) {
                    // Sem quizzes na sala = porta livre
                    can_transition = true;
                } else if (variable_global_exists("quizzes_concluidos")) {
                    var quizzes_feitos = 0;
                    
                    // Itera sobre todas as instâncias de ObjObstaculoQuiz na sala
                    for (var i = 0; i < total_quizzes; i++) {
                        var inst = instance_find(ObjObstaculoQuiz, i);
                        if (variable_instance_exists(inst, "quiz_id")) {
                            var qid = inst.quiz_id;
                            if (variable_struct_exists(global.quizzes_concluidos, qid)) {
                                if (global.quizzes_concluidos[$ qid] == true) {
                                    quizzes_feitos++;
                                }
                            }
                        }
                    }
                    
                    // Só libera se TODOS foram completados
                    if (quizzes_feitos >= total_quizzes) {
                        can_transition = true;
                        desbloqueada = true;
                        // Salva o desbloqueio na global persistente
                        global.portas_desbloqueadas[$ porta_id] = true;
                    }
                }
            }
			*/
            
            if (can_transition) {
                var inst_trans = instance_create_depth(0, 0, -9999, obj_transicao);
                inst_trans.target_room = target_room;
                inst_trans.source_room = room;
                inst_trans.target_x = target_x;
                inst_trans.target_y = target_y;
                
                var snd = asset_get_index("snd_porta");
                if (snd != -1) audio_play_sound(snd, 1, false);
            } else {
                if (!instance_exists(obj_porta_aviso)) {
                    instance_create_depth(0, 0, -9999, obj_porta_aviso);
                }
            }
        }
    }
}
