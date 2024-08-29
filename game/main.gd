extends Control

var m_Reference : Label
var m_ReferenceCitation : Label
var m_UserEntry : TextEdit
var m_UserCitation : TextEdit
var m_CorrectIndicator : Label
var m_CapsSensitive : CheckBox
var m_PunctuationSensitive : CheckBox
var m_QuizCitation : CheckBox

var m_NoPunctuationRegex : RegEx

func _init() -> void:
	m_NoPunctuationRegex = RegEx.new()
	m_NoPunctuationRegex.compile("(\\w+)")

func _ready() -> void:
	m_Reference = $Reference
	m_ReferenceCitation = $ReferenceCitation
	m_UserEntry = $UserEntry
	m_UserCitation = $UserCitation
	m_CorrectIndicator = $CorrectIndicator
	m_CapsSensitive = $Options/CapsToggle
	m_PunctuationSensitive = $Options/PunctuationToggle
	m_QuizCitation = $Options/CitationToggle

	# Configure the citation UI elements so that only one, not both are visible
	_on_citation_toggle_pressed()
	
func _strip_punctuation(in_string:String) -> String:
	var s = ""
	var matches = m_NoPunctuationRegex.search_all(in_string)
	for match:RegExMatch in matches:
		s += match.get_string() + " "
	
	return s.strip_edges()
	
func get_text_after_options(in_string:String) -> String:
	var s:String = in_string
	
	# First get the punctuation out, or if we're checking punctuation, take the reference string as-is
	if not m_PunctuationSensitive.button_pressed:
		s = _strip_punctuation(in_string)
	
	# Now handle capitalization
	if not m_CapsSensitive.button_pressed:
		s = s.to_lower()
	
	# Now strip leading, or likely trailing, whitespace
	s = s.strip_edges()
	
	return s

func _on_check_button_pressed() -> void:
	var ref_text:String = get_text_after_options(m_Reference.text)
	var user_text:String = get_text_after_options(m_UserEntry.text)
	
	print("Ref Text: ", ref_text)
	print("User Text: ", user_text)
	
	if user_text == ref_text:
		m_CorrectIndicator.text = "Correct!"
	else:
		m_CorrectIndicator.text = "Wrong!"


func _on_citation_toggle_pressed() -> void:
	m_UserCitation.visible		=  m_QuizCitation.button_pressed
	m_ReferenceCitation.visible	= !m_QuizCitation.button_pressed
