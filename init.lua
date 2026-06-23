-- Glowing Air Mod for Minetest/Luanti
-- Creates an air block that emits maximum light (light level 15)

local modname = "glowing_air"

-- Register the glowing air node
minetest.register_node("glowing_air:air", {
    description = "Glowing Air",
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    floodable = true,
    is_ground_content = false,
    light_source = minetest.LIGHT_MAX, -- Maximum light emission (15)
    groups = {not_in_creative_inventory = 1},
})

-- Function to replace regular air with glowing air in specific areas or globally
-- This can be customized based on your needs
local function set_glowing_air(x, y, z)
    local node = minetest.get_node({x=x, y=y, z=z})
    if node.name == "air" then
        minetest.set_node({x=x, y=y, z=z}, {name="glowing_air:air"})
    end
end

-- Optional: Command to toggle glowing air in an area
minetest.register_chatcommand("glowair", {
    params = "<radius>",
    description = "Replace air with glowing air around you",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then return false end
        
        local pos = player:get_pos()
        local radius = tonumber(param) or 5
        
        for x = pos.x - radius, pos.x + radius do
            for y = pos.y - radius, pos.y + radius do
                for z = pos.z - radius, pos.z + radius do
                    set_glowing_air(x, y, z)
                end
            end
        end
        
        minetest.chat_send_player(name, "Glowing air placed in radius " .. radius)
        return true
    end,
})

minetest.register_on_mods_loaded(function()
    minetest.log("action", "[MOD] Glowing Air loaded successfully!")
end)
