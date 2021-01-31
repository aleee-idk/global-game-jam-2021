extends Button

export var scene: Resource


func _on_Button_pressed():
	get_tree().change_scene(scene.resource_path)
