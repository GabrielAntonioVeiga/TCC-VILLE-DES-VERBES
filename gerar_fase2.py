import os
import shutil

os.chdir('c:/Users/fidos/TCC-VILLE-DES-VERBES/unificado')

# Create obj_porta_aviso
os.makedirs('objects/obj_porta_aviso', exist_ok=True)
with open('objects/obj_porta_aviso/obj_porta_aviso.yy', 'w', encoding='utf-8') as f:
    f.write('''{
  "$GMObject":"",
  "%Name":"obj_porta_aviso",
  "eventList":[
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":64,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_porta_aviso",
  "overriddenProperties":[],
  "parent":{
    "name":"Objects",
    "path":"folders/Objects.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":null,
  "visible":true,
}''')
with open('objects/obj_porta_aviso/Create_0.gml', 'w', encoding='utf-8') as f:
    f.write('''// Pausa jogador
if (instance_exists(Player)) Player.velocidade = 0;
''')
with open('objects/obj_porta_aviso/Step_0.gml', 'w', encoding='utf-8') as f:
    f.write('''if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter)) {
    instance_destroy();
}
''')
with open('objects/obj_porta_aviso/Draw_64.gml', 'w', encoding='utf-8') as f:
    f.write('''var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var cx = gui_w/2;
var cy = gui_h/2;

draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, gui_w, gui_h, false); // Fundo escuro
draw_set_alpha(1);

draw_set_color(c_white);
draw_roundrect(cx - 300, cy - 150, cx + 300, cy + 150, false);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_text(cx, cy - 80, "PORTA TRANCADA!");
draw_set_color(c_black);
draw_text(cx, cy, "Voce precisa resolver um quiz\\nou completar o objetivo da sala atual\\npara prosseguir para o proximo nivel.");
draw_text(cx, cy + 80, "(Aperte ENTER ou clique para fechar)");
''')

# Create Room2
os.makedirs('rooms/Room2', exist_ok=True)
if os.path.exists('rooms/Room1/Room1.yy'):
    with open('rooms/Room1/Room1.yy', 'r', encoding='utf-8') as src:
        room2_content = src.read()
    room2_content = room2_content.replace('"Room1"', '"Room2"')
    room2_content = room2_content.replace('rooms/Room1/Room1.yy', 'rooms/Room2/Room2.yy')
    # Remove instances of the door or player to not have conflicts if needed, but since it's a new room, we can just let it have the same stuff.
    with open('rooms/Room2/Room2.yy', 'w', encoding='utf-8') as dst:
        dst.write(room2_content)

# Update obj_porta/Step_0.gml
porta_step = '''// RF006 & RF029 - Troca de Sala & Livre movimentação entre cenas desbloqueadas
if (instance_exists(Player)) {
    if (point_distance(x, y, Player.x, Player.y) < 150) {
        if (keyboard_check_pressed(ord("E"))) {
            var can_transition = false;
            
            // RF029 Regra de Desbloqueio (Pós-Quizzes)
            if (desbloqueada) {
                can_transition = true;
            } else if (variable_global_exists("quizzes_concluidos")) {
                if (array_length(global.quizzes_concluidos) >= 1) { 
                    can_transition = true;
                    desbloqueada = true; 
                }
            } else {
                can_transition = true; 
            }
            
            if (can_transition) {
                var inst = instance_create_depth(0, 0, -9999, obj_transicao);
                inst.target_room = target_room;
                inst.target_x = target_x;
                inst.target_y = target_y;
                
                var snd = asset_get_index("snd_porta");
                if (snd != -1) audio_play_sound(snd, 1, false);
            } else {
                if (!instance_exists(obj_porta_aviso)) {
                    instance_create_depth(0,0,-9999,obj_porta_aviso);
                }
            }
        }
    }
}
'''
with open('objects/obj_porta/Step_0.gml', 'w', encoding='utf-8') as f:
    f.write(porta_step)

# Inject to yyp manually using string operations
with open('dialogo.yyp', 'r', encoding='utf-8') as f:
    yyp_content = f.read()

# adding resources
new_resc = [
    '    {"id":{"name":"Room2","path":"rooms/Room2/Room2.yy",},},',
    '    {"id":{"name":"obj_porta_aviso","path":"objects/obj_porta_aviso/obj_porta_aviso.yy",},},'
]

if '"name":"Room2"' not in yyp_content:
    marker = '"resources":['
    idx = yyp_content.find(marker)
    if idx != -1:
        yyp_content = yyp_content[:idx+len(marker)] + '\\n' + '\\n'.join(new_resc) + yyp_content[idx+len(marker):]

# Add room2 to RoomOrderNodes
new_room_node = '    {"roomId":{"name":"Room2","path":"rooms/Room2/Room2.yy",},},'
if new_room_node not in yyp_content:
    marker_orders = '"RoomOrderNodes":['
    idx = yyp_content.find(marker_orders)
    if idx != -1:
        yyp_content = yyp_content[:idx+len(marker_orders)] + '\\n' + new_room_node + yyp_content[idx+len(marker_orders):]

with open('dialogo.yyp', 'w', encoding='utf-8') as f:
    f.write(yyp_content)

print("Geracao completa!")
