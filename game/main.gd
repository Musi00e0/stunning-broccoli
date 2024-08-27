extends Control

var m_Reference : Label
var m_UserEntry : TextEdit
var m_CorrectIndicator : Label

func _init() -> void:
	pass

func _ready() -> void:
	m_Reference = $Reference
	m_UserEntry = $UserEntry
	m_CorrectIndicator = $CorrectIndicator

func _on_check_button_pressed() -> void:
	if m_UserEntry.text == m_Reference.text:
		m_CorrectIndicator.text = "Correct!"
	else:
		m_CorrectIndicator.text = "Wrong!"
