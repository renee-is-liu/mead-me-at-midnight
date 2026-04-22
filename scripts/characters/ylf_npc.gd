extends CharacterBody3D

var speed = 1
var current_state = IDLE
var dir = Vector3.FORWARD
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false


enum {
	IDLE,
	LEFT,
	RIGHT,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	
func _process(delta):
	if current_state == 0 or current_state == 1 or current_state == 2:
		$Pivot/ylf_walking/AnimationPlayer.play("idle")
	elif current_state == 3 and !is_chatting:
		$Pivot/ylf_walking/AnimationPlayer.play("walk")
	if is_roaming:
		match current_state:
			IDLE:
				pass
			LEFT:
				rotate_y(1 * delta)
			RIGHT:
				rotate_y(-1 * delta)
			MOVE:
				move(delta)

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += -transform.basis.z * speed * delta


func _on_chat_detection_area_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, LEFT, RIGHT, MOVE, MOVE, MOVE])
	
