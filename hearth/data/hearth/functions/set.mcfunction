# Stores the user's hearth location
execute store result score @s hearth_x run data get entity @s Pos[0] 100
execute store result score @s hearth_y run data get entity @s Pos[1] 100
execute store result score @s hearth_z run data get entity @s Pos[2] 100
execute as @s run tellraw @s ["", {"text":"Hearth set.", "color": "aqua"}]
