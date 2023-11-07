class_name Menu extends VBoxContainer

signal selected(item: Control)

@export var pointer: Node

var new_scene = preload("res://Levels/level1.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	#connect to viewports focus signal
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	#set up our menu focus chain
	configure_focus_chain()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if not visible: return
	
	#tell everything else in the viewport we're handling the input currently
	get_viewport().set_input_as_handled()
	
	var item = get_focused_item()
	if is_instance_valid(item) and event.is_action_pressed("ui_accept"):
		selected.emit(item)
	
	

func get_items() -> Array[Control]:
	var items: Array[Control] = []
	for child in get_children():
		if not child is Control: continue
		if "Heading" in child.name: continue
		if "Divider" in child.name: continue
		items.append(child)
	return items

func _on_focus_changed(item: Control) -> void:
	if not item: return
	if not item in get_children(): return
	update_selection()

func configure_focus_chain() -> void:
	var items = get_items()
	for i in items.size():
		var item: Control = items[i]
		
		item.focus_mode = Control.FOCUS_ALL
		
		item.focus_neighbor_left = item.get_path()
		item.focus_neighbor_right = item.get_path()
		
		# if first in the list
		if i == 0:
			item.focus_neighbor_top = item.get_path()
			#if we're the first item in the list we have no previous item so we get ourselves
			item.focus_previous = item.get_path()
			#focus this when menu loads
			item.grab_focus()
		else:
			item.focus_neighbor_top = items[i - 1].get_path()
			item.focus_previous = items[i - 1].get_path()
			
		#if last in list
		if i == (items.size() - 1):
			item.focus_neighbor_bottom = item.get_path()
			#if we're the last item in the list we have no next item so we get ourselves
			item.focus_next = item.get_path()
		else:
			item.focus_neighbor_bottom = items[i + 1].get_path()
			item.focus_next = items[i + 1].get_path()

#Get the currently focused item
func get_focused_item() -> Control:
	var item = get_viewport().gui_get_focus_owner()
	return item if item in get_children() else null

#Update the currently focused item
func update_selection() -> void:
	var item = get_focused_item()
	
	if is_instance_valid(item) and is_instance_valid(pointer) and visible:
		pointer.global_position = Vector2(global_position.x - 10, item.global_position.y + item.size.y * 0.5)
	

#Respond to Selection Signal
func _on_selected(item):
	#TODO: Less hacky way to check this
	if item.text == "Start New Game":
		_add_a_scene_manually()
	if item.text == "Load Game":
		Main.load_game()
		_add_a_scene_manually()
	

func _add_a_scene_manually():
	get_node("/root/Main/GUI/Main Menu").queue_free()
	get_node("/root/Main/Game World").add_child(new_scene)
