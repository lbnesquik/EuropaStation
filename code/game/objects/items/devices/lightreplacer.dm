
// Light Replacer (LR)
//
// ABOUT THE DEVICE
//
// This is a device supposedly to be used by Janitors and Janitor Cyborgs which will
// allow them to easily replace lights. This was mostly designed for Janitor Cyborgs since
// they don't have hands or a way to replace lightbulbs.
//
// HOW IT WORKS
//
// You attack a light fixture with it, if the light fixture is broken it will replace the
// light fixture with a working light; the broken light is then placed on the floor for the
// user to then pickup with a trash bag. If it's empty then it will just place a light in the fixture.
//
// HOW TO REFILL THE DEVICE
//
// It can be manually refilled or by clicking on a storage item containing lights.
// If it's part of a robot module, it will charge when the Robot is inside a Recharge Station.
//
// EMAGGED FEATURES
//
// NOTICE: The Cyborg cannot use the emagged Light Replacer and the light's explosion was nerfed. It cannot create holes in the station anymore.
//
// I'm not sure everyone will react the emag's features so please say what your opinions are of it.
//
// When emagged it will rig every light it replaces, which will explode when the light is on.
// This is VERY noticable, even the device's name changes when you emag it so if anyone
// examines you when you're holding it in your hand, you will be discovered.
// It will also be very obvious who is setting all these lights off, since only Janitor Borgs and Janitors have easy
// access to them, and only one of them can emag their device.
//
// The explosion cannot insta-kill anyone with 30% or more health.

#define LIGHT_OK 0
#define LIGHT_EMPTY 1
#define LIGHT_BROKEN 2
#define LIGHT_BURNED 3


/obj/item/lightreplacer

	name = "light replacer"
	desc = "A device to automatically replace lights. Refill with working lightbulbs or sheets of glass."

	icon = 'icons/obj/janitor.dmi'
	icon_state = "lightreplacer0"
	item_state = "electronic"

	flags = CONDUCT
	slot_flags = SLOT_BELT


	var/max_uses = 32
	var/uses = 32
	var/emagged = 0
	var/failmsg = ""
	var/charge = 0

/obj/item/lightreplacer/New()
	failmsg = "The [name]'s refill light blinks red."
	..()

/obj/item/lightreplacer/examine(mob/user)
	if(..(user, 2))
		user << "It has [uses] lights remaining."

/obj/item/lightreplacer/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/stack/material) && W.is_material(MATERIAL_GLASS))
		var/obj/item/stack/G = W
		if(uses >= max_uses)
			user << "<span class='warning'>[src.name] is full.</span>"
			return
		else if(G.use(1))
			AddUses(16) //Autolathe converts 1 sheet into 16 lights.
			user << "<span class='notice'>You insert a piece of glass into \the [src.name]. You have [uses] light\s remaining.</span>"
			return
		else
			user << "<span class='warning'>You need one sheet of glass to replace lights.</span>"

	if(istype(W, /obj/item/light))
		var/obj/item/light/L = W
		if(L.status == 0) // LIGHT OKAY
			if(uses < max_uses)
				AddUses(1)
				user << "You insert \the [L.name] into \the [src.name]. You have [uses] light\s remaining."
				user.drop_item()
				qdel(L)
				return
		else
			user << "You need a working light."
			return

/obj/item/lightreplacer/attack_self(mob/user)
	/* // This would probably be a bit OP. If you want it though, uncomment the code.
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(R.emagged)
			src.Emag()
			usr << "You shortcircuit the [src]."
			return
	*/
	usr << "It has [uses] lights remaining."

/obj/item/lightreplacer/update_icon()
	icon_state = "lightreplacer[emagged]"


/obj/item/lightreplacer/proc/Use(var/mob/user)

	playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
	AddUses(-1)
	return 1

// Negative numbers will subtract
/obj/item/lightreplacer/proc/AddUses(var/amount = 1)
	uses = min(max(uses + amount, 0), max_uses)

/obj/item/lightreplacer/proc/Charge(var/mob/user, var/amount = 1)
	charge += amount
	if(charge > 6)
		AddUses(1)
		charge = 0

/obj/item/lightreplacer/proc/ReplaceLight(var/obj/machinery/light/target, var/mob/living/U)

	if(target.status == LIGHT_OK)
		U << "There is a working [target.get_fitting_name()] already inserted."
	else if(!CanUse(U))
		U << failmsg
	else if(Use(U))
		U << "<span class='notice'>You replace the [target.get_fitting_name()] with the [src].</span>"

		if(target.status != LIGHT_EMPTY)
			target.remove_bulb()

		var/obj/item/light/L = new target.light_bulb_type()
		target.insert_bulb(L)


/obj/item/lightreplacer/emag_act(var/remaining_charges, var/mob/user)
	emagged = !emagged
	playsound(src.loc, "sparks", 100, 1)
	update_icon()
	return 1

//Can you use it?

/obj/item/lightreplacer/proc/CanUse(var/mob/living/user)
	src.add_fingerprint(user)
	//Not sure what else to check for. Maybe if clumsy?
	if(uses > 0)
		return 1
	else
		return 0

#undef LIGHT_OK
#undef LIGHT_EMPTY
#undef LIGHT_BROKEN
#undef LIGHT_BURNED
