/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 3A76403B
/// @DnDArgument : "code" "// Identificação e Balão$(13_10)nome = "Jerome";$(13_10)balao_e = noone;$(13_10)meu_quiz_id = "";$(13_10)// Missão$(13_10)missao_id = "missao_jerome_jantar";$(13_10)alvos_area = [$(13_10)    "interacao_mesa_manger", "interacao_mesa_boire", "interacao_mesa_dejeuner",$(13_10)    "interacao_cadeira_asseoir", "interacao_vaso_casser", "interacao_radio_ecouter",$(13_10)    "interacao_tapecaria_regarder", "interacao_porta_entrer", "interacao_porta_sortir"$(13_10)];$(13_10)quantidade_necessaria = 3; $(13_10)$(13_10)// Textos (Transformados em Arrays para o seu sistema ler as páginas)$(13_10)texto_inicio = [$(13_10)    "Bienvenue! A Sala de Jantar tem muitos verbos escondidos.",$(13_10)    "Explore a mobília e complete pelo menos 3 quizzes para provar seu conhecimento."$(13_10)];$(13_10)$(13_10)texto_andamento = [$(13_10)    "Ainda explorando?",$(13_10)    "Lembre-se, preciso que você resolva pelo menos 3 interações nesta sala."$(13_10)];$(13_10)$(13_10)texto_concluido = [$(13_10)    "Magnifique! Você realmente prestou atenção aos detalhes.",$(13_10)    "Muito bem, você concluiu esta tarefa."$(13_10)];$(13_10)$(13_10)texto_pos_missao = [$(13_10)    "Fique à vontade para continuar praticando com os outros objetos, ou siga em frente."$(13_10)];$(13_10)taxa_minima = 70; // O jogador precisa de pelo menos 70% de acerto$(13_10)texto_falha = [$(13_10)    "Mon Dieu! Sua taxa de acerto foi muito baixa...", $(13_10)    "Você precisa de pelo menos 70% para passar.", $(13_10)    "Vou bagunçar as mobílias de novo. Refaça a missão com mais atenção!"$(13_10)];$(13_10)// Puxa a memória do Save$(13_10)estado = 0;$(13_10)if (variable_global_exists("status_missoes") && global.status_missoes[$ missao_id] != undefined) {$(13_10)    estado = global.status_missoes[$ missao_id];$(13_10)}$(13_10)$(13_10)"
// Identificação e Balão
nome = "Jerome";
balao_e = noone;
meu_quiz_id = "";
// Missão
missao_id = "missao_jerome_jantar";
alvos_area = [
    "interacao_mesa_manger", "interacao_mesa_boire", "interacao_mesa_dejeuner",
    "interacao_cadeira_asseoir", "interacao_vaso_casser", "interacao_radio_ecouter",
    "interacao_tapecaria_regarder", "interacao_porta_entrer", "interacao_porta_sortir"
];
quantidade_necessaria = 3; 

// Textos (Transformados em Arrays para o seu sistema ler as páginas)
texto_inicio = [
    "Bienvenue! A Sala de Jantar tem muitos verbos escondidos.",
    "Explore a mobília e complete pelo menos 3 quizzes para provar seu conhecimento."
];

texto_andamento = [
    "Ainda explorando?",
    "Lembre-se, preciso que você resolva pelo menos 3 interações nesta sala."
];

texto_concluido = [
    "Magnifique! Você realmente prestou atenção aos detalhes.",
    "Muito bem, você concluiu esta tarefa."
];

texto_pos_missao = [
    "Fique à vontade para continuar praticando com os outros objetos, ou siga em frente."
];
taxa_minima = 70; // O jogador precisa de pelo menos 70% de acerto
texto_falha = [
    "Mon Dieu! Sua taxa de acerto foi muito baixa...", 
    "Você precisa de pelo menos 70% para passar.", 
    "Vou bagunçar as mobílias de novo. Refaça a missão com mais atenção!"
];
// Puxa a memória do Save
estado = 0;
if (variable_global_exists("status_missoes") && global.status_missoes[$ missao_id] != undefined) {
    estado = global.status_missoes[$ missao_id];
}