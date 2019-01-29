# Gives the "hearth stone" (a potion) only if the user doesn't have one
execute unless entity @s[nbt={Inventory:[{id:"minecraft:potion",tag:{display:{ Name:"[{\"text\":\"Hearth Home\", \"color\":\"aqua\"}]"}}}]}] run give @s minecraft:potion{ display:{ Name:"[{\"text\":\"Hearth Home\", \"color\":\"aqua\"}]", Lore: ["There's no place", "like home"]}, HideFlags: 63, CustomPotionColor: 8179950}
