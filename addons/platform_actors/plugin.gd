tool
extends EditorPlugin
const PATH = "res://addons/platform_actors/"
func _enter_tree():
	add_custom_type("PlatformActor2D", "KinematicBody2D",
		load(PATH + "platform_actor.gd"),
		load(PATH + "icon.svg")
		)
	add_custom_type("PlatformPlayer2D", "KinematicBody2D",
		load(PATH + "player_platform_actor.gd"),
		load(PATH + "icon.svg")
		)
	get_tree().connect("node_added", self, "_on_scene_node_added")
func _exit_tree():
	remove_custom_type("PlatformActor2D")
	remove_custom_type("PlatformPlayer2D")
	pass

func _on_scene_node_added(node):
	if !node is load(PATH + "platform_actor.gd"):
		return
	if node.has_node("state_machine"):
		return
	setup_character(node)

func setup_character(character):
	var b = load(PATH + "state_machine.tscn").instance()
	var s = CollisionShape2D.new()
	character.name = "platform_actor_2d"
	character.add_child(s)
	character.add_child(b)
	s.set_owner(get_tree().get_edited_scene_root())
	b.set_owner(get_tree().get_edited_scene_root())