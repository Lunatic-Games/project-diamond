extends Node

	
func process_ability(ability: Ability, caster: Fighter, non_caster: Fighter) -> void:
	var damage_dealt: int = 0
	
	if ability.damage_amount > 0:
		damage_dealt = non_caster.take_damage(ability.damage_amount)
	if ability.heal_amount > 0:
		caster.heal(ability.heal_amount)
	if ability.full_heal:
		caster.heal(caster.max_health)
	if ability.life_vamp_ratio > 0:
		caster.heal(int(float(damage_dealt) * ability.life_vamp_ratio))
