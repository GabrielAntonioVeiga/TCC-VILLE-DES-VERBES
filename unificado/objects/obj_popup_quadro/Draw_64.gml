/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 63AD79D6
/// @DnDArgument : "code" "var gui_w = display_get_gui_width();$(13_10)var gui_h = display_get_gui_height();$(13_10)$(13_10)// Pega o sprite pelo sala_id$(13_10)var _spr = -1;$(13_10)if (variable_struct_exists(mapa_sprites, sala_id)) {$(13_10)    var _nome_spr = mapa_sprites[$ sala_id];$(13_10)    _spr = asset_get_index(_nome_spr);$(13_10)}$(13_10)$(13_10)draw_set_alpha(alpha);$(13_10)$(13_10)// Fundo do popup$(13_10)draw_set_color(c_black);$(13_10)draw_rectangle(gui_w - 340, gui_h - 180, gui_w - 20, gui_h - 20, false);$(13_10)draw_set_color(c_white);$(13_10)draw_rectangle(gui_w - 340, gui_h - 180, gui_w - 20, gui_h - 20, true);$(13_10)$(13_10)// Sprite do quadro (lado esquerdo do popup)$(13_10)if (_spr != -1) {$(13_10)    draw_sprite_stretched(_spr, 0, gui_w - 330, gui_h - 170, 120, 140);$(13_10)}$(13_10)$(13_10)// Textos (lado direito)$(13_10)draw_set_halign(fa_left);$(13_10)draw_set_valign(fa_top);$(13_10)draw_set_color(c_yellow);$(13_10)draw_text(gui_w - 195, gui_h - 165, " Quadro desbloqueado!");$(13_10)$(13_10)draw_set_color(c_white);$(13_10)draw_text(gui_w - 195, gui_h - 135, "Adicionado ao");$(13_10)draw_text(gui_w - 195, gui_h - 115, "Álbum de Pinturas.");$(13_10)$(13_10)draw_set_alpha(1);$(13_10)draw_set_halign(fa_left);$(13_10)draw_set_valign(fa_top);"
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Pega o sprite pelo sala_id
var _spr = -1;
if (variable_struct_exists(mapa_sprites, sala_id)) {
    var _nome_spr = mapa_sprites[$ sala_id];
    _spr = asset_get_index(_nome_spr);
}

draw_set_alpha(alpha);

// Fundo do popup
draw_set_color(c_black);
draw_rectangle(gui_w - 340, gui_h - 180, gui_w - 20, gui_h - 20, false);
draw_set_color(c_white);
draw_rectangle(gui_w - 340, gui_h - 180, gui_w - 20, gui_h - 20, true);

// Sprite do quadro (lado esquerdo do popup)
if (_spr != -1) {
    draw_sprite_stretched(_spr, 0, gui_w - 330, gui_h - 170, 120, 140);
}

// Textos (lado direito)
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_yellow);
draw_text(gui_w - 195, gui_h - 165, " Quadro desbloqueado!");

draw_set_color(c_white);
draw_text(gui_w - 195, gui_h - 135, "Adicionado ao");
draw_text(gui_w - 195, gui_h - 115, "Álbum de Pinturas.");

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);