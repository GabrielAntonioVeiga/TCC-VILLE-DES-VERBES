draw_set_halign(fa_center);

if selected == slots //gambiarra
	draw_set_color(c_yellow);
	
draw_text(room_width/2,200+slots*60,"Voltar");

draw_set_color(c_white);
draw_text(room_width/2,100,"Seleção de Save");


for(var i=0;i<slots;i++)
{
    var txt = "Slot " + string(i+1);

    if file_exists("save"+string(i)+".sav")
        txt += " (ocupado)";
    else
        txt += " (vazio)";

    if i == selected
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);

	draw_text(room_width/2,200+i*60,txt);
}
draw_set_color(c_white); //gambiarra


