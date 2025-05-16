extends CharacterBody3D

@export var speed = 4
@export var gravity = -10

# اللاعب الذي سيتتبعه الزومبي
@onready var player: CharacterBody3D = get_node("/root/main/player")

func _ready() -> void:
	# تشغيل أنميشن الحركة عند البداية
	$holder/Skeleton3D/AnimationPlayer.play("mixamo_com")
	
	# ربط الإشارة عند دخول جسم إلى مجال Area3D
	#$Area3D.body_entered.connect(_on_area_3d_body_entered)

func _physics_process(delta: float) -> void:
	# تطبيق الجاذبية
	if not is_on_floor():
		velocity.y += gravity * delta

	# الاتجاه نحو اللاعب (تجاهل المحور Y العمودي)
	var dir = (player.global_position - global_position).normalized()
	dir.y = 0

	# تطبيق السرعة
	var horizontal_velocity = dir * speed
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z

	# تدوير المجسم ليواجه اللاعب
	$holder.look_at(Vector3(player.global_position.x, $holder.global_position.y, player.global_position.z))
	$holder.rotation.x = 0

	# تحريك الزومبي
	move_and_slide()

	# إعادة تشغيل الأنميشن إذا توقف
	if not $holder/Skeleton3D/AnimationPlayer.is_playing():
		$holder/Skeleton3D/AnimationPlayer.play("mixamo_com")

# عند دخول اللاعب في منطقة الاصطدام
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.damage()
