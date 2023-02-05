extends Control


signal processing_done

var dialog_manager: DialogManager


func process_ability(ability: Ability, caster: Fighter, non_caster: Fighter) -> void:
	var ability_use_text = "{0} used {1}!".format([caster.name, ability.name])
	await(dialog_manager.display_and_wait(ability_use_text))
	
	var damage_dealt: int = 0
	
	if ability.damage_amount > 0:
		damage_dealt = non_caster.take_damage(ability.damage_amount)
		var text = "It dealt {0} damage!".format([ability.damage_amount])
		await(dialog_manager.display_and_wait(text))
	
	if ability.heal_amount > 0:
		var amount_healed = caster.heal(ability.heal_amount)
		var text = "{0} healed {1} health.".format([caster.name, amount_healed])
		await(dialog_manager.display_and_wait(text))
		
	if ability.full_heal:
		caster.heal(caster.max_health)
		var text = "{0} healed to full health.".format([caster.name])
		await(dialog_manager.display_and_wait(text))
		
	if ability.life_vamp_ratio > 0:
		var amount_healed = caster.heal(int(float(damage_dealt) * ability.life_vamp_ratio))
		var text = "{0} was healed {1} by the attack.".format([caster.name, amount_healed])
		await(dialog_manager.display_and_wait(text))
	
	processing_done.emit()
