/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 06D570F1
/// @DnDArgument : "code" "if (inicializar == true) {$(13_10)    // Escolhe qual texto está sendo digitado agora$(13_10)    var texto_atual = (estado == "perguntando") ? pergunta : mensagem_feedback;$(13_10)    $(13_10)    if (caractere < string_length(texto_atual)) {$(13_10)        caractere++;$(13_10)        alarm[0] = 1;$(13_10)    }$(13_10)}$(13_10)"
if (inicializar == true) {
    // Escolhe qual texto está sendo digitado agora
    var texto_atual = (estado == "perguntando") ? pergunta : mensagem_feedback;
    
    if (caractere < string_length(texto_atual)) {
        caractere++;
        alarm[0] = 1;
    }
}