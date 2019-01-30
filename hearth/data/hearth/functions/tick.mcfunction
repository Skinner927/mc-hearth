# New player setup
scoreboard players add @a hearth_new 0
execute as @a[scores={hearth_new=0}] run function hearth:new_player

# This runs on its own to see if the hearth potion was the last one you had in your hand
execute as @a[nbt={SelectedItem:{id:"minecraft:potion"}}] store success score @s hearth_in_hand run data get entity @s[nbt={SelectedItem:{id:"minecraft:potion",tag:{display:{Name:"[{\"text\":\"Hearth Home\", \"color\":\"aqua\"}]"}}}}]

# Check for people who are using a potion and have our potion in their hand.
# These users have requested to TP
execute as @a[scores={hearth_pot_use=1..,hearth_in_hand=1}] run tag @s add hearth_needs_tp
scoreboard players reset @a[scores={hearth_pot_use=1..}] hearth_pot_use

# Anyone who drank a potion but still needs to cool down is checked here
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run scoreboard players operation @s hearth_coold_hr = @s hearth_cooldown
# hearth_cooldown is stored in total ticks, so we need to make this human readable by dividing by 20 (as 20 ticks per second)
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run scoreboard players set @s hearth_tmp 20
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run scoreboard players operation @s hearth_coold_hr /= @s hearth_tmp
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run scoreboard players add @s hearth_coold_hr 1
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run tellraw @s [{"text": "You must wait ", "color":"aqua"}, {"score":{"name":"@s", "objective":"hearth_coold_hr"}, "color":"red"}, {"text":" seconds", "color":"red"}, " before you can hearth again."]
# Give them back a potion and remove the tag
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run function hearth:stone
clear @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] minecraft:glass_bottle 1
execute as @a[tag=hearth_needs_tp,scores={hearth_cooldown=1..}] run tag @s remove hearth_needs_tp
# Decrement the cooldown for everyone
scoreboard players remove @a[scores={hearth_cooldown=1..}] hearth_cooldown 1

# Select 1 person from the group of hearth_needs_tp and set them as the active teleporter if nobody else is.
# This ensures only 1 person TPs at the same time since we only have 1 hearth_cloud
execute unless entity @a[tag=hearth_active_tp] as @a[tag=hearth_needs_tp,limit=1] run tag @s add hearth_active_tp

# This is always looking for the hearth_active_tp
execute as @a[tag=hearth_active_tp] run tag @s remove hearth_needs_tp
kill @e[tag=hearth_cloud]
execute if entity @a[tag=hearth_active_tp] run function hearth:tp

# Allow triggers
scoreboard players enable @a hearth_set
scoreboard players enable @a hearth_stone

# Run triggers
execute as @a[scores={hearth_set=1}] run function hearth:set
execute as @a[scores={hearth_set=1}] run scoreboard players set @s hearth_set 0

execute as @a[scores={hearth_stone=1}] run function hearth:stone
execute as @a[scores={hearth_stone=1}] run scoreboard players set @s hearth_stone 0
