/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 01C60E0C
/// @DnDArgument : "code" "sprite_prefetch(sprite_index); //força o carregamento da VRAM para não travar$(13_10)image_speed = 0;       // Congela a animação$(13_10)image_index = 0;       // Garante que está no 1º frame (índice 0)$(13_10)$(13_10)estado = "AGUARDANDO";$(13_10)tempo_de_espera = 120;  // medido em frames por segundo (60 fps)$(13_10)$(13_10)som_efeito_id = snd_TVG; //efeito sonoro$(13_10)$(13_10)if (!audio_is_playing(Dance_macrabe)) { //musica de fundo$(13_10)    audio_play_sound(Dance_macrabe, 1, true); $(13_10)}$(13_10)"
sprite_prefetch(sprite_index); //força o carregamento da VRAM para não travar
image_speed = 0;       // Congela a animação
image_index = 0;       // Garante que está no 1º frame (índice 0)

estado = "AGUARDANDO";
tempo_de_espera = 120;  // medido em frames por segundo (60 fps)

som_efeito_id = snd_TVG; //efeito sonoro

if (!audio_is_playing(Dance_macrabe)) { //musica de fundo
    audio_play_sound(Dance_macrabe, 1, true); 
}