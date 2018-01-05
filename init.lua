-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MxW, mx = ...
local MX = LibStub("AceAddon-3.0"):NewAddon(mx, MxW, "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

local MXLDB = LibStub("LibDataBroker-1.1"):NewDataObject("MxW", {
	type = "data source",
	text = "MxW",
	icon = "Interface\\Icons\\Inv_misc_herb_goldclover",
	OnClick = function() MX:ShowMain(); end,
})
local icon = LibStub("LibDBIcon-1.0")

function MX:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("MxWDB", {
		profile = {
			minimap = {
				hide = false,
			},
		},
	})
	icon:Register("MxW", MXLDB, self.db.profile.minimap)
end

-- Meta Data
local mxwVersion = GetAddOnMetadata("MxW", "Version")

-- Init Saved Variables
if (Farmer_Logic_Day == nil) then
	local weekday, month, day, year = CalendarGetDate();
  Farmer_Logic_Day = day;
end
if (Farmer_Money_DayGlobal == nil) then
  Farmer_Money_DayGlobal = 0;
end
if (Farmer_Money_MonthGlobal == nil) then
  Farmer_Money_MonthGlobal = 0;
end
if (Farmer_Money_DayPlayer == nil) then
  Farmer_Money_DayPlayer = 0;
end
if (Farmer_Money_MonthPlayer == nil) then
  Farmer_Money_MonthPlayer = 0;
end
if (Farmer_Logic_MinUI == nil) then
  Farmer_Logic_MinUI = 3000;
end
if (Farmer_Logic_MinAlert == nil) then
  Farmer_Logic_MinAlert = 3000;
end

-- Message
print("MxW v." .. mxwVersion .. L["Message_Loaded"]);
