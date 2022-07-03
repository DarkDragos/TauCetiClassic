/datum/buildmode_mode/area_edit
	key = "areaedit"
	use_corner_selection = TRUE
	var/area/storedarea
	var/image/areaimage

/datum/buildmode_mode/area_edit/New()
	areaimage = image('icons/area/areas_misc.dmi', null, "yellow")
	..()

/datum/buildmode_mode/area_edit/enter_mode(datum/buildmode/BM)
	BM.holder.images += areaimage

/datum/buildmode_mode/area_edit/exit_mode(datum/buildmode/BM)
	areaimage.loc = null // de-color the area
	BM.holder.images -= areaimage
	return ..()

/datum/buildmode_mode/area_edit/Destroy()
	QDEL_NULL(areaimage)
	storedarea = null
	return ..()

/datum/buildmode_mode/area_edit/show_help(client/c)
	to_chat(c,
		"<span class='notice'>***********************************************************\n\
		Left Mouse Button on obj/turf/mob = Select corner\n\
		Left Mouse Button + Alt on turf/obj/mob = Paint area\n\
		Right Mouse Button on obj/turf/mob = Select area to paint\n\
		Right Mouse Button on buildmode button = Create new area\n\
		***********************************************************</span>")

/datum/buildmode_mode/area_edit/change_settings(client/c)
	var/target_path = input(c, "Enter typepath:", "Typepath", "/area")
	var/areatype = text2path(target_path)
	if(!ispath(areatype, /area))
		tgui_alert(usr, "No area has been selected.")
		return
	var/areaname = input(c, "Enter area name:", "Area name", "Area")
	if(!areaname || !length(areaname))
		return
	storedarea = new areatype
	storedarea.power_equip = 0
	storedarea.power_light = 0
	storedarea.power_environ = 0
	storedarea.always_unpowered = 0
	storedarea.name = areaname
	areaimage.loc = storedarea // color our area

/datum/buildmode_mode/area_edit/handle_click(client/c, params, object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(!storedarea)
			to_chat(c, "<span class='warning'>Configure or select the area you want to paint first!</span>")
			return
		if(LAZYACCESS(modifiers, ALT_CLICK))
			var/turf/T = get_turf(object)
			if(get_area(T) != storedarea)
				log_admin("Build Mode: [key_name(c)] added [AREACOORD(T)] to [storedarea]")
				storedarea.contents.Add(T)
			return
		return ..()
	else if(LAZYACCESS(modifiers, RIGHT_CLICK))
		var/turf/T = get_turf(object)
		storedarea = get_area(T)
		areaimage.loc = storedarea // color our area

/datum/buildmode_mode/area_edit/handle_selected_area(client/c, params)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		var/choice = tgui_alert(usr, "Are you sure you want to fill area?", "Area Fill Confirmation", list("Yes", "No"))
		if(choice != "Yes")
			return
		for(var/turf/T in block(get_turf(cornerA),get_turf(cornerB)))
			storedarea.contents.Add(T)
		log_admin("Build Mode: [key_name(c)] set the area of the region from [AREACOORD(cornerA)] through [AREACOORD(cornerB)] to [storedarea].")
