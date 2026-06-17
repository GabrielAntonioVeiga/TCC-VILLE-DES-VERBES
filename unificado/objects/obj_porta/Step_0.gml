if (!instance_exists(Player)) exit;

var _dist = point_distance(x, y, Player.x, Player.y);

if (_dist <= distancia_interacao) {

    // Balão de interação (mantém seu sistema já existente)
    // [seu código de balão_e aqui, se aplicável]

    if (keyboard_check_pressed(ord("E")) && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {

        var _pode_abrir = false;

        // ── Já foi desbloqueada antes (RF029 - livre circulação)
        if (desbloqueada) {
            _pode_abrir = true;

        // ── Regra: missão de NPC concluída
        } else if (tipo_de_tranca == "missao") {
            if (variable_global_exists("status_missoes")
                && variable_struct_exists(global.status_missoes, id_da_missao)
                && global.status_missoes[$ id_da_missao] >= 2) {
                _pode_abrir = true;
            }

        // ── Regra: 100% da sala atual completada
        } else if (tipo_de_tranca == "ambiente_100") {
            var _sala = (id_da_sala != "") ? id_da_sala : room_get_name(room);
            if (variable_global_exists("ambiente_completado")
                && variable_struct_exists(global.ambiente_completado, _sala)
                && global.ambiente_completado[$ _sala] == true) {
                _pode_abrir = true;
            }

        // ── Sem tranca
        } else {
            _pode_abrir = true;
        }

        if (_pode_abrir) {
            // Persiste o desbloqueio e usa o sistema de transição correto
            desbloqueada = true;
            if (variable_global_exists("portas_desbloqueadas")) {
                global.portas_desbloqueadas[$ room_get_name(room) + "_" + string(id)] = true;
            }
            var inst = instance_create_depth(0, 0, -9999, obj_transicao);
            inst.target_room  = target_room;
            inst.target_x     = target_x;
            inst.target_y     = target_y;
            inst.source_room  = room;
            var snd = asset_get_index("snd_porta");
            if (snd != -1) audio_play_sound(snd, 1, false);

        } else {
            // Feedback narrativo por tipo de trava (RNF048)
            if (!instance_exists(obj_porta_aviso)) {
                var _aviso = instance_create_depth(0, 0, -9999, obj_porta_aviso);
                if (tipo_de_tranca == "missao") {
                    _aviso.mensagem = "Jacques ainda quer anotar mais verbos...";
                } else {
                    _aviso.mensagem = "Francine quer que você conheça tudo desta sala antes de ir.";
                }
            }
        }
    }
}