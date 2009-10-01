#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <fun>
#include <cstrike>
new loot_origins[33][3]
new loot_spr
public pfn_touch(ptr,ptd)
{
	if(!is_user_connected(ptd))
        	return PLUGIN_CONTINUE
	if(get_cvar_num("amx_loot")==0)
        	return PLUGIN_CONTINUE
	if(is_valid_ent(ptr))
	{
		new szClass[32],scClass[32]
		entity_get_string(ptr,EV_SZ_classname,szClass,31)
		entity_get_string(ptd,EV_SZ_classname,scClass,31)
		if(equal(szClass,"loot_marker"))
		{
			if(equal(scClass,"player"))
			{
				new id = entity_get_edict(ptr,EV_ENT_owner)
				if(!is_user_connected(id))
					return PLUGIN_CONTINUE
				if(find_ent_by_owner(-1,"loot_marker",id)!=0)
					remove_entity(find_ent_by_owner(-1,"loot_marker",id))
				remove_task(462+id)
				give_random(ptd)
            			emit_sound(ptd,CHAN_VOICE,"common/bodydrop1.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
           	 		new random_money
           	 		random_money = random(cs_get_user_money(id))
				new name[32], name2[32]
           	 		get_user_name(ptd,name,32)
				get_user_name(id,name2,32)
            			if(random_money < 16001 && random_money > 0)
				{
            				client_print(0,print_chat,"[AMXX] %s looted $%d from %s",name ,random_money, name2)  
            				cs_set_user_money(ptd,cs_get_user_money(ptd) + random_money)
            				cs_set_user_money(id,cs_get_user_money(id) - random_money)
            			}
				else
            				client_print(0,print_chat,"[AMXX] %s didnt find any money on %s",name , name2)
    			}
		}
	}
	return PLUGIN_CONTINUE
}
public player_die()
{
	if(get_cvar_num("amx_loot")==0)
        	return PLUGIN_CONTINUE
	new victim = read_data(2)
	new Float:origina[3]
    	get_user_origin(victim,loot_origins[victim],0)
   	new parm[1]
   	parm[0] = victim
	set_task(1.0,"loot_sprite",462+victim,parm,1,"b")
	new mark = create_entity("info_target")
	entity_set_string(mark,EV_SZ_classname,"loot_marker")
	entity_set_int(mark,EV_INT_solid,1)
	origina[0] = float(loot_origins[victim][0])
	origina[1] = float(loot_origins[victim][1])
	origina[2] = float(loot_origins[victim][2])
	entity_set_origin(mark,origina)
	entity_set_float(mark,EV_FL_scale,0.2)
	entity_set_edict(mark,EV_ENT_owner,victim)
   	return PLUGIN_CONTINUE
}
public loot_sprite(parm[])
{
        //TE_SPRITE
        message_begin(MSG_ALL,SVC_TEMPENTITY)
        write_byte(17) // additive sprite, plays 1 cycle
        write_coord(loot_origins[parm[0]][0]) // pos
        write_coord(loot_origins[parm[0]][1]) // pos
        write_coord(loot_origins[parm[0]][2]) // pos
        write_short (loot_spr) // spr index
        write_byte(2) // (scale in 0.1's)
        write_byte (1000) //(brightness)
        message_end()
}
public new_round(id)
{
	while(find_ent_by_class(-1,"loot_marker") != 0)
		remove_entity(find_ent_by_class(-1,"loot_marker"))
	if(task_exists(462+id))
        	remove_task(462+id)
    	return PLUGIN_CONTINUE
}
public client_disconnect(id)
{
	if(get_cvar_num("amx_loot")==1)
	{
		if(task_exists(462+id))
        		remove_task(462+id)
		if(find_ent_by_owner(-1,"loot_marker",id)!=0)
			remove_entity(find_ent_by_owner(-1,"loot_marker",id))
	}
}
public give_random(id)
{
   	new random_weapon
   	random_weapon = (random_num(1,10))//**ammo**
   	give_weapon(id,random_weapon)
   	random_weapon = (random_num(1,85))//**anything**
   	give_weapon(id,random_weapon)
   	random_weapon = (random_num(81,85))//**nade/armor**
   	give_weapon(id,random_weapon)
   	random_weapon = (random_num(2,20))//**pistol**
   	give_weapon(id,random_weapon)
   	return PLUGIN_CONTINUE
}
public give_weapon(id,weapon)
{
	if(!is_user_alive(id))
        	return PLUGIN_HANDLED
	switch (weapon)
	{
		//secondary weapons
		//pistols
		case 1:{
		        client_print(id,print_chat,"You got a full ammo.")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")				
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")		
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_9mm")
                        give_item(id,"ammo_50ae")
                        give_item(id,"ammo_357sig")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_338magnum")
		}
		case 11:{
		        client_print(id,print_chat,"You got a usp.")
			give_item(id,"weapon_usp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
		}
		case 12:{ 
			client_print(id,print_chat,"You got a glock.")
			give_item(id,"weapon_glock18")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
		}
		case 13:{
			client_print(id,print_chat,"You got a deagle.")
			give_item(id,"weapon_deagle")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
			give_item(id,"ammo_50ae")
		}
		case 14:{
			client_print(id,print_chat,"You got a p228.")
			give_item(id,"weapon_p228")
			give_item(id,"ammo_357sig")
			give_item(id,"ammo_357sig")
			give_item(id,"ammo_357sig")
			give_item(id,"ammo_357sig")
			give_item(id,"ammo_357sig")
			give_item(id,"ammo_357sig")
		}
		case 15:{
			client_print(id,print_chat,"You got a pair of elites.")
			give_item(id,"weapon_elite")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
		}
		case 16:{
			client_print(id,print_chat,"You got a fiveseven.")
			give_item(id,"weapon_fiveseven")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_57mm")
		}
		//primary weapons
		//shotguns
		case 21:{
			client_print(id,print_chat,"You got a pump.")
			give_item(id,"weapon_m3")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
		}
		case 22:{
			client_print(id,print_chat,"You got a noob-cannon.")
			give_item(id,"weapon_xm1014")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
			give_item(id,"ammo_buckshot")
		}
		//smgs
		case 31:{
			client_print(id,print_chat,"You got a mp5.")
			give_item(id,"weapon_mp5navy")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
		}
		case 32:{
			client_print(id,print_chat,"You got a tmp.")
			give_item(id,"weapon_tmp")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
			give_item(id,"ammo_9mm")
		}
		case 33:{
			client_print(id,print_chat,"You got a p90.")
			give_item(id,"weapon_p90")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_57mm")
			give_item(id,"ammo_57mm")
		}
		case 34:{
			client_print(id,print_chat,"You got a mac10.")
			give_item(id,"weapon_mac10")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
		}
		case 35:{
			client_print(id,print_chat,"You got a ump.")
			give_item(id,"weapon_ump45")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
			give_item(id,"ammo_45acp")
		}
		//rifles
		case 40:{
			 give_item(id,"weapon_famas") 
			 give_item(id,"ammo_556nato") 
			 give_item(id,"ammo_556nato") 
			 give_item(id,"ammo_556nato") 
		}
		case 41:{
			client_print(id,print_chat,"You got a ak47.")
			give_item(id,"weapon_ak47")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
		}
		case 42:{
			client_print(id,print_chat,"You got a sig.")
			give_item(id,"weapon_sg552")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
		}
		case 43:{
			client_print(id,print_chat,"You got a colt.")
			give_item(id,"weapon_m4a1")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
		}
		case 44:{
			client_print(id,print_chat,"You got a aug.")
			give_item(id,"weapon_aug")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
		}
		case 45:{
			client_print(id,print_chat,"You got a scout.")
			give_item(id,"weapon_scout")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
		}
		case 46:{
			client_print(id,print_chat,"You got a AWP.")
			give_item(id,"weapon_awp")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_338magnum")
			give_item(id,"ammo_338magnum")
		}
		case 47:{
			client_print(id,print_chat,"You got a T-auto-snipe.")
			give_item(id,"weapon_g3sg1")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
			give_item(id,"ammo_762nato")
		}
		case 48:{
			client_print(id,print_chat,"You got a CT-auto-snipe.")
			give_item(id,"weapon_sg550")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
			give_item(id,"ammo_556nato")
		}
		case 49:{ 
			 give_item(id,"weapon_galil") 
			 give_item(id,"ammo_556nato") 
			 give_item(id,"ammo_556nato") 
			 give_item(id,"ammo_556nato") 
		}
		//machine gun
		case 51:{
			client_print(id,print_chat,"You got a para.")
			give_item(id,"weapon_m249")
			give_item(id,"ammo_556natobox")
			give_item(id,"ammo_556natobox")
			give_item(id,"ammo_556natobox")
			give_item(id,"ammo_556natobox")
			give_item(id,"ammo_556natobox")
			give_item(id,"ammo_556natobox")
			give_item(id,"ammo_556natobox")
		}
		//equipment
		case 81:{
			client_print(id,print_chat,"You got some armor.")
			give_item(id,"item_kevlar")
		}
		case 82:{
			client_print(id,print_chat,"You got more armor.")
			give_item(id,"item_assaultsuit")
		}
		case 83:{
			client_print(id,print_chat,"You got a flashbang.")
			give_item(id,"weapon_flashbang")
			give_item(id,"weapon_flashbang")
		}
		case 84:{
			client_print(id,print_chat,"You got a smoke nade.")
			give_item(id,"weapon_smokegrenade")
		}
		case 85:{ 
			 give_item(id,"weapon_shield")
		}
		default: return false
	}
	return true
}

public plugin_precache()
{
    	precache_sound("common/bodydrop1.wav")
    	loot_spr = precache_model("sprites/loot_bag.spr")
    	return PLUGIN_CONTINUE
}

public plugin_init()
{
    	register_plugin("loot","2.0","Rick O`Shae")
    	register_event("ResetHUD", "new_round", "b")
    	register_event("DeathMsg","player_die","a")
    	register_cvar("amx_loot","1")
}