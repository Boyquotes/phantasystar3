class_name PS3Character

static var RHYS: PS3Character = PS3Character.new(0, "rhys", Gender.MALE, preload("res://res/img/characters/rhys/face.png"))
static var MIEU: PS3Character = PS3Character.new(1, "mieu", Gender.FEMALE, preload("res://res/img/characters/mieu/face.png"))

static var _from: Dictionary = {}
var _value: int
var _string_id: String
var _gender: Gender
var _face_texture: Texture

func _init(value: int, string_id: String, gender: Gender, face_texture: Texture):
    PS3Character._from[value] = self
    self._value = value
    self._string_id = string_id
    self._gender = gender
    self._face_texture = face_texture
    print(PS3Character._from[value].name)

static func from(value: int) -> PS3Character:
    return PS3Character._from.get(value)

func value_of() -> int:
    return self._value

var string_id: String:
    get:
        return self._string_id

var gender: Gender:
    get:
        return self._gender

var name: String:
    get:
        if self == PS3Character.RHYS:
            return "Rhys"
        if self == PS3Character.MIEU:
            return "Mieu"
        return "undefined"

var face_texture: Texture:
    get:
        return self._face_texture
