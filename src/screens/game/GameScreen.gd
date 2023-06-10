extends Node2D

var game_data: GameData = GameData.new()

var paused: bool = false

@onready
var world: Node2D = $world

@onready
var world_entities: Node2D = $world/entities

@onready
var world_entity_labels: Node2D = $world/entity_labels

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    if self.paused:
        return
