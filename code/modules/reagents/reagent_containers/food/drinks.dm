////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/food/drinks
	name = "drink"
	desc = "Yummy!"
	icon = 'icons/obj/drinks.dmi'
	icon_state = null
	flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	volume = 50

	on_reagent_change()
		return

	attack_self(var/mob/user)
		if(!is_open_container())
			open(user)

	proc/open(mob/user)
		playsound(loc,'sound/effects/canopen.ogg', rand(10,50), 1)
		user << "<span class='notice'>You open [src] with an audible pop!</span>"
		flags |= OPENCONTAINER

	attack(var/mob/M, var/mob/user, def_zone)
		if(force && !(flags & NOBLUDGEON) && user.a_intent == I_HURT)
			return ..()

		if(standard_feed_mob(user, M))
			return

		return 0

	afterattack(obj/target, mob/user, proximity)
		if(!proximity) return

		if(standard_dispenser_refill(user, target))
			return
		if(standard_pour_into(user, target))
			return
		return ..()

	standard_feed_mob(var/mob/user, var/mob/target)
		if(!is_open_container())
			user << "<span class='notice'>You need to open [src]!</span>"
			return 1
		return ..()

	standard_dispenser_refill(var/mob/user, var/obj/structure/reagent_dispensers/target)
		if(!is_open_container())
			user << "<span class='notice'>You need to open [src]!</span>"
			return 1
		return ..()

	standard_pour_into(var/mob/user, var/atom/target)
		if(!is_open_container())
			user << "<span class='notice'>You need to open [src]!</span>"
			return 1
		return ..()

	self_feed_message(var/mob/user)
		user << "<span class='notice'>You swallow a gulp from \the [src].</span>"

	feed_sound(var/mob/user)
		playsound(user.loc, 'sound/items/drink.ogg', rand(10, 50), 1)

	examine(mob/user)
		if(!..(user, 1))
			return
		if(!reagents || reagents.total_volume == 0)
			user << "<span class='notice'>\The [src] is empty!</span>"
		else if (reagents.total_volume <= volume * 0.25)
			user << "<span class='notice'>\The [src] is almost empty!</span>"
		else if (reagents.total_volume <= volume * 0.66)
			user << "<span class='notice'>\The [src] is half full!</span>"
		else if (reagents.total_volume <= volume * 0.90)
			user << "<span class='notice'>\The [src] is almost full!</span>"
		else
			user << "<span class='notice'>\The [src] is full!</span>"


////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/food/drinks/golden_cup
	desc = "A golden cup."
	name = "golden cup"
	icon_state = "golden_cup"
	item_state = "" //nope :(
	w_class = 5
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = null
	volume = 150
	flags = CONDUCT | OPENCONTAINER

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
//	rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
//	Formatting is the same as food.

/obj/item/reagent_containers/food/drinks/milk
	name = "milk carton"
	desc = "It's milk. White and nutritious goodness!"
	icon_state = "milk"
	item_state = "carton"
	center_of_mass = "x=16;y=9"

/obj/item/reagent_containers/food/drinks/milk/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_MILK, 50)

/obj/item/reagent_containers/food/drinks/soymilk
	name = "soymilk carton"
	desc = "It's soy milk. White and nutritious goodness!"
	icon_state = "soymilk"
	item_state = "carton"
	center_of_mass = "x=16;y=9"

/obj/item/reagent_containers/food/drinks/soymilk/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_SOYMILK, 50)

/obj/item/reagent_containers/food/drinks/milk/smallcarton
	name = "small milk carton"
	volume = 30
	icon_state = "mini-milk"
/obj/item/reagent_containers/food/drinks/milk/smallcarton/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_MILK, 30)

/obj/item/reagent_containers/food/drinks/milk/smallcarton/chocolate
	name = "small chocolate milk carton"
	desc = "It's milk! This one is in delicious chocolate flavour."

/obj/item/reagent_containers/food/drinks/milk/smallcarton/chocolate/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_CHOCOLATE_MILK, 30)

/obj/item/reagent_containers/food/drinks/coffee
	name = "\improper Robust Coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	center_of_mass = "x=15;y=10"

/obj/item/reagent_containers/food/drinks/coffee/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_COFFEE, 30)

/obj/item/reagent_containers/food/drinks/tea
	name = "cup of Duke Purple Tea"
	desc = "An insult to Duke Purple is an insult to the Space Queen! Any proper gentleman will fight you, if you sully this tea."
	icon_state = "teacup"
	item_state = "coffee"
	center_of_mass = "x=16;y=14"

/obj/item/reagent_containers/food/drinks/tea/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_TEA, 30)

/obj/item/reagent_containers/food/drinks/ice
	name = "cup of ice"
	desc = "Careful, cold ice, do not chew."
	icon_state = "coffee"
	center_of_mass = "x=15;y=10"

/obj/item/reagent_containers/food/drinks/ice/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ICE, 30)

/obj/item/reagent_containers/food/drinks/h_chocolate
	name = "cup of Dutch hot coco"
	desc = "Made in Space South America."
	icon_state = "hot_coco"
	item_state = "coffee"
	center_of_mass = "x=15;y=13"

/obj/item/reagent_containers/food/drinks/h_chocolate/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_HOT_COCOA, 30)

/obj/item/reagent_containers/food/drinks/dry_ramen
	name = "cup ramen"
	gender = PLURAL
	desc = "Just add 10ml water, self heats! A taste that reminds you of your school years."
	icon_state = "ramen"
	center_of_mass = "x=16;y=11"

/obj/item/reagent_containers/food/drinks/dry_ramen/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_DRY_RAMEN, 30)

/obj/item/reagent_containers/food/drinks/sillycup
	name = "paper cup"
	desc = "A paper water cup."
	icon_state = "water_cup_e"
	possible_transfer_amounts = null
	volume = 10
	center_of_mass = "x=16;y=12"

/obj/item/reagent_containers/food/drinks/sillycup/on_reagent_change()
	. = ..()
	icon_state = reagents.total_volume ? "water_cup" : "water_cup_e"

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
//	itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
//	icon states.

/obj/item/reagent_containers/food/drinks/shaker
	name = "shaker"
	desc = "A metal shaker to mix drinks in."
	icon_state = "shaker"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = "x=17;y=10"

/obj/item/reagent_containers/food/drinks/teapot
	name = "teapot"
	desc = "An elegant teapot. It simply oozes class."
	icon_state = "teapot"
	item_state = "teapot"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = "x=17;y=7"

/obj/item/reagent_containers/food/drinks/flask
	name = "\improper Captain's flask"
	desc = "A metal flask belonging to the captain."
	icon_state = "flask"
	volume = 60
	center_of_mass = "x=17;y=7"

/obj/item/reagent_containers/food/drinks/flask/shiny
	name = "shiny flask"
	desc = "A shiny metal flask. It appears to have a Greek symbol inscribed on it."
	icon_state = "shinyflask"

/obj/item/reagent_containers/food/drinks/flask/lithium
	name = "lithium flask"
	desc = "A flask with a Lithium Atom symbol on it."
	icon_state = "lithiumflask"

/obj/item/reagent_containers/food/drinks/flask/detflask
	name = "\improper Detective's flask"
	desc = "A metal flask with a leather band and golden badge belonging to the detective."
	icon_state = "detflask"
	volume = 60
	center_of_mass = "x=17;y=8"

/obj/item/reagent_containers/food/drinks/flask/barflask
	name = "flask"
	desc = "For those who can't be bothered to hang out at the bar to drink."
	icon_state = "barflask"
	volume = 60
	center_of_mass = "x=17;y=7"

/obj/item/reagent_containers/food/drinks/flask/vacuumflask
	name = "vacuum flask"
	desc = "Keeping your drinks at the perfect temperature since 1892."
	icon_state = "vacuumflask"
	volume = 60
	center_of_mass = "x=15;y=4"

/obj/item/reagent_containers/food/drinks/britcup
	name = "cup"
	desc = "A cup with the British flag emblazoned on it."
	icon_state = "britcup"
	volume = 30
	center_of_mass = "x=15;y=13"
