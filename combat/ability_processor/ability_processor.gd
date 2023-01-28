extends Control


signal processing_done

@onready var dialog_box: DialogBox = $DialogBox


func _ready() -> void:
	dialog_box.hide()


func process_ability(ability: Ability, caster: Fighter, non_caster: Fighter) -> void:
	dialog_box.show()
	dialog_box.set_text("{0} used {1}!".format([caster.name, ability.name]))
	await(dialog_box.dialog_done)
	
	var damage_dealt: int = 0
	
	if ability.damage_amount > 0:
		damage_dealt = non_caster.take_damage(ability.damage_amount)
		dialog_box.set_text("It dealt {0} damage!".format([ability.damage_amount]))
		await(dialog_box.dialog_done)
	if ability.heal_amount > 0:
		var amount_healed = caster.heal(ability.heal_amount)
		dialog_box.set_text("{0} healed {1} health.".format([caster.name, amount_healed]))
		await(dialog_box.dialog_done)
	if ability.full_heal:
		caster.heal(caster.max_health)
		dialog_box.set_text("{0} healed to full health.".format([caster.name]))
		await(dialog_box.dialog_done)
	if ability.life_vamp_ratio > 0:
		var amount_healed = caster.heal(int(float(damage_dealt) * ability.life_vamp_ratio))
		dialog_box.set_text("{0} was healed {1} by the attack.".format([caster.name, amount_healed]))
		await(dialog_box.dialog_done)
	
	dialog_box.hide()
	processing_done.emit()
