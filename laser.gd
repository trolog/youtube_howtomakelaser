extends Node2D

var max_dist = 1000

onready var laser_beam = get_node("Laser_Center")
onready var part = get_node("Particles2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	handle_beam()
	handle_movement()
	
func handle_beam():
	var ray = get_world_2d().direct_space_state
	var hit = ray.intersect_ray(global_position,global_position + transform.x * max_dist,[self],1,true,true)
	
	if hit:
		var hit_pos = hit["position"]
		var laser_length = laser_beam.global_position.distance_to(hit_pos)
		laser_beam.scale.x = laser_length
		part.show()
		part.global_position = hit_pos
		
	else:
		part.hide()
		laser_beam.scale.x = max_dist
		
func handle_movement():
	global_position = get_global_mouse_position()
	if(Input.is_action_pressed("mb_left")):
		rotation_degrees +=3
	if(Input.is_action_pressed("mb_right")):
		rotation_degrees -=3
	
