-- Glowing Air Mod
-- Creates a glowing air block that emits maximum light

minetest.register_node("glow_air:glow_air", {
    description = "Glowing Air",
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    floodable = true,
    groups = {not_in_creative_inventory = 1},
    drop = "",
    light_source = 15,
})

-- Command to place glowing air around the player
minetest.register_chatcommand("glowair", {
    params = "<radius>",
    description = "Place glowing air in a radius around you",
    privs = {},
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local radius = tonumber(param) or 5
        local pos = player:get_pos()

        for x = -radius, radius do
            for y = -radius, radius do
                for z = -radius, radius do
                    local node_pos = vector.add(pos, {x=x, y=y, z=z})
                    -- Only replace air nodes
                    local node = minetest.get_node(node_pos)
                    if node.name == "air" then
                        minetest.set_node(node_pos, {name="glow_air:glow_air"})
                    end
                end
            end
        end

        return true, "Placed glowing air with radius " .. radius
    end,
})
