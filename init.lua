-- Staff mod by archfan. Written October 2018
-- MIT license

minetest.register_craftitem("staff:staff", {
	description = "Staff",
	inventory_image = "staff_staff.png",
	on_use = function(itemstack, user, pointed_thing)
		
		spell = user:get_attribute("spell")

		if spell == "jump" then
			pos = user:get_pos()
			user:set_pos({x = pos.x, y = pos.y + 5, z = pos.z})
		end

		if spell == "invisibility" then
			user:set_properties({
				textures = {"staff_player_invisibility.png"},
			})
		end

	end,
})

-- Power system

local function power(player)
    local current_power =  player:get_attribute("power") or 0
    player:set_attribute("power", current_power + 1)
	minetest.chat_send_all("your power is at " .. player:get_attribute("power"))
    minetest.after(1, power, player)
end

minetest.register_on_joinplayer(function(player)
    power(player)
end)

-- Spells

minetest.register_craftitem("staff:spell_jump", {
	description = "Jump Spell (Teleports player 5 nodes into the air)",
	inventory_image = "staff_spell_jump.png",
	on_use = function(itemstack, user, pointed_thing)
		user:set_attribute("spell", "jump")
	end,
})

minetest.register_craftitem("staff:spell_none", {
	description = "Negate Spell (Sets your spell to 'none')",
	inventory_image = "staff_spell_none.png",
	on_use = function(itemstack, user, pointed_thing)
		user:set_attribute("spell", "none")
	end,
})

minetest.register_craftitem("staff:spell_invisibility", {
	description = "Invisibility Spell (You become transparent, but your nametag is still visible)",
	inventory_image = "staff_spell_invisibility.png",
	on_use = function(itemstack, user, pointed_thing)
		user:set_attribute("spell", "invisibility")
	end,
})