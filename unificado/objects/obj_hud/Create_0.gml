state = "closed";
mission_open = false; 
hud_buttons = ["Missão", "Álbum", "Notas", "Config.", "Salvar", "Sair"];
lista_quadros = [
    { sala_id: "rm_atelie",     nome: "Ateliê de Pintura" },
    { sala_id: "rm_quarto",     nome: "Quarto Principal" },
    { sala_id: "rm_corredor",   nome: "Corredor" },
    { sala_id: "rm_jantar",     nome: "Sala de Jantar" },
    { sala_id: "rm_lavanderia", nome: "Lavanderia" },
    { sala_id: "rm_banheiro",   nome: "Banheiro" } 
];
pagina_notas     = 0;
itens_por_pagina = 3;
pagina_album     = 0;
filtro_pronome   = 0;


missao_timer = 0;


flash_botao = -1;
flash_timer = 0;


_sala_anterior = "";