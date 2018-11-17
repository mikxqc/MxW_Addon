-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/wow/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

local numItems
local iLink
local value

local LOOT_OPENED_Frame = CreateFrame("Frame")
LOOT_OPENED_Frame:RegisterEvent("LOOT_OPENED")
LOOT_OPENED_Frame:SetScript("OnEvent",
    function(self, event, ...)

      -- Check if loot slot qty is over 0
      if GetNumLootItems() > 0 then
        -- save the loot slot qty to a variable
        numItems = GetNumLootItems()
        -- loop each loot slot
        for i = 1, numItems do
          -- get loot slot link to get iteminfo, we can't use item name due to API limitation
          iLink = GetLootSlotLink(i)
          -- get the iteminfo and continue only if the itemlink is not empty (EXEMPLE: money in a slot = empty)
          if (iLink ~= nil) then
            -- get the iteminfo using the slot itemlink
            name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(iLink)
            -- get the item value using the link, return nil if the item has no value
            value = MX.TSM:GetItemValue(link, "DBMarket");

            -- MINIMUM QUALITY SETTINGS ------
            local eq = 2 -- equipable quality
            local mq = 1 -- mats quality
            local cq = 1 -- consumable quality
            local oq = 1 -- other quality
            local rq = 1 -- recipe quality
            ----------------------------------
            -- if value is nil, the object is not BoE/not known by TSM & Looter is the player
            -- we use locales because the item class is localized by the client
            if (value ~= nil and Settings_Alert_Enabled) then
              if(class == L["Alert_Class_Armor"]) then
                if (value >= Farmer_Logic_MinAlert and quality >= eq) then
                  MX:SendAlert(link,value);
                  MX:ChatGuildLootMessage(link,value);
                end
              elseif(class == L["Alert_Class_Weapon"]) then
                if (value >= Farmer_Logic_MinAlert and quality >= eq) then
                  MX:SendAlert(link,value);
                  MX:ChatGuildLootMessage(link,value);
                end
              elseif(class == L["Alert_Class_TradeGoods"]) then
                if (value >= Farmer_Logic_MinAlert and quality >= mq) then
                  MX:SendAlert(link,value);
                  MX:ChatGuildLootMessage(link,value);
                end
              elseif(class == L["Alert_Class_Consumable"]) then
                if (value >= Farmer_Logic_MinAlert and quality >= cq) then
                  MX:SendAlert(link,value);
                  MX:ChatGuildLootMessage(link,value);
                end
              elseif(class == L["Alert_Class_Misc"]) then
                if (value >= Farmer_Logic_MinAlert and quality >= oq) then
                  MX:SendAlert(link,value);
                  MX:ChatGuildLootMessage(link,value);
                end
              elseif(class == "Recipe") then
                if (value >= Farmer_Logic_MinAlert and quality >= rq) then
                  MX:SendAlert(link,value);
                  MX:ChatGuildLootMessage(link,value);
                end
              end
              value = nil
              iLink = nil
          end
          end
      end
    end

end)
