// quantidade de sl// Create - Salvamento
slots = 3; // ou global.SAVE_SLOTS se você definiu
slot_selecionado = 1;
slot_items = [];
for (var s = 1; s <= slots; s++) {
    slot_items[s-1] = { slot: s, exists: existe_save_slot(s) };
}