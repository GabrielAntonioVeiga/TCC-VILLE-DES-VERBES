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

function _filename_for_config() {
    return "configuracoes.json";
}

function carregar_configuracoes() {
    if (!variable_global_exists("volume")) global.volume = 1;
    if (!variable_global_exists("text_speed")) global.text_speed = 2;
    if (!variable_global_exists("language")) global.language = "pt";
    if (!variable_global_exists("fullscreen")) global.fullscreen = false;

    var nomeArquivo = _filename_for_config();
    if (file_exists(nomeArquivo)) {
        var fh = file_text_open_read(nomeArquivo);
        var conteudo = "";
        while (!file_text_eof(fh)) {
            conteudo += file_text_read_string(fh);
        }
        file_text_close(fh);

        var cfg = json_parse(conteudo);
        if (is_struct(cfg)) {
            if (variable_struct_exists(cfg, "volume")) global.volume = clamp(cfg.volume, 0, 1);
            if (variable_struct_exists(cfg, "text_speed")) global.text_speed = cfg.text_speed;
            if (variable_struct_exists(cfg, "language")) global.language = cfg.language;
            if (variable_struct_exists(cfg, "fullscreen")) global.fullscreen = cfg.fullscreen;
        }
    } else {
        ini_open("settings.ini");
        global.volume = clamp(ini_read_real("config", "volume", global.volume), 0, 1);
        global.text_speed = ini_read_real("config", "text_speed", global.text_speed);
        global.language = ini_read_string("config", "language", global.language);
        global.fullscreen = ini_read_real("config", "fullscreen", global.fullscreen ? 1 : 0) == 1;
        ini_close();
    }

    if (global.text_speed != 1 && global.text_speed != 2 && global.text_speed != 4) {
        global.text_speed = 2;
    }
    if (global.language != "pt" && global.language != "fr") {
        global.language = "pt";
    }

    audio_master_gain(global.volume);
    window_set_fullscreen(global.fullscreen);
}

function salvar_configuracoes() {
    var nomeArquivo = _filename_for_config();
    var cfg = {
        volume:     global.volume,
        text_speed: global.text_speed,
        language:   global.language,
        fullscreen: global.fullscreen
    };

    var fh = file_text_open_write(nomeArquivo);
    file_text_write_string(fh, json_stringify(cfg));
    file_text_close(fh);
}

function aplicar_configuracoes_salvas(estruturaSalvamento) {
    carregar_configuracoes();

    if (variable_struct_exists(estruturaSalvamento, "configuracoes") && is_struct(estruturaSalvamento.configuracoes)) {
        var cfg = estruturaSalvamento.configuracoes;
        if (variable_struct_exists(cfg, "volume")) global.volume = clamp(cfg.volume, 0, 1);
        if (variable_struct_exists(cfg, "text_speed")) global.text_speed = cfg.text_speed;
        if (variable_struct_exists(cfg, "language")) global.language = cfg.language;
        if (variable_struct_exists(cfg, "fullscreen")) global.fullscreen = cfg.fullscreen;
    }

    if (global.text_speed != 1 && global.text_speed != 2 && global.text_speed != 4) {
        global.text_speed = 2;
    }
    if (global.language != "pt" && global.language != "fr") {
        global.language = "pt";
    }

    audio_master_gain(global.volume);
    window_set_fullscreen(global.fullscreen);
    salvar_configuracoes();
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
        avatar:               sprite_get_name(Player.sprite_index),
		personagem:           global.player_char,
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

    aplicar_configuracoes_salvas(estruturaSalvamento);

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
		if (variable_struct_exists(estruturaSalvamento, "personagem")) {
            global.player_char = estruturaSalvamento.personagem;
        }
        var id_avatar = asset_get_index(estruturaSalvamento.avatar);
		if (id_avatar != -1){
			Player.sprite_index = id_avatar;
		}
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
        avatar:               sprite_get_name(Player.sprite_index),
		personagem:           global.player_char,
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

    aplicar_configuracoes_salvas(estruturaSalvamento);

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
		if (variable_struct_exists(estruturaSalvamento, "personagem")) {
            global.player_char = estruturaSalvamento.personagem;
        }
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