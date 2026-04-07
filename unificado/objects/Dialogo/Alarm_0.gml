if inicializar == true {
    if caractere < string_length(texto[pagina]) {
        caractere++;
        var spd = variable_global_exists("text_speed") ? global.text_speed : 2;
        alarm[0] = spd;
        
        // RNF067: Blip sound on letters
        var snd = asset_get_index("snd_blip");
        if (snd != -1) {
            audio_play_sound(snd, 1, false);
        }
    }
}
