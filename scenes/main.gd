extends Control

# Array of commands
var commands_list = [
	"1. Show mercenary company details.",
	"2. Hire new mercenaries.",
	"3. Fire mercenaries.",
	"4. Show available jobs.",
	"5. Take job."
]

@onready var commands_label = $VBoxContainer/HBoxContainer/commands
@onready var debug_label = $VBoxContainer/HBoxContainer/ScrollContainer/debug
@onready var user_input = $VBoxContainer/userinput

var tokens: Array = []

# Array to store mercenaries
var mercenaries: Array = []

# Array to store Company Mercenaries
var company: Array = []

func _ready():
	
	user_input.grab_focus()
	
	 # Heading text
	var heading = "The following commands are available.\nEnter a command number:\n\n\n"
	
	# Convert the array to a string with newline separators
	commands_label.text = heading + String("\n").join(commands_list)
	
	# Connect the text_submitted signal from LineEdit
	user_input.connect("text_submitted", Callable(self, "_on_user_input_submitted"))
	
	createMercenaryList()
	
		
func createMercenaryList():
	# Create mercenary objects
	var merc1 = Mercenary.new("Archer Joe", 50, 200, 10, 5, 15, 80, 100, 10)
	var merc2 = Mercenary.new("Swordsman Jack", 70, 250, 15, 20, 5, 90, 120, 15)
	var merc3 = Mercenary.new("Pikeman Paul", 40, 180, 8, 12, 6, 85, 110, 12)
	var merc4 = Mercenary.new("Crossbowman Carl", 60, 230, 12, 7, 18, 75, 100, 10)
	var merc5 = Mercenary.new("Shield Bearer Sam", 80, 270, 18, 25, 4, 95, 130, 20)
	var merc6 = Mercenary.new("Scout Sarah", 30, 150, 6, 10, 8, 70, 90, 5)
	var merc7 = Mercenary.new("Knight Kevin", 100, 300, 20, 30, 3, 100, 150, 25)
	var merc8 = Mercenary.new("Spearman Steve", 50, 190, 10, 18, 7, 80, 110, 15)

	# Add mercenaries to the list
	mercenaries.append_array([merc1, merc2, merc3, merc4, merc5, merc6, merc7, merc8])
	

func p(t: String):
	debug_label.text += "\n" + t

func clear():
	debug_label.text = ""
	
func hire_merc(m: int):
	company.append(mercenaries[m])

	
func _on_user_input_submitted(text: String):
	
	# Split input text into tokens (by spaces)
	tokens = text.split(" ")
	
	while tokens.size() < 4:
		tokens.append("0")
	
	# Limit to 4 tokens
	if tokens.size() > 4:
		tokens = tokens.slice(0, 4)
		p("Error, max 4 tokens per command.")
	
	var count = 0
	
	if tokens[0] == "1":
			if company.is_empty():
				p("\nNo mercenaries in company\n")
			else:
				p("\nCompany mercenaries:\n")
				for merc in company:
					p(merc.get_details())

	if tokens[0] == "2":
		if int(tokens[1]) > 0:
			hire_merc(int(tokens[1]))
			p("\nCompany mercenaries:\n")
			for merc in company:
				p(merc.get_details())
		else:
			clear()
			p("\nAvailable mercenaries\n")
			for merc in mercenaries:
				count += 1
				p("      " + str(count) + ":  " + merc.get_details())
			count = 0

	# Force the ScrollContainer to scroll to the bottom
	# need to wait or scrollbar wont function right
	var scroll_container = $VBoxContainer/HBoxContainer/ScrollContainer
	
	await get_tree().create_timer(0.01).timeout
	scroll_container.set_deferred("scroll_vertical", scroll_container.get_v_scroll_bar().max_value)
	scroll_container.set_deferred("scroll_vertical", 1000000)


	
	# Clear the text in the LineEdit
	user_input.text = ""
