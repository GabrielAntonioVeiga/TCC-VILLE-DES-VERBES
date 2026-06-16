/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 06D570F1
/// @DnDArgument : "code" "if (variable_instance_exists(id, "pergunta_id")) {$(13_10)    if (is_array(pergunta_id)) {$(13_10)        $(13_10)        var _inst = instance_nearest(x, y, ObjObstaculoQuiz);$(13_10)        $(13_10)        // Garante que o móvel existe, que tem a variável E que ele REALMENTE é uma Array!$(13_10)        if (instance_exists(_inst) && variable_instance_exists(_inst, "meu_quiz_id") && is_array(_inst.meu_quiz_id)) {$(13_10)            $(13_10)            if (!variable_instance_exists(_inst, "quiz_sorteado_fixo")) {$(13_10)                var _s = irandom(array_length(_inst.meu_quiz_id) - 1);$(13_10)                _inst.quiz_sorteado_fixo = _inst.meu_quiz_id[_s];$(13_10)            }$(13_10)            pergunta_id = _inst.quiz_sorteado_fixo; $(13_10)            $(13_10)        } else {$(13_10)            // PLANO B: Se por acaso ele estiver perto de outro móvel comum,$(13_10)            // ele ignora o móvel e faz o sorteio direto da lista que recebeu!$(13_10)            var _sorteio_emergencia = irandom(array_length(pergunta_id) - 1);$(13_10)            pergunta_id = pergunta_id[_sorteio_emergencia]; $(13_10)        }$(13_10)    }$(13_10)}$(13_10)if (variable_instance_exists(id, "pergunta_id") && variable_struct_exists(global.dados_quiz, pergunta_id)) {$(13_10)    $(13_10)    // 1. Pega a lista de tempos verbais do móvel (Ex: Présent, Passé, Futur)$(13_10)    var lista_tempos = global.dados_quiz[$ pergunta_id];$(13_10)    $(13_10)    if (is_array(lista_tempos) && array_length(lista_tempos) > 0) {$(13_10)        $(13_10)        var s_tempo = 0;$(13_10)        var s_pronome = 0;$(13_10)        $(13_10)        // 2. SISTEMA DE MEMÓRIA: Verifica se já existe um sorteio ativo para este móvel$(13_10)        if (variable_struct_exists(global.pergunta_atual_id, pergunta_id)) {$(13_10)            var dados_salvos = global.pergunta_atual_id[$ pergunta_id];$(13_10)            // Se os dados salvos forem uma struct válida com tempo e pronome$(13_10)            if (is_struct(dados_salvos) && variable_struct_exists(dados_salvos, "t") && variable_struct_exists(dados_salvos, "p")) {$(13_10)                s_tempo = dados_salvos.t;$(13_10)                s_pronome = dados_salvos.p;$(13_10)            }$(13_10)        } else {$(13_10)            // Se for a primeira vez interagindo, sorteia o tempo e o pronome!$(13_10)            s_tempo = irandom(array_length(lista_tempos) - 1);$(13_10)            $(13_10)            var bloco_tempo = lista_tempos[s_tempo];$(13_10)            if (variable_struct_exists(bloco_tempo, "variacoes") && is_array(bloco_tempo.variacoes)) {$(13_10)                s_pronome = irandom(array_length(bloco_tempo.variacoes) - 1);$(13_10)            }$(13_10)            $(13_10)            // Salva na memória global para manter a mesma pergunta até o jogador acertar$(13_10)            global.pergunta_atual_id[$ pergunta_id] = { t: s_tempo, p: s_pronome };$(13_10)        }$(13_10)        $(13_10)        // 3. EXTRAÇÃO DOS DADOS BASEADOS NO SORTEIO$(13_10)        var dados_tempo = lista_tempos[s_tempo];$(13_10)        var lista_variacoes = dados_tempo.variacoes;$(13_10)        var quiz_sorteado = lista_variacoes[s_pronome];$(13_10)        $(13_10)        // 4. PREENCHE AS VARIÁVEIS DA HUD DO QUIZ$(13_10)        quiz_id          = pergunta_id;$(13_10)        tempo_verbal     = string(dados_tempo.tempo_verbal);$(13_10)        verbo            = string(dados_tempo.verbo);$(13_10)        $(13_10)        nome_quiz        = variable_struct_exists(quiz_sorteado, "nome_quiz") ? quiz_sorteado.nome_quiz : "Quiz";$(13_10)        pergunta         = variable_struct_exists(quiz_sorteado, "frase") ? quiz_sorteado.frase : "";$(13_10)        opcoes           = variable_struct_exists(quiz_sorteado, "opcoes") ? quiz_sorteado.opcoes : [];$(13_10)        resposta_correta = variable_struct_exists(quiz_sorteado, "resposta_correta") ? quiz_sorteado.resposta_correta : 0;$(13_10)    }$(13_10)} else {$(13_10)    // Aviso de segurança caso o ID não bata com o JSON$(13_10)    pergunta = "Erro: Chave [" + string(pergunta_id) + "] não encontrada no JSON.";$(13_10)    opcoes = ["Revisar ID da Room"];$(13_10)    resposta_correta = 0;$(13_10)}$(13_10)$(13_10)// Reseta a máquina de escrever para começar a desenhar na tela$(13_10)caractere = 0;"
if (variable_instance_exists(id, "pergunta_id")) {
    if (is_array(pergunta_id)) {
        
        var _inst = instance_nearest(x, y, ObjObstaculoQuiz);
        
        // Garante que o móvel existe, que tem a variável E que ele REALMENTE é uma Array!
        if (instance_exists(_inst) && variable_instance_exists(_inst, "meu_quiz_id") && is_array(_inst.meu_quiz_id)) {
            
            if (!variable_instance_exists(_inst, "quiz_sorteado_fixo")) {
                var _s = irandom(array_length(_inst.meu_quiz_id) - 1);
                _inst.quiz_sorteado_fixo = _inst.meu_quiz_id[_s];
            }
            pergunta_id = _inst.quiz_sorteado_fixo; 
            
        } else {
            // PLANO B: Se por acaso ele estiver perto de outro móvel comum,
            // ele ignora o móvel e faz o sorteio direto da lista que recebeu!
            var _sorteio_emergencia = irandom(array_length(pergunta_id) - 1);
            pergunta_id = pergunta_id[_sorteio_emergencia]; 
        }
    }
}
if (variable_instance_exists(id, "pergunta_id") && variable_struct_exists(global.dados_quiz, pergunta_id)) {
    
    // 1. Pega a lista de tempos verbais do móvel (Ex: Présent, Passé, Futur)
    var lista_tempos = global.dados_quiz[$ pergunta_id];
    
    if (is_array(lista_tempos) && array_length(lista_tempos) > 0) {
        
        var s_tempo = 0;
        var s_pronome = 0;
        
        // 2. SISTEMA DE MEMÓRIA: Verifica se já existe um sorteio ativo para este móvel
        if (variable_struct_exists(global.pergunta_atual_id, pergunta_id)) {
            var dados_salvos = global.pergunta_atual_id[$ pergunta_id];
            // Se os dados salvos forem uma struct válida com tempo e pronome
            if (is_struct(dados_salvos) && variable_struct_exists(dados_salvos, "t") && variable_struct_exists(dados_salvos, "p")) {
                s_tempo = dados_salvos.t;
                s_pronome = dados_salvos.p;
            }
        } else {
            // Se for a primeira vez interagindo, sorteia o tempo e o pronome!
            s_tempo = irandom(array_length(lista_tempos) - 1);
            
            var bloco_tempo = lista_tempos[s_tempo];
            if (variable_struct_exists(bloco_tempo, "variacoes") && is_array(bloco_tempo.variacoes)) {
                s_pronome = irandom(array_length(bloco_tempo.variacoes) - 1);
            }
            
            // Salva na memória global para manter a mesma pergunta até o jogador acertar
            global.pergunta_atual_id[$ pergunta_id] = { t: s_tempo, p: s_pronome };
        }
        
        // 3. EXTRAÇÃO DOS DADOS BASEADOS NO SORTEIO
        var dados_tempo = lista_tempos[s_tempo];
        var lista_variacoes = dados_tempo.variacoes;
        var quiz_sorteado = lista_variacoes[s_pronome];
        
        // 4. PREENCHE AS VARIÁVEIS DA HUD DO QUIZ
        quiz_id          = pergunta_id;
        tempo_verbal     = string(dados_tempo.tempo_verbal);
        verbo            = string(dados_tempo.verbo);
        
        nome_quiz        = variable_struct_exists(quiz_sorteado, "nome_quiz") ? quiz_sorteado.nome_quiz : "Quiz";
        pergunta         = variable_struct_exists(quiz_sorteado, "frase") ? quiz_sorteado.frase : "";
        opcoes           = variable_struct_exists(quiz_sorteado, "opcoes") ? quiz_sorteado.opcoes : [];
        resposta_correta = variable_struct_exists(quiz_sorteado, "resposta_correta") ? quiz_sorteado.resposta_correta : 0;
    }
} else {
    // Aviso de segurança caso o ID não bata com o JSON
    pergunta = "Erro: Chave [" + string(pergunta_id) + "] não encontrada no JSON.";
    opcoes = ["Revisar ID da Room"];
    resposta_correta = 0;
}

// Reseta a máquina de escrever para começar a desenhar na tela
caractere = 0;