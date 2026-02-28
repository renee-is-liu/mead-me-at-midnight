extends Node

@export var ylf_moving_scene: PackedScene
@export var ylf_npc_scene: PackedScene


func _on_ylf_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var ylf = ylf_moving_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var ylf_spawn_location = get_node("YlfSpawnPath/YlfSpawnLocation")
	# And give it a random offset.
	ylf_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	ylf.initialize(ylf_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(ylf)
