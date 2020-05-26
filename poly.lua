-- Author Alerino
-- Version 1.0
-- Date 05.11.2019
-- Github https://github.com/Alerinos

quest poly begin
     state start begin
        
        function config()
            return {
                [1] = {101, 100},
                [2] = {502, 100},
                [3] = {2001, 100},
                [4] = {636, 150}
            }
        end
         
        when 20019.click begin -- chat."Marmur" 
            local config = poly.config()
            
            if pc.getqf("mob") > 0 then
                setskin(NOWINDOW)
                syschat(prefix.info.."Masz już misję...")
                return
            end
            
            say_title(mob_name(npc.get_vnum0()))
            local s = select(mob_name(config[1][1]), mob_name(config[2][1]), mob_name(config[3][1]), mob_name(config[4][1]), "Anuluj")
            if s == 5 then
                return
            else
                say_title(mob_name(npc.get_vnum0()))
                
                pc.setqf("mob", s)
                pc.setqf("count", config[s][2])
                
                say("Zabij "..config[s][2].."szt. "..mob_name(config[s][1]))
                
                send_letter_ex(mob_name(npc.get_vnum0()), "green,ex", "npc_yangshin_open.tga")
                q.set_counter(mob_name(config[s][1]), config[s][2])
            end
            
        end
        
        when button or info with pc.getqf("mob") > 0 begin
            local config = poly.config()
            local mob = pc.getqf("mob")
            local count = pc.getqf("count")
            
            say_title(mob_name(20019))
            say("Polowanie na "..mob_name(config[mob][1]))
            say("Zostało "..count.." szt.")
            q.set_counter(mob_name(config[mob][1]), config[s][2])
        end
        
        when login with pc.getqf("mob") > 0 begin
            local config = poly.config()
            local mob = pc.getqf("mob")
            local count = pc.getqf("count")
        
            send_letter_ex(mob_name(20019), "green,ex", "npc_yangshin_open.tga")
            q.set_counter(mob_name(config[mob][1]), count)
        end
        
        when kill with pc.getqf("mob") > 0 begin
            local config = poly.config()
            local mob = pc.getqf("mob")
            
            if npc.get_vnum0() == config[mob][1] then
                local count = pc.getqf("count") - 1
                
                q.set_counter(mob_name(config[mob][1]), count)
                
                if count == 0 then
                    pc.setqf("mob", 0)
                    
                    pc.give_item2_select(70104)
                    item.set_socket(0, npc.get_race())
                    
                    syschat(prefix.info.."Otrzymałeś "..item_name(70104))
                end
                
                pc.setqf("count", count)
            end
        end
        
     end
 end