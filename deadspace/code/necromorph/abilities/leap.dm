/datum/action/cooldown/necro/charge/leaper
	name = "Leap"
	desc = "Allows you to leap at a chosen position."
	cooldown_time = 20 SECONDS
	charge_delay = 1.2 SECONDS
	charge_time = 8 SECONDS
	charge_speed = 2
	var/cached_pass_flags

/datum/action/cooldown/necro/charge/leaper/enhanced
	name = "Enhanced Leap"
	desc = "Allows you to leap at a chosen position, this does more damage and is faster then the usual leap."
	cooldown_time = 18 SECONDS
	charge_time = 8 SECONDS
	charge_speed = 1.5

/datum/action/cooldown/necro/charge/leaper/do_charge_indicator(atom/charge_target)
	var/mob/living/carbon/human/necromorph/source = owner
	cached_pass_flags = source.pass_flags
	source.pass_flags |= PASSTABLE

/datum/action/cooldown/necro/charge/leaper/charge_end(datum/move_loop/source)
	var/matrix/new_matrix = matrix(owner.transform)
	//Scale it back to normal
	new_matrix.a = 1
	new_matrix.e = 1
	animate(owner, transform = new_matrix, pixel_y = owner.pixel_y - 24, time = 0.5 SECONDS)
	owner.pass_flags = cached_pass_flags
	cached_pass_flags = null
	return ..()

/datum/action/cooldown/necro/charge/leaper/on_bump(mob/living/source, atom/target)
	SSmove_manager.stop_looping(source)
	if(ismob(target) || target.uses_integrity)
		hit_target(source, target)
