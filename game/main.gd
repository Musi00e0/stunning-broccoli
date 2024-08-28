extends Control

var m_Reference : Label
var m_UserEntry : TextEdit
var m_CorrectIndicator : Label
var m_CapsSensitive : CheckBox
var m_PunctuationSensitive : CheckBox

func _init() -> void:
	pass

func _ready() -> void:
	m_Reference = $Reference
	m_UserEntry = $UserEntry
	m_CorrectIndicator = $CorrectIndicator
	m_CapsSensitive = $Options/CapsToggle
	m_PunctuationSensitive = $Options/PunctuationToggle

func _on_check_button_pressed() -> void:
	if m_UserEntry.text == m_Reference.text:
		m_CorrectIndicator.text = "Correct!"
	else:
		m_CorrectIndicator.text = "Wrong!"

	if m_CapsSensitive.button_pressed:
		print("Caps sensitive")
	
	if m_PunctuationSensitive.button_pressed:
		print("Punc sensitive")