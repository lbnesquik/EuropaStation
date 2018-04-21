/turf/simulated/wall/update_material()
	. = ..()
	if(material.is_psi_null() || (reinf_material && reinf_material.is_psi_null()))
		LAZYADD(psi_null_atoms, src)
	else
		LAZYREMOVE(psi_null_atoms, src)
		UNSETEMPTY(psi_null_atoms)

/turf/simulated/wall/dismantle_wall(var/devastated, var/explode, var/no_product)
	LAZYREMOVE(psi_null_atoms, src)
	UNSETEMPTY(psi_null_atoms)
	. = ..(devastated, explode, no_product)

/turf/simulated/wall/withstand_psi_stress(var/stress)
	. = ..(stress)
	if(. > 0 && (src in psi_null_atoms))
		var/cap = material.integrity
		if(reinf_material) cap += reinf_material.integrity
		var/stress_total = damage + .
		take_damage(.)
		. = max(0, -(cap-stress_total))

/turf/simulated/wall/nullglass
	color = "#ff6088"

/turf/simulated/wall/nullglass/New(var/newloc)
	color = null
	..(newloc,"nullglass")