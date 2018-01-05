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
	    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...
      name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(arg2)
			value = MX.TSM:GetItemValue(arg2, "DBMarket");
      if (value ~= nil and value >= Farmer_Logic_MinAlert and quality >= 1) then
        MX:SendAlert(arg2,value);
      end
	end)
