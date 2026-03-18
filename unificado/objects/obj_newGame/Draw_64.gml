draw_set_halign(fa_center);

draw_text(room_width/2,100,"NOVO JOGO");

for(var i=0;i<array_length(options);i++)
{
    if(i==selected)
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);

    draw_text(room_width/2,200+i*60,options[i]);
}