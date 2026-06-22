/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 75EB32B6
/// @DnDArgument : "code" "$(13_10)switch (estado) {$(13_10)    $(13_10)    // 1º Frame: Aguardando antes de começar$(13_10)    case "AGUARDANDO":$(13_10)        tempo_de_espera--;$(13_10)        $(13_10)        if (tempo_de_espera <= 0) {$(13_10)            image_speed = 1;$(13_10)            estado = "RODANDO";$(13_10)			som_efeito_id = audio_play_sound(snd_TVG, 2, false);$(13_10)        }$(13_10)        break;$(13_10)$(13_10)    case "RODANDO":$(13_10)        if (image_index >= (image_number - 1)) {$(13_10)            $(13_10)            image_speed = 0;         $(13_10)            image_index = image_number - 1;$(13_10)			if (audio_is_playing(som_efeito_id)) {$(13_10)                audio_sound_gain(som_efeito_id, 0, 1000);$(13_10)            }$(13_10)            $(13_10)			var caixa_texto = instance_create_layer(0, 0, "Instances", Dialogo);$(13_10)            caixa_texto.nomeNpc = "CutsceneIntro";$(13_10)			$(13_10)			estado = "FIM_PAUSADO";$(13_10)        }$(13_10)        break;$(13_10)$(13_10)    case "FIM_PAUSADO":$(13_10)        if (!instance_exists(Dialogo)) {$(13_10)            room_goto(rm_CharacterSelection);    $(13_10)        }$(13_10)        break;$(13_10)}"

switch (estado) {
    
    // 1º Frame: Aguardando antes de começar
    case "AGUARDANDO":
        tempo_de_espera--;
        
        if (tempo_de_espera <= 0) {
            image_speed = 1;
            estado = "RODANDO";
			som_efeito_id = audio_play_sound(snd_TVG, 2, false);
        }
        break;

    case "RODANDO":
        if (image_index >= (image_number - 1)) {
            
            image_speed = 0;         
            image_index = image_number - 1;
			if (audio_is_playing(som_efeito_id)) {
                audio_sound_gain(som_efeito_id, 0, 1000);
            }
            
			var caixa_texto = instance_create_layer(0, 0, "Instances", Dialogo);
            caixa_texto.nomeNpc = "CutsceneIntro";
			
			estado = "FIM_PAUSADO";
        }
        break;

    case "FIM_PAUSADO":
        if (!instance_exists(Dialogo)) {
            room_goto(rm_CharacterSelection);    
        }
        break;
}