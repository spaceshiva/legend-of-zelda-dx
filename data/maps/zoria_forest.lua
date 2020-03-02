-- This script saves how many times you talk to the beaver by the stairs.
-- It uses that information to decide which dialogs to show you.

-- It's always a good idea to keep the docs open when editing a quest!
-- http://www.solarus-games.org/doc/latest/


local map = ...  -- (the engine magically puts the map into a variable)
local game = map:get_game()


function map:on_started()

    hero:set_tunic_sprite_id("hero/rachel_tunic")
    hero:set_sword_sprite_id("hero/rachel_sword")

    -- Control how the beavers work
    -- Starting with beaver bro (at the bottom of the stairs)

    local beaver_bro = map:get_entity("beaver_bro")
    beaver_bro.count = 0

    function beaver_bro:on_interaction()

        -- Count how many times we've talked
        self.count = self.count + 1

        if self.count > 1 then
          game:start_dialog("beavers.brother.2")
        else
          game:start_dialog("beavers.brother.1")
        end
    end

    -- Beaver eater's behavior

    local beaver_eater = map:get_entity("beaver_eater")

    function beaver_eater:on_interaction()
        if beaver_bro.count > 1 then -- consider how many times we've talked with beaver_bro
            game:start_dialog("beavers.eater.2")
        else
            game:start_dialog("beavers.eater.1")
        end
    end

end

function map:on_finished()

    local hero = game:get_hero()
    hero:set_tunic_sprite_id("hero/tunic1")
    hero:set_sword_sprite_id("hero/sword1")

end
