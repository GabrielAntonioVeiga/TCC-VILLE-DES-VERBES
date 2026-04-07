import json
import os

os.chdir('c:/Users/fidos/TCC-VILLE-DES-VERBES/unificado')

with open('dialogo.yyp', 'r', encoding='utf-8') as f:
    yyp = json.load(f)

# Add new resources
new_resources = [
    {"id": {"name": "ScriptsTextosTraduzidos", "path": "scripts/ScriptsTextosTraduzidos/ScriptsTextosTraduzidos.yy"}},
    {"id": {"name": "obj_transicao", "path": "objects/obj_transicao/obj_transicao.yy"}},
    {"id": {"name": "obj_porta", "path": "objects/obj_porta/obj_porta.yy"}}
]

for res in new_resources:
    if res not in yyp['resources']:
        yyp['resources'].append(res)

with open('dialogo.yyp', 'w', encoding='utf-8') as f:
    json.dump(yyp, f, indent=2)

# Create script
os.makedirs('scripts/ScriptsTextosTraduzidos', exist_ok=True)
with open('scripts/ScriptsTextosTraduzidos/ScriptsTextosTraduzidos.yy', 'w', encoding='utf-8') as f:
    f.write('''{
  "$GMScript":"v1",
  "%Name":"ScriptsTextosTraduzidos",
  "isCompatibility":false,
  "isDnD":false,
  "name":"ScriptsTextosTraduzidos",
  "parent":{
    "name":"Scripts",
    "path":"folders/Scripts.yy",
  },
  "resourceType":"GMScript",
  "resourceVersion":"2.0",
}''')
with open('scripts/ScriptsTextosTraduzidos/ScriptsTextosTraduzidos.gml', 'w', encoding='utf-8') as f:
    f.write('''// -----------------------------
// ScriptsTextosTraduzidos
// -----------------------------

function obter_string(chave) {
    if (!variable_global_exists("language")) {
        global.language = "pt";
    }

    var dict_pt = {
        "menu_iniciar": "Iniciar Jogo",
        "menu_config": "Configurações",
        "menu_creditos": "Créditos",
        "menu_sair": "Sair",
        "config_volume": "Volume",
        "config_velocidade": "Velocidade do Texto",
        "config_idioma": "Idioma",
        "config_telacheia": "Tela cheia",
        "config_voltar": "Voltar",
        "vazio_album": "Falta muito a estudar ainda",
        "sem_missao": "Nenhum objetivo por agora"
    };

    var dict_fr = {
        "menu_iniciar": "Commencer le jeu",
        "menu_config": "Paramètres",
        "menu_creditos": "Crédits",
        "menu_sair": "Quitter",
        "config_volume": "Volume",
        "config_velocidade": "Vitesse du texte",
        "config_idioma": "Langue",
        "config_telacheia": "Plein écran",
        "config_voltar": "Retour",
        "vazio_album": "Il reste encore beaucoup à étudier",
        "sem_missao": "Aucun objectif pour le moment"
    };

    var dict = (global.language == "fr") ? dict_fr : dict_pt;
    
    if (variable_struct_exists(dict, chave)) {
        return dict[$ chave];
    }
    return chave;
}
''')

# Create obj_transicao
os.makedirs('objects/obj_transicao', exist_ok=True)
with open('objects/obj_transicao/obj_transicao.yy', 'w', encoding='utf-8') as f:
    f.write('''{
  "$GMObject":"",
  "%Name":"obj_transicao",
  "eventList":[
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":75,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_transicao",
  "overriddenProperties":[],
  "parent":{
    "name":"Objects",
    "path":"folders/Objects.yy",
  },
  "parentObjectId":null,
  "persistent":true,
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
with open('objects/obj_transicao/Create_0.gml', 'w', encoding='utf-8') as f:
    f.write('''// Initialize variables for fade
alpha = 0;
fade_out = true; // true = fading to black, false = fading from black
target_room = -1;
target_x = -1;
target_y = -1;
fade_speed = 0.05;
''')
with open('objects/obj_transicao/Step_0.gml', 'w', encoding='utf-8') as f:
    f.write('''if (fade_out) {
    alpha += fade_speed;
    if (alpha >= 1) {
        alpha = 1;
        fade_out = false;
        if (room_exists(target_room) && target_room != -1) {
            room_goto(target_room);
        }
    }
} else {
    alpha -= fade_speed;
    if (alpha <= 0) {
        if (target_x != -1 && target_y != -1 && instance_exists(Player)) {
            Player.x = target_x;
            Player.y = target_y;
        }
        instance_destroy();
    }
}
''')
with open('objects/obj_transicao/Draw_75.gml', 'w', encoding='utf-8') as f:
    f.write('''// Draw fade overlay
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);
''')

# Create obj_porta
os.makedirs('objects/obj_porta', exist_ok=True)
with open('objects/obj_porta/obj_porta.yy', 'w', encoding='utf-8') as f:
    f.write('''{
  "$GMObject":"",
  "%Name":"obj_porta",
  "eventList":[
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_porta",
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
  "properties":[
      {"$GMObjectProperty":"","%Name":"target_room","filters":[],"listItems":[],"multiselect":false,"name":"target_room","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"Room1","varType":5,},
      {"$GMObjectProperty":"","%Name":"target_x","filters":[],"listItems":[],"multiselect":false,"name":"target_x","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"100","varType":0,},
      {"$GMObjectProperty":"","%Name":"target_y","filters":[],"listItems":[],"multiselect":false,"name":"target_y","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"100","varType":0,},
      {"$GMObjectProperty":"","%Name":"desbloqueada","filters":[],"listItems":[],"multiselect":false,"name":"desbloqueada","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{"name":"Sprite2","path":"sprites/Sprite2/Sprite2.yy",},
  "spriteMaskId":null,
  "visible":true,
}''')
with open('objects/obj_porta/Create_0.gml', 'w', encoding='utf-8') as f:
    f.write('''// Se estiver desbloqueada, não checa quiz.
''')
with open('objects/obj_porta/Step_0.gml', 'w', encoding='utf-8') as f:
    f.write('''// RF006 & RF029 - Troca de Sala & Livre movimentação entre cenas desbloqueadas
if (instance_exists(Player)) {
    if (point_distance(x, y, Player.x, Player.y) < 50) {
        if (keyboard_check_pressed(ord("E"))) {
            var can_transition = false;
            
            // RF029 Regra de Desbloqueio (Pós-Quizzes)
            if (desbloqueada) {
                can_transition = true;
            } else if (variable_global_exists("quizzes_concluidos")) {
                if (array_length(global.quizzes_concluidos) >= 1) { // Placeholder: "pelos menos 1 quiz na cena"
                    can_transition = true;
                    desbloqueada = true; // Liberada para navegação livre
                }
            } else {
                // Para testes ou quando quizzesConcluidos n foi inic.
                can_transition = true; 
            }
            
            if (can_transition) {
                var inst = instance_create_depth(0, 0, -9999, obj_transicao);
                inst.target_room = target_room;
                inst.target_x = target_x;
                inst.target_y = target_y;
                
                // RNF063 - Som de interacao (se existir snd_porta)
                var snd = asset_get_index("snd_porta");
                if (snd != -1) audio_play_sound(snd, 1, false);
            } else {
                // Mostra feedback se trancada
                if (asset_get_index("criar_feedback") != -1) {
                    criar_feedback("A porta está trancada. Resolva os quizzes!");
                }
            }
        }
    }
}
''')

print("Resources generated successfully!")
