-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

local ENCOUNTER_LOOT_RECEIVED_Frame = CreateFrame("Frame")
ENCOUNTER_LOOT_RECEIVED_Frame:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")
ENCOUNTER_LOOT_RECEIVED_Frame:SetScript("OnEvent",
    function(self, event, ...)
	    local encounterID, itemID, itemLink, quantity, playerName, className, arg7, arg8, arg9 = ...
      name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemID)
			value = MX.TSM:GetItemValue(itemID, "DBMarket");
      local pn = UnitName("player");
      if (value ~= nil and value >= Farmer_Logic_MinAlert and quality >= 1 and playerName == pn) then
        MX:SendAlert(itemID,value);
      end
	end)
