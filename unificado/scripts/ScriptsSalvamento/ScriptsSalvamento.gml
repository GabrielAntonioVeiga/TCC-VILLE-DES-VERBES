// -----------------------------
// ScriptsSalvamento (colocar aqui)
// -----------------------------

function criar_feedback(texto_msg) {
    if (!instance_exists(obj_feedback)) {
        var _fb = instance_create_depth(0, 0, -9999, obj_feedback);
        _fb.texto = texto_msg;
    } else {
        obj_feedback.texto = texto_msg;
        obj_feedback.alarm[0] = room_speed * 3; // Reseta o timer
        obj_feedback.alpha = 1;
    }
}

function _filename_for_slot(slot) {
    return "save" + string(slot) + ".json";
}

function salvar_jogo_slot(slot) {
    var estruturaSalvamento = {
        posicaoX: Player.x,
        posicaoY: Player.y,
        avatar: Player.sprite_index,
        direcao: Player.facing,
        cenario: room_get_name(room),
        colecionaveisAdquiridos: "Colecionaveis",
        quizzesConcluidos: variable_global_exists("quizzes_concluidos") ? global.quizzes_concluidos : {},
        portasDesbloqueadas: variable_global_exists("portas_desbloqueadas") ? global.portas_desbloqueadas : {}
    };

    var stringEstruturaSalvamento = json_stringify(estruturaSalvamento);

    var nomeArquivo = _filename_for_slot(slot);
    var fh = file_text_open_write(nomeArquivo);
    file_text_write_string(fh, stringEstruturaSalvamento);
    file_text_close(fh);

    ini_open("settings.ini");
    ini_write_real("save","last_slot", slot);
    ini_close();

    criar_feedback("Jogo salvo com sucesso!");
	show_debug_message(nomeArquivo);
    //audio_play_sound(global.snd_confirm,1,false);
}

function carregar_jogo_slot(slot) {
    var nomeArquivo = _filename_for_slot(slot);
    if (!file_exists(nomeArquivo)) {
        criar_feedback("Slot " + string(slot+1) + " está vazio.");
        //audio_play_sound(global.snd_error,1,false);
        return false;
    }

    var fh = file_text_open_read(nomeArquivo);
    var conteudo = "";
    while (!file_text_eof(fh)) {
        conteudo += file_text_read_string(fh);
    }
    file_text_close(fh);

    var estruturaSalvamento = json_parse(conteudo);

    // Restaura quizzes concluídos
    if (variable_struct_exists(estruturaSalvamento, "quizzesConcluidos")) {
        if (is_struct(estruturaSalvamento.quizzesConcluidos)) {
            global.quizzes_concluidos = estruturaSalvamento.quizzesConcluidos;
        }
    }

    // Restaura portas desbloqueadas
    if (variable_struct_exists(estruturaSalvamento, "portasDesbloqueadas")) {
        if (is_struct(estruturaSalvamento.portasDesbloqueadas)) {
            global.portas_desbloqueadas = estruturaSalvamento.portasDesbloqueadas;
        }
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
        var r_id = asset_get_index(estruturaSalvamento.cenario);
        if (r_id != -1) room_goto(r_id);
    }

    ini_open("settings.ini");
    ini_write_real("save","last_slot", slot);
    ini_close();

    criar_feedback("Save carregado!");
    return true;
}

function apagar_save_slot(slot) {
    var nomeArquivo = _filename_for_slot(slot);
    if (file_exists(nomeArquivo)) file_delete(nomeArquivo);

    ini_open("settings.ini");
    var last = ini_read_real("save","last_slot",0);
    if (last == slot) ini_write_real("save","last_slot",0);
    ini_close();

    criar_feedback("Save apagado com sucesso.");
    //audio_play_sound(global.snd_confirm,1,false);
}

function existe_save_slot(slot) {
    return file_exists(_filename_for_slot(slot));
}

function salvar_jogo() {
    salvar_jogo_slot(0); // usa 0 index pra alinhar as UI novas
}