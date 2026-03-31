if (variable_global_exists("loaded_save")) {
    if (global.loaded_save != -1) {
        x = global.loaded_save.posicaoX;
        y = global.loaded_save.posicaoY;
        
        // Puxa a sprite q de fato ele deve carregar (se existir a variavel no dict)
        if (variable_struct_exists(global.loaded_save, "avatar")) {
            global.player_char = global.loaded_save.avatar;
            sprite_index = global.player_char;
        }

        if (variable_struct_exists(global.loaded_save, "direcao")) {
            facing = global.loaded_save.direcao;
        }
        
        // Previne dele carregar infinitamente na proxima troca de room
        global.loaded_save = -1; 
    }
}
