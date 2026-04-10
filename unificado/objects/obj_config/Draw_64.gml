draw_set_halign(fa_center);
draw_set_color(c_white);

var gui_w = display_get_gui_width();

draw_text(gui_w/2, 100, obter_string("menu_config"));

for(var i = 0; i < array_length(options); i++)
{
    if i == selected
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);

    var str_lang = (global.language == "pt") ? "Português" : "Français";
    var str_spd = (global.text_speed == 1) ? ((global.language == "pt") ? "Rápido" : "Rapide") : ((global.text_speed == 4) ? ((global.language == "pt") ? "Devagar" : "Lent") : ((global.language == "pt") ? "Normal" : "Normal"));
    
    var option_text = "";
    if (i == 0)      option_text = obter_string("config_volume") + "      <   " + string(round(global.volume * 100)) + "%   >";
    else if (i == 1) option_text = obter_string("config_velocidade") + "      <   " + str_spd + "   >";
    else if (i == 2) option_text = obter_string("config_idioma") + "      <   " + str_lang + "   >";
    else if (i == 3) option_text = obter_string("config_telacheia");
    else if (i == 4) option_text = obter_string("config_voltar");

    var bx = gui_w/2;
    var by = 200 + i * 65; // increased vertical spacing
    
    // Draw button background
    var w = 400; // button width half
    draw_set_alpha(0.6);
    if (i == selected) draw_set_color(c_dkgray);
    else draw_set_color(c_black);
    draw_roundrect(bx - 250, by - 25, bx + 250, by + 25, false);
    draw_set_alpha(1);
    
    // Draw text
    if (i == selected) draw_set_color(c_yellow);
    else draw_set_color(c_white);
    
    draw_text(bx, by - 10, option_text);
}
