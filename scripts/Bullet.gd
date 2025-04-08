extends Spatial

var speed = 50
var direction = Vector3()

func _process(delta):
    translation += direction * speed * delta
    if translation.length() > 100:
        queue_free()