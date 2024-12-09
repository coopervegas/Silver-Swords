class_name Mercenary

# Properties of the mercenary
var name: String
var hire_bonus: int
var wage: int
var experience: int
var melee_skill: int
var archer_skill: int
var morale: int
var health: int
var armor: int

# Constructor to initialize a mercenary
func _init(
	name: String = "Unnamed",
	hire_bonus: int = 0,
	wage: int = 0,
	experience: int = 0,
	melee_skill: int = 0,
	archer_skill: int = 0,
	morale: int = 100,
	health: int = 100,
	armor: int = 0
):
	self.name = name
	self.hire_bonus = hire_bonus
	self.wage = wage
	self.experience = experience
	self.melee_skill = melee_skill
	self.archer_skill = archer_skill
	self.morale = morale
	self.health = health
	self.armor = armor

# Method to display mercenary details
func get_details() -> String:
	return """%s, Bonus: %d, Wage: %d, Exp: %d, Melee: %d, Archer: %d, Morale: %d, Health: %d, Armor: %d""" % [
		name, hire_bonus, wage, experience,
		melee_skill, archer_skill, morale, health, armor
	]
