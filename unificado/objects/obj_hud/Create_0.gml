state = "closed"; // Pode ser "closed", "album" ou "notes"
mission_open = false; 

// Base RF015
hud_buttons = ["Missão", "Álbum", "Notas", "Config.", "Salvar", "Sair"];

// Dados de missao vazios para RF009
lista_quadros = [
    { sala_id: "rm_atelie",     nome: "Ateliê de Pintura" },
    { sala_id: "rm_quarto",     nome: "Quarto Principal" },
    { sala_id: "rm_corredor",   nome: "Corredor" },
    { sala_id: "rm_jantar",     nome: "Sala de Jantar" },
    { sala_id: "rm_lavanderia", nome: "Lavanderia" },
    { sala_id: "rm_banheiro",    nome: "Banheiro" } 
];

// ================= VARIÁVEIS NOVAS (ADICIONA ISTO) =================
pagina_notas = 0;      // Controla em que página do bloco de notas estamos
itens_por_pagina = 3;  // Define quantas notas aparecem de cada vez

pagina_album = 0;      // Controla em que página do álbum estamos