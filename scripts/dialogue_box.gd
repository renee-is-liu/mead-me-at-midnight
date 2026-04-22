extends Panel

@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_text : RichTextLabel = get_node("DialogueText")
@onready var npc_icon : TextureRect = get_node("../NPCIcon")
@onready var talk_input : ItemList = get_node("PlayerInput")

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	initalize_with_npc()

func initalize_with_npc():
	dialogue_text.text = "Hello, my name is Ylf. How may I help you?"
	change_player_inputs(["I'm good.", "I'm miserable.", "I'm ok."])

func _on_player_input_item_selected(index: int) -> void:
	match index:
		0:
			dialogue_text.text = "Good."
			change_player_inputs(["Fuck you", "How are you?"])
		1: 
			dialogue_text.text = "I hope you feel better soon."
			change_player_inputs(["Great.", "I hope you feel like shit."])
		2:
			dialogue_text.text = "Yikes. Only ok?"
			change_player_inputs(["Gay.", "Truthfully, I'm sad."])

func change_player_inputs(inputs: Array[String]):
	talk_input.clear()
	for i in inputs:
		talk_input.add_item(i)
