-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

-- TSM.lua
-- TradeSkillMaster Functions

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");

local TSMVERSION = GetAddOnMetadata("TradeSkillMaster", "Version")

MX.TSM = MX.TSM or {}

-- GetItemValue(itemID, priceSource)
-- Return itemID value as a int using priceSource
function MX.TSM:GetItemValue(itemID, priceSource)
	return TSMAPI:GetItemValue(itemID, priceSource)
end
