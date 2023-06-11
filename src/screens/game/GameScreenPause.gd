class_name GameScreenPause
extends Control

var game_data: PS3GameData = null

var subsequent_panels: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready():
    self.visible = false
    self.subsequent_panels = [
        $top_content,
        $character_selection,
    ]
    $top_content/buttons1/character_btn.pressed.connect(func():
        self.open_character_selection())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func _input(event: InputEvent) -> void:
    if event.is_action_released("pause"):
        self.toggle_pause()
    elif self.visible:
        if event.is_action_released("ui_cancel"):
            self.close_subsequent()

func close_all_subsequent_panels() -> void:
    for p in self.subsequent_panels:
        p.visible = false

func open_top() -> void:
    self.close_all_subsequent_panels()
    $top_content.visible = true
    $top_content/buttons1/items_btn.grab_focus()

func open_character_selection() -> void:
    self.close_all_subsequent_panels()
    $character_selection.visible = true
    NodeExtFn.remove_all_children($character_selection/list)
    var i = 0
    for character_type in self.game_data.party:
        var character = self.game_data.characters[character_type]
        var character_box = preload("res://src/screens/game/pause/GameScPauseTopPartyChar.tscn").instantiate()
        character_box.name = str(i)
        character_box.custom_minimum_size.x = 200
        character_box.custom_minimum_size.y = 400
        character_box.size_flags_horizontal = 0
        character_box.size_flags_vertical = 0
        character_box.get_node("face").texture = character.face_texture
        character_box.get_node("name_label").text = character.name
        $character_selection/list.add_child(character_box)
        i += 1
    $character_selection/list.get_child(0).focus_neighbor_left = $character_selection/list.get_child(-1).get_path()
    $character_selection/list.get_child(-1).focus_neighbor_right = $character_selection/list.get_child(0).get_path()
    $character_selection/list.get_child(0).grab_focus()

func close_subsequent() -> void:
    if $character_selection.visible:
        self.open_top()
    else:
        self.toggle_pause()

func toggle_pause() -> void:
    self.visible = not self.visible
    if self.visible:
        self.open_top()
