function ScriptsTextos() 
{
	switch nomeNpc{
		case "Obstaculo":
			texto[0] = "Eu sou um obstaculo";
			texto[1] = "Texto dois do obstaculo!";
			texto[2] = "Esse é o terceiro texto";
		break;
	
	case "CutsceneIntro":
            texto[0] = "O momento chegou...";
            texto[1] = "A partir daqui, não há volta.";
        break;
	}
}

function obter_string(chave) {
    if (!variable_global_exists("language")) {
        global.language = "pt";
    }

    var dict_pt = {
        "menu_iniciar": "Iniciar Jogo",
        "menu_config": "Configurações",
        "menu_creditos": "Créditos",
        "menu_sair": "Sair",
        "config_volume": "Volume",
        "config_velocidade": "Velocidade do Texto",
        "config_idioma": "Idioma",
        "config_telacheia": "Tela cheia",
        "config_voltar": "Voltar",
        "vazio_album": "Falta muito a estudar ainda",
        "sem_missao": "Nenhum objetivo por agora",
        "char_selection": "Selecione seu Personagem",
        
        // Tela de Save / Seleção de Jogo
        "save_selecao": "Seleção de Jogo",
        "save_slot": "Slot",
        "save_ativo": "Ativo",
        "save_vazio": "Vazio",
        "save_carregar": "Carregar",
        "save_apagar": "Apagar",
        "save_novo": "Novo Jogo",
        "save_tempo": "Tempo de jogo"
    };

    var dict_fr = {
        "menu_iniciar": "Commencer le jeu",
        "menu_config": "Paramètres",
        "menu_creditos": "Crédits",
        "menu_sair": "Quitter",
        "config_volume": "Volume",
        "config_velocidade": "Vitesse du texte",
        "config_idioma": "Langue",
        "config_telacheia": "Plein écran",
        "config_voltar": "Retour",
        "vazio_album": "Il reste encore beaucoup à étudier",
        "sem_missao": "Aucun objectif pour le moment",
        "char_selection": "Sélectionnez le personnage",
        "save_selecao": "Sélection de la partie",
        "save_slot": "Emplacement",
        "save_ativo": "Actif",
        "save_vazio": "Vide",
        "save_carregar": "Charger",
        "save_apagar": "Effacer",
        "save_novo": "Nouvelle partie",
        "save_tempo": "Temps de jeu"
    };

    var dict = (global.language == "fr") ? dict_fr : dict_pt;
    
    if (variable_struct_exists(dict, chave)) {
        return dict[$ chave];
    }
    return chave;
}