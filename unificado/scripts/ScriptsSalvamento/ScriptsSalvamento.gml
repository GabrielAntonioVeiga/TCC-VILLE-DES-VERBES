// -----------------------------
// ScriptsSalvamento
// -----------------------------

function criar_feedback(texto_msg) {
    if (!instance_exists(obj_feedback)) {
        var _fb = instance_create_depth(0, 0, -9999, obj_feedback);
        _fb.texto = texto_msg;
    } else {
        obj_feedback.texto = texto_msg;
        obj_feedback.alarm[0] = room_speed * 3;
        obj_feedback.alpha = 1;
    }
}

function _filename_for_slot(slot) {
    return "save" + string(slot) + ".json";
}

function _filename_for_temp_slot(slot) {
    return "save" + string(slot) + "_temp.json";
}

function salvar_jogo_slot(slot) {
    var estruturaSalvamento = {
        posicaoX:             Player.x,
        posicaoY:             Player.y,
        avatar:               Player.sprite_index,
        direcao:              Player.facing,
        cenario:              room_get_name(room),
        tempoJogado:          variable_global_exists("tempo_jogado")         ? global.tempo_jogado         : 0,
        quizzesConcluidos:    variable_global_exists("quizzes_concluidos")   ? global.quizzes_concluidos   : {},
        notasNotebook:        variable_global_exists("notas")                ? global.notas                : [],
        perguntasEmAndamento: variable_global_exists("pergunta_atual_id")    ? global.pergunta_atual_id    : {},
        portasDesbloqueadas:  variable_global_exists("portas_desbloqueadas") ? global.portas_desbloqueadas : {},
        // 🆕 novos campos
        quadrosColetados:     variable_global_exists("quadros_coletados")    ? global.quadros_coletados    : {},
        ambienteCompletado:   variable_global_exists("ambiente_completado")  ? global.ambiente_completado  : {},
        statusMissoes:        variable_global_exists("status_missoes")       ? global.status_missoes       : {}
    };

    var stringEstruturaSalvamento = json_stringify(estruturaSalvamento);
    var nomeArquivo = _filename_for_slot(slot);
    var fh = file_text_open_write(nomeArquivo);
    file_text_write_string(fh, stringEstruturaSalvamento);
    file_text_close(fh);

    ini_open("settings.ini");
    ini_write_real("save", "last_slot", slot);
    ini_close();

    criar_feedback("Jogo salvo com sucesso!");
    show_debug_message(nomeArquivo);
}

function carregar_jogo_slot(slot) {
    var nomeArquivo = _filename_for_slot(slot);
    if (!file_exists(nomeArquivo)) {
        criar_feedback("Slot " + string(slot+1) + " está vazio.");
        return false;
    }

    var fh = file_text_open_read(nomeArquivo);
    var conteudo = "";
    while (!file_text_eof(fh)) {
        conteudo += file_text_read_string(fh);
    }
    file_text_close(fh);

    var estruturaSalvamento = json_parse(conteudo);

    // Quizzes
    if (variable_struct_exists(estruturaSalvamento, "quizzesConcluidos")
        && is_struct(estruturaSalvamento.quizzesConcluidos)) {
        global.quizzes_concluidos = estruturaSalvamento.quizzesConcluidos;
    }
    // Notas
    if (variable_struct_exists(estruturaSalvamento, "notasNotebook")) {
        global.notas = estruturaSalvamento.notasNotebook;
    }
    // Perguntas em andamento
    if (variable_struct_exists(estruturaSalvamento, "perguntasEmAndamento")) {
        global.pergunta_atual_id = estruturaSalvamento.perguntasEmAndamento;
    }
    // Portas
    if (variable_struct_exists(estruturaSalvamento, "portasDesbloqueadas")
        && is_struct(estruturaSalvamento.portasDesbloqueadas)) {
        global.portas_desbloqueadas = estruturaSalvamento.portasDesbloqueadas;
    }
    // Tempo jogado
    if (variable_struct_exists(estruturaSalvamento, "tempoJogado")) {
        global.tempo_jogado = estruturaSalvamento.tempoJogado;
    } else {
        global.tempo_jogado = 0;
    }
    // 🆕 Quadros coletados
    if (variable_struct_exists(estruturaSalvamento, "quadrosColetados")
        && is_struct(estruturaSalvamento.quadrosColetados)) {
        global.quadros_coletados = estruturaSalvamento.quadrosColetados;
    } else {
        global.quadros_coletados = {
            rm_jantar: false, rm_atelie: false, rm_corredor: false,
            rm_lavanderia: false, rm_banheiro: false, rm_quarto: false,
            missao_angelique: false
        };
    }
    // 🆕 Ambiente completado
    if (variable_struct_exists(estruturaSalvamento, "ambienteCompletado")
        && is_struct(estruturaSalvamento.ambienteCompletado)) {
        global.ambiente_completado = estruturaSalvamento.ambienteCompletado;
    } else {
        global.ambiente_completado = {};
    }
    // 🆕 Status missões
    if (variable_struct_exists(estruturaSalvamento, "statusMissoes")
        && is_struct(estruturaSalvamento.statusMissoes)) {
        global.status_missoes = estruturaSalvamento.statusMissoes;
    } else {
        global.status_missoes = {};
    }

    if (instance_exists(Player)) {
        Player.x = estruturaSalvamento.posicaoX;
        Player.y = estruturaSalvamento.posicaoY;
        Player.sprite_index = estruturaSalvamento.avatar;
        Player.facing = estruturaSalvamento.direcao;
        var r_id = asset_get_index(estruturaSalvamento.cenario);
        if (r_id != -1 && r_id != room) room_goto(r_id);
    } else {
        global.loaded_save = estruturaSalvamento;
        room_goto(rm_jantar);
    }

    ini_open("settings.ini");
    ini_write_real("save", "last_slot", slot);
    ini_close();

    criar_feedback("Save carregado!");
    return true;
}

function apagar_save_slot(slot) {
    var nomeArquivo = _filename_for_slot(slot);
    if (file_exists(nomeArquivo)) file_delete(nomeArquivo);

    var temp_nomeArquivo = _filename_for_temp_slot(slot);
    if (file_exists(temp_nomeArquivo)) file_delete(temp_nomeArquivo);

    ini_open("settings.ini");
    var last = ini_read_real("save", "last_slot", 0);
    if (last == slot) ini_write_real("save", "last_slot", 0);
    ini_close();

    criar_feedback("Save apagado com sucesso.");
}

function salvar_jogo_temp(slot) {
    if (!variable_global_exists("save_slot")) return;
    if (!instance_exists(Player)) return;
    
    var estruturaSalvamento = {
        posicaoX:             Player.x,
        posicaoY:             Player.y,
        avatar:               Player.sprite_index,
        direcao:              Player.facing,
        cenario:              room_get_name(room),
        tempoJogado:          variable_global_exists("tempo_jogado")         ? global.tempo_jogado         : 0,
        quizzesConcluidos:    variable_global_exists("quizzes_concluidos")   ? global.quizzes_concluidos   : {},
        notasNotebook:        variable_global_exists("notas")                ? global.notas                : [],
        perguntasEmAndamento: variable_global_exists("pergunta_atual_id")    ? global.pergunta_atual_id    : {},
        portasDesbloqueadas:  variable_global_exists("portas_desbloqueadas") ? global.portas_desbloqueadas : {},
        // 🆕 novos campos
        quadrosColetados:     variable_global_exists("quadros_coletados")    ? global.quadros_coletados    : {},
        ambienteCompletado:   variable_global_exists("ambiente_completado")  ? global.ambiente_completado  : {},
        statusMissoes:        variable_global_exists("status_missoes")       ? global.status_missoes       : {}
    };

    var stringEstruturaSalvamento = json_stringify(estruturaSalvamento);
    var nomeArquivo = _filename_for_temp_slot(slot);
    var fh = file_text_open_write(nomeArquivo);
    file_text_write_string(fh, stringEstruturaSalvamento);
    file_text_close(fh);
}

function carregar_jogo_temp(slot) {
    var nomeArquivo = _filename_for_temp_slot(slot);
    if (!file_exists(nomeArquivo)) return false;

    var fh = file_text_open_read(nomeArquivo);
    var conteudo = "";
    while (!file_text_eof(fh)) {
        conteudo += file_text_read_string(fh);
    }
    file_text_close(fh);

    var estruturaSalvamento = json_parse(conteudo);

    // Quizzes
    if (variable_struct_exists(estruturaSalvamento, "quizzesConcluidos")
        && is_struct(estruturaSalvamento.quizzesConcluidos)) {
        global.quizzes_concluidos = estruturaSalvamento.quizzesConcluidos;
    }
    // Notas
    if (variable_struct_exists(estruturaSalvamento, "notasNotebook")) {
        global.notas = estruturaSalvamento.notasNotebook;
    }
    // Perguntas em andamento
    if (variable_struct_exists(estruturaSalvamento, "perguntasEmAndamento")) {
        global.pergunta_atual_id = estruturaSalvamento.perguntasEmAndamento;
    }
    // Portas
    if (variable_struct_exists(estruturaSalvamento, "portasDesbloqueadas")
        && is_struct(estruturaSalvamento.portasDesbloqueadas)) {
        global.portas_desbloqueadas = estruturaSalvamento.portasDesbloqueadas;
    }
    // Tempo jogado
    if (variable_struct_exists(estruturaSalvamento, "tempoJogado")) {
        global.tempo_jogado = estruturaSalvamento.tempoJogado;
    } else {
        global.tempo_jogado = 0;
    }
    // 🆕 Quadros coletados
    if (variable_struct_exists(estruturaSalvamento, "quadrosColetados")
        && is_struct(estruturaSalvamento.quadrosColetados)) {
        global.quadros_coletados = estruturaSalvamento.quadrosColetados;
    } else {
        global.quadros_coletados = {
            rm_jantar: false, rm_atelie: false, rm_corredor: false,
            rm_lavanderia: false, rm_banheiro: false, rm_quarto: false,
            missao_angelique: false
        };
    }
    // 🆕 Ambiente completado
    if (variable_struct_exists(estruturaSalvamento, "ambienteCompletado")
        && is_struct(estruturaSalvamento.ambienteCompletado)) {
        global.ambiente_completado = estruturaSalvamento.ambienteCompletado;
    } else {
        global.ambiente_completado = {};
    }
    // 🆕 Status missões
    if (variable_struct_exists(estruturaSalvamento, "statusMissoes")
        && is_struct(estruturaSalvamento.statusMissoes)) {
        global.status_missoes = estruturaSalvamento.statusMissoes;
    } else {
        global.status_missoes = {};
    }

    if (instance_exists(Player)) {
        Player.x = estruturaSalvamento.posicaoX;
        Player.y = estruturaSalvamento.posicaoY;
        Player.sprite_index = estruturaSalvamento.avatar;
        Player.facing = estruturaSalvamento.direcao;
        var r_id = asset_get_index(estruturaSalvamento.cenario);
        if (r_id != -1 && r_id != room) room_goto(r_id);
    } else {
        global.loaded_save = estruturaSalvamento;
        room_goto(rm_jantar);
    }

    if (file_exists(nomeArquivo)) file_delete(nomeArquivo);
    return true;
}

function existe_save_slot(slot) {
    return file_exists(_filename_for_slot(slot));
}

function salvar_jogo() {
    salvar_jogo_slot(0);
}