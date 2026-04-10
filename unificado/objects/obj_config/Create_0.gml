options = ["Volume", "Velocidade do Texto", "Idioma", "Tela cheia", "Voltar"];
selected = 0;

if (!variable_global_exists("volume")) global.volume = 1;

// RF020 - Velocidade do Texto (1 = Rápido, 2 = Normal, 4 = Lento)
if (!variable_global_exists("text_speed")) global.text_speed = 2;

// RF021 - Idioma (pt ou fr)
if (!variable_global_exists("language")) global.language = "pt";