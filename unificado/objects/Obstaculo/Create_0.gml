// Identificação e Balão
nome = "Jerome";
balao_e = noone;

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

// Puxa a memória do Save
estado = 0;
if (variable_global_exists("status_missoes") && global.status_missoes[$ missao_id] != undefined) {
    estado = global.status_missoes[$ missao_id];
}