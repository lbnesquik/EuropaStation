/atom
	var/obj/effect/light/light_obj
	var/light_type = LIGHT_SOFT
	var/light_power = 1
	var/light_range = 1
	var/light_color = "#FFFFFF"

// Used to change hard BYOND opacity; this means a lot of updates are needed.
/atom/proc/set_opacity(var/newopacity)
	opacity = newopacity ? 1 : 0
	var/turf/T = get_turf(src)
	if(istype(T))
		T.blocks_light = -1
		for(var/obj/effect/light/L in range(get_turf(src), world.view)) //view(world.view, dview_mob))
			L.cast_light()

/atom/proc/copy_light(var/atom/other)
	light_range = other.light_range
	light_power = other.light_power
	light_color = other.light_color
	set_light()

/atom/proc/update_all_lights()
	spawn()
		if(light_obj && !QDELETED(light_obj))
			light_obj.follow_holder()

/atom/set_dir()
	. = ..()
	update_contained_lights()

/atom/movable/Move()
	. = ..()
	update_contained_lights()

/atom/movable/forceMove()
	. = ..()
	update_contained_lights()

/atom/proc/update_contained_lights(var/list/specific_contents)
	if(!specific_contents)
		specific_contents = contents
	for(var/thing in (specific_contents + src))
		var/atom/A = thing
		spawn()
			if(A && !QDELETED(A))
				A.update_all_lights()
