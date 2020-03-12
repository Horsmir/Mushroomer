extends Control


func _ready():
    var save_file = File.new()
    if save_file.file_exists(PlayerData.save_file_name):
        $Menu/ContinueButton.disabled = false
