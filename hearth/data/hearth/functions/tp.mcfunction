# This function does the actual tp
# It's expected it was already checked that we can TP
execute at @a[tag=hearth_active_tp] run summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0.5f, Duration:600, Particle:"dripWater", Tags:["hearth_cloud"]}
execute at @a[tag=hearth_active_tp] store result entity @e[tag=hearth_cloud,sort=nearest,limit=1] Pos[0] double 0.01 run scoreboard players get @p hearth_x
execute at @a[tag=hearth_active_tp] store result entity @e[tag=hearth_cloud,sort=nearest,limit=1] Pos[1] double 0.01 run scoreboard players get @p hearth_y
execute at @a[tag=hearth_active_tp] store result entity @e[tag=hearth_cloud,sort=nearest,limit=1] Pos[2] double 0.01 run scoreboard players get @p hearth_z
execute as @a[tag=hearth_active_tp] run tp @s @e[tag=hearth_cloud,limit=1]
# 20 minutes = 1200 seconds. 1200 seconds * 20 (ticks per second) = 24000
scoreboard players set @a[tag=hearth_active_tp] hearth_cooldown 24000
execute as @a[tag=hearth_active_tp] run tag @s remove hearth_active_tp
