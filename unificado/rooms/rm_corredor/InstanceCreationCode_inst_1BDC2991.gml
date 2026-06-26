/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 6C86E5E1
/// @DnDArgument : "code" "$(13_10)$(13_10)// 2. CONFIGURAÇÕES DA MISSÃO$(13_10)nome = "Angélique";$(13_10)missao_id = "missao_angelique_corredor";$(13_10)quantidade_necessaria = 1; // Ela só quer 1 objeto específico$(13_10)taxa_minima = 100; // Como é só 1 objeto, o jogador precisa acertar a interação$(13_10)$(13_10)// O alvo exato que o jogador precisa encontrar para ela$(13_10)alvos_area = ["interacao_ferro_repasser"];$(13_10)$(13_10)// 3. DIÁLOGOS (Com a lore da Kara!)$(13_10)texto_inicio = [$(13_10)    "Oh, você chegou! Preciso muito da sua ajuda.", $(13_10)    "Estou procurando o ferro de passar antigo para mostrar à minha filha, Kara.", $(13_10)    "Acho que deixei em uma destas três salas. Pode achar para mim?"$(13_10)];$(13_10)$(13_10)texto_andamento = [$(13_10)    "Conseguiu achar o ferro de passar antigo para a Kara?", $(13_10)    "Dê uma boa olhada nas salas aqui perto!"$(13_10)];$(13_10)$(13_10)texto_concluido = [$(13_10)    "Ah, merci beaucoup! Você encontrou!", $(13_10)    "A Kara vai adorar ver isso. Como agradecimento, fique com esta pintura especial!"$(13_10)];$(13_10)$(13_10)texto_pos_missao = [$(13_10)    "Obrigada de novo pela ajuda. Pode continuar sua exploração!"$(13_10)];$(13_10)$(13_10)texto_falha = [$(13_10)    "Ops, acho que você se confundiu nas palavras e pegou a coisa errada...", $(13_10)    "Concentre-se e tente novamente, por favor!"$(13_10)];$(13_10)$(13_10)// 4. ESTADO INICIAL$(13_10)estado = 0;$(13_10)$(13_10)sprite_index = angelique;"


// 2. CONFIGURAÇÕES DA MISSÃO
nome = "Angélique";
missao_id = "missao_angelique_corredor";
quantidade_necessaria = 1; // Ela só quer 1 objeto específico
taxa_minima = 100; // Como é só 1 objeto, o jogador precisa acertar a interação

// O alvo exato que o jogador precisa encontrar para ela
alvos_area = ["interacao_ferro_repasser"];

// 3. DIÁLOGOS (Com a lore da Kara!)
texto_inicio = [
    "Oh, você chegou! Preciso muito da sua ajuda.", 
    "Estou procurando o ferro de passar antigo para mostrar à minha filha, Kara.", 
    "Acho que deixei em uma destas três salas. Pode achar para mim?"
];

texto_andamento = [
    "Conseguiu achar o ferro de passar antigo para a Kara?", 
    "Dê uma boa olhada nas salas aqui perto!"
];

texto_concluido = [
    "Ah, merci beaucoup! Você encontrou!", 
    "A Kara vai adorar ver isso. Como agradecimento, fique com esta pintura especial!"
];

texto_pos_missao = [
    "Obrigada de novo pela ajuda. Pode continuar sua exploração!"
];

texto_falha = [
    "Ops, acho que você se confundiu nas palavras e pegou a coisa errada...", 
    "Concentre-se e tente novamente, por favor!"
];

// 4. ESTADO INICIAL
estado = 0;

sprite_index = angelique;