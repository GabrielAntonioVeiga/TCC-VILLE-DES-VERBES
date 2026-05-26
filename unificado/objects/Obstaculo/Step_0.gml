
if (!visible) exit;

if (collision_circle(x, y, global.range, Player, false, true)) {
    
  
    if (balao_e == noone) {
        balao_e = instance_create_layer(x, y, "interacao", interacao);
        var largura_balao = balao_e.sprite_width;
        var altura_balao = balao_e.sprite_height;
        balao_e.x = x + (sprite_width / 2) - sprite_xoffset - (largura_balao / 2) + balao_e.sprite_xoffset;
        balao_e.y = bbox_top - altura_balao - 20; 
    }
  
    
   
  if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        var _texto_escolhido = []; 

        if (estado == 0) {
            _texto_escolhido = texto_inicio; 
            estado = 1; 
            global.objetivo_atual = "Missão: Complete pelo menos 3 quizzes na Sala de Jantar.";
        }
        else if (estado == 1) {
            var _completados = 0;
            
            for (var i = 0; i < array_length(alvos_area); i++) {
                if (global.quizzes_concluidos[$ alvos_area[i]] == true) {
                    _completados++;
                }
            }
            
            if (_completados >= quantidade_necessaria) {
                _texto_escolhido = texto_concluido;
                estado = 2;
                global.objetivo_atual = "Nenhum objetivo no momento. Explore livremente!";
            } else {
                array_copy(_texto_escolhido, 0, texto_andamento, 0, array_length(texto_andamento));
                var _faltam = quantidade_necessaria - _completados;
                array_push(_texto_escolhido, "(Faltam " + string(_faltam) + " quizzes para eu te liberar.)");
            }
        }
        else if (estado == 2) {
            _texto_escolhido = texto_pos_missao;
        }

        // SALVA O STATUS E CRIA O SEU OBJETO DE DIÁLOGO
        global.status_missoes[$ missao_id] = estado;
        global.dialogo = true;
        
        // 2ª CORREÇÃO: Trocamos obj_dialogo por Dialogo aqui na hora de criar também!
        var _inst_dialogo = instance_create_depth(0, 0, -9999, Dialogo);
        _inst_dialogo.texto = _texto_escolhido;
        _inst_dialogo.nomeNpc = nome;
    }
    
} else {
    // Destrói o balão se afastar
    if (balao_e != noone) {
        instance_destroy(balao_e);
        balao_e = noone;
    }
}