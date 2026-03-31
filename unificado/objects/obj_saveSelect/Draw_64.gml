draw_set_halign(fa_center);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (confirm_mode) {
    draw_set_color(c_red);
    draw_text(gui_w/2, gui_h/2 - 40, "Deseja realmente apagar o Slot " + string(delete_target+1) + " permanentemente?");
    
    draw_set_color(c_white);
    draw_text(gui_w/2, gui_h/2 + 20, "Aperte ENTER para confirmar");
    draw_text(gui_w/2, gui_h/2 + 60, "Aperte ESC para cancelar");
} else {
    if selected == slots //gambiarra
        draw_set_color(c_yellow);
        
    draw_text(gui_w/2, 200 + slots * 60, "Voltar");

    draw_set_color(c_white);
    draw_text(gui_w/2, 100, "Seleção de Save");

    for(var i=0; i<slots; i++)
    {
        var txt = "Slot " + string(i+1) + " - ";

        if file_exists("save"+string(i)+".sav")
            txt += "Carregar Jogo";
        else
            txt += "Novo Jogo";

        if i == selected
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);

        draw_text(gui_w/2, 200 + i * 60, txt);
        
        if (i == selected && file_exists("save"+string(i)+".sav")) {
            draw_set_color(c_red);
            draw_text(gui_w/2 + 250, 200 + i * 60, "[DEL/Botão Direito] Apagar");
        }
    }
}
draw_set_color(c_white); //gambiarra


