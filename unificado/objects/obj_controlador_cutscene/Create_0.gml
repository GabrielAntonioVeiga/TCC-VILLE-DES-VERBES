/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 01C60E0C
/// @DnDArgument : "code" "sprite_prefetch(sprite_index); //carrega a cutscene na VRAM pra que não trave$(13_10)image_speed = 0;$(13_10)image_index = 0;$(13_10)estado = "AGUARDANDO";$(13_10)tempo_de_espera = 120; //contando em fps (60 = 1 segundo)$(13_10)$(13_10)$(13_10)tempo_fade_final = 60; $(13_10)$(13_10)$(13_10)audio_sound_gain(Dance_macrabe, 1, 0); $(13_10)if (!audio_is_playing(Dance_macrabe)) {$(13_10)    audio_play_sound(Dance_macrabe, 1, true); $(13_10)}$(13_10)som_efeito_id = snd_TVG;"
sprite_prefetch(sprite_index); //carrega a cutscene na VRAM pra que não trave
image_speed = 0;
image_index = 0;
estado = "AGUARDANDO";
tempo_de_espera = 120; //contando em fps (60 = 1 segundo)


tempo_fade_final = 60; 


audio_sound_gain(Dance_macrabe, 1, 0); 
if (!audio_is_playing(Dance_macrabe)) {
    audio_play_sound(Dance_macrabe, 1, true); 
}
som_efeito_id = snd_TVG;