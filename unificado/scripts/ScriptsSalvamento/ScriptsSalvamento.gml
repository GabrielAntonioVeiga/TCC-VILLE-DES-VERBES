// -----------------------------
// ScriptsSalvamento (colocar aqui)
// -----------------------------

function _filename_for_slot(slot) {
    return "save" + string(slot) + ".txt";
}

function salvar_jogo_slot(slot) {
    // adapte os campos abaixo aos dados reais do seu jogo
    var estruturaSalvamento = {
        posicaoX: Player.x,
        posicaoY: Player.y,
        avatar: Player.sprite_index,
        direcao: Player.facing,
        cenario: "Cenario",
        colecionaveisAdquiridos: "Colecionaveis",
        quizzesConcluidos: "Quizzes"
    };

    var stringEstruturaSalvamento = json_stringify(estruturaSalvamento); // ou json_encode

    var nomeArquivo = _filename_for_slot(slot);
    var fh = file_text_open_write(nomeArquivo);
    file_text_write_string(fh, stringEstruturaSalvamento);
    file_text_close(fh);

    // marca último slot usado (para "Continuar")
    ini_open("settings.ini");
    ini_write_real("save","last_slot", slot);
    ini_close();

    show_message("Jogo salvo no Slot " + string(slot));
    //audio_play_sound(global.snd_confirm,1,false);
}

function carregar_jogo_slot(slot) {
    var nomeArquivo = _filename_for_slot(slot);
    if (!file_exists(nomeArquivo)) {
        show_message("Slot " + string(slot) + " está vazio.");
        audio_play_sound(global.snd_error,1,false);
        return false;
    }

    var fh = file_text_open_read(nomeArquivo);
    var conteudo = "";
    // lê o arquivo inteiro com segurança
    while (!file_text_eof(fh)) {
        conteudo += file_text_read_string(fh);
    }
    file_text_close(fh);

    var estruturaSalvamento = json_parse(conteudo); // ou json_decode

    // se Player existe agora, aplica imediatamente; se não, guarda em global para aplicar no Room Start
    if (instance_exists(Player)) {
        Player.x = estruturaSalvamento.posicaoX;
        Player.y = estruturaSalvamento.posicaoY;
        Player.sprite_index = estruturaSalvamento.avatar;
        Player.facing = estruturaSalvamento.direcao;
    } else {
        global.loaded_save = estruturaSalvamento;
    }

    // marca último slot como carregado (útil)
    ini_open("settings.ini");
    ini_write_real("save","last_slot", slot);
    ini_close();

    show_message("Save carregado do Slot " + string(slot));
    //audio_play_sound(global.snd_confirm,1,false);
    return true;
}

function apagar_save_slot(slot) {
    var nomeArquivo = _filename_for_slot(slot);
    if (file_exists(nomeArquivo)) file_delete(nomeArquivo);

    ini_open("settings.ini");
    var last = ini_read_real("save","last_slot",0);
    if (last == slot) ini_write_real("save","last_slot",0);
    ini_close();

    show_message("Save apagado (Slot " + string(slot) + ")");
    audio_play_sound(global.snd_confirm,1,false);
}

function existe_save_slot(slot) {
    return file_exists(_filename_for_slot(slot));
}

// compatibilidade: se você quiser manter a função salvar_jogo() antiga:
function salvar_jogo() {
    salvar_jogo_slot(1); // salva no slot 1 por padrão
}