slots = 3;

confirm_mode = false;
delete_target = -1;

// Layout
slot_w = 300;
slot_h = 220;
spacing = 40;
btn_w = 120;
btn_h = 40;

start_y = 250;

// Controle de clique
click_lock = false;

// Cache do tempo de jogo
slot_playtime = ["00:00:00", "00:00:00", "00:00:00"];
for (var i = 0; i < slots; i++) {
    var fname = "save" + string(i) + ".json";
    if (file_exists(fname)) {
        var fh = file_text_open_read(fname);
        var conteudo = "";
        while (!file_text_eof(fh)) {
            conteudo += file_text_read_string(fh);
        }
        file_text_close(fh);
        
        var json_data = -1;
        try {
            json_data = json_parse(conteudo);
        } catch(e) {
            json_data = -1;
        }
        
        var total_sec = 0;
        if (json_data != -1 && is_struct(json_data) && variable_struct_exists(json_data, "tempoJogado")) {
            total_sec = json_data.tempoJogado;
        }
        
        var hrs = floor(total_sec / 3600);
        var mins = floor((total_sec mod 3600) / 60);
        var secs = floor(total_sec mod 60);
        
        var str_hrs = (hrs < 10) ? ("0" + string(hrs)) : string(hrs);
        var str_mins = (mins < 10) ? ("0" + string(mins)) : string(mins);
        var str_secs = (secs < 10) ? ("0" + string(secs)) : string(secs);
        
        slot_playtime[i] = str_hrs + ":" + str_mins + ":" + str_secs;
    }
}