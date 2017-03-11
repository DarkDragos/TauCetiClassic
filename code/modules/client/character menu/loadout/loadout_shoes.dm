/datum/gear/shoes
	display_name = "Sandals"
	path = /obj/item/clothing/shoes/sandal
	slot = slot_shoes
	sort_category = "Shoes and Footwear"

/datum/gear/shoes/color
	display_name = "Shoe selection"
	path = /obj/item/clothing/shoes/black

/datum/gear/shoes/color/New()
	..()
	var/shoes = list()
	shoes["black"] = /obj/item/clothing/shoes/black
	shoes["blue"] = /obj/item/clothing/shoes/blue
	shoes["brown"] = /obj/item/clothing/shoes/brown
	shoes["dress"] = /obj/item/clothing/shoes/laceup
	shoes["green"] = /obj/item/clothing/shoes/green
	shoes["leather"] = /obj/item/clothing/shoes/leather
	shoes["orange"] = /obj/item/clothing/shoes/orange
	shoes["purple"] = /obj/item/clothing/shoes/purple
	shoes["rainbow"] = /obj/item/clothing/shoes/rainbow
	shoes["red"] = /obj/item/clothing/shoes/red
	shoes["white"] = /obj/item/clothing/shoes/white
	shoes["yellow"] = /obj/item/clothing/shoes/yellow
	gear_tweaks += new/datum/gear_tweak/path(shoes)

/datum/gear/shoes/boots
	display_name = "Boot selection"
	path = /obj/item/clothing/shoes/jackboots

/datum/gear/shoes/boots/New()
	..()
	var/boots = list()
	boots["jackboots"] = /obj/item/clothing/shoes/jackboots
	boots["workboots"] = /obj/item/clothing/shoes/workboots
	gear_tweaks += new/datum/gear_tweak/path(boots)

/datum/gear/shoes/kung
	display_name = "Kung shoes"
	path = /obj/item/clothing/shoes/fluff/kung
	cost = 1