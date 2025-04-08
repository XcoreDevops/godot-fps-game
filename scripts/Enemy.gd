extends KinematicBody

var speed = 5
var player = null

func _ready():
    player = get_parent().get_node("Player")

func _process(delta):
    var direction = (player.global_transform.origin - global_transform.origin).normalized()
    velocity = direction * speed
    velocity = move_and_slide(velocity)