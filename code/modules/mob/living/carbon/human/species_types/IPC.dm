/datum/species/IPC
	name = "IPC"
	id = SPECIES_IPC
	say_mod = "states"
	species_traits = list(NO_DNA_COPY, NOTRANSSTING, AGENDER, NO_UNDERWEAR)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOCLONELOSS,
	)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = null
	damage_overlay_type = "synth"
	mutanttongue = /obj/item/organ/tongue/robot
  mutantstomach = /obj/item/stock_parts/cell
  mutantheart = /obj/item/organ/heart/cybernetic
  mutantears = /obj/item/organ/ears/cybernetic
  mutantliver = /obj/item/organ/liver/cybernetic
  mutantlungs = /obj/item/organ/lungs/cybernetic
  mutanteyes = /obj/item/organ/eyes/robotic
  mutantbrain = /obj/item/mmi/posibrain
  exotic_blood = /datum/reagent/consumable/liquidelectricity
	species_language_holder = /datum/language_holder/synthetic
	brutemod = 1.5
	burnmod = 1.25
	toxinmod = 0.75
	heatmod = 1.25
	payday_modifier = 0.25
	wings_icons = list("Robotic")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/robot,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/robot,
	)
	examine_limb_id = SPECIES_HUMAN

/datum/species/IPC/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	// Androids don't eat, hunger or metabolise foods. Let's do some cleanup.
	C.set_safe_hunger_level()

/datum/species/IPC/replace_body(mob/living/carbon/target, datum/species/new_species)
	. = ..()
	var/skintone
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		skintone = human_target.skin_tone

	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_HEAD || limb.body_zone == BODY_ZONE_CHEST)
			limb.is_dimorphic = TRUE
		limb.skin_tone ||= skintone
		limb.limb_id = SPECIES_HUMAN
		limb.should_draw_greyscale = TRUE
		limb.name = "human [limb.plaintext_zone]"
		limb.update_limb()
		limb.brute_reduction = 5
		limb.burn_reduction = 4
