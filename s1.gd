extends Node

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var start_button: Button = $VideoStreamPlayer/startbutton

func _ready():
	# إعدادات أولية للزر
	start_button.hide()
	start_button.disabled = true
	
	# تشغيل الفيديو مع تحقق
	if video_player.stream != null:
		video_player.play()
	else:
		push_error("⚠ لم يتم تعيين مقطع فيديو!")
	
	# توصيل الإشارات
	video_player.finished.connect(_on_video_finished)
	start_button.pressed.connect(_on_start_button_pressed)

func _on_video_finished():
	# إظهار الزر مع تأثير
	start_button.show()
	start_button.disabled = false
	
	# تأثير ظهور تدريجي (اختياري)
	var tween = create_tween()
	tween.tween_property(start_button, "modulate:a", 1.0, 0.5).from(0.0)
	
	print("🎬 انتهى الفيديو - الزر ظاهر الآن")

func _on_start_button_pressed():
	# المسار الصحيح للمشهد
	var scene_path = "res://scenes/main.tscn"
	
	# التحقق من وجود المشهد قبل الانتقال
	if ResourceLoader.exists(scene_path):
		print("✅ تم العثور على المشهد، جار الانتقال...")
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("❌ خطأ: المشهد غير موجود في المسار: " + scene_path)
		# يمكنك إظهار رسالة للمستخدم هنا
