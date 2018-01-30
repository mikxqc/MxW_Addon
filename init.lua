-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):NewAddon("MxW", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");
local AceGUI = LibStub("AceGUI-3.0")

local MXLDB = LibStub("LibDataBroker-1.1"):NewDataObject("MxW", {
	type = "data source",
	text = "MxW",
	icon = "Interface\\Icons\\Inv_misc_herb_goldclover",
	OnClick = function() MX:ShowMain(); end,
})
local icon = LibStub("LibDBIcon-1.0")

local defaults = {
	profile = {
		debug = false,
		version = 0,
		minimapIcon = { hide = false, minimapPos = 220, radius = 80, },
		mainUI = 0
	}
}

function MX:OnInitialize()
	self.db = LibStub:GetLibrary("AceDB-3.0"):New("MxWDB")

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
	if (Farmer_Logic_MinUI == nil) then
	  Farmer_Logic_MinUI = 500000; -- 50 golds
	end
	if (Farmer_Logic_MinAlert == nil) then
	  Farmer_Logic_MinAlert = 1000000; -- 100 golds
	end

	if (self.db.profile.mainUI == nil) then
		self.db.profile.mainUI = { ["height"] = 100, ["top"] = 50, ["left"] = 50, ["width"] = 300, }
	end

	if (self.db.profile.lootlistUI == nil) then
		self.db.profile.lootlistUI = { ["height"] = 100, ["top"] = 50, ["left"] = 50, ["width"] = 300, }
	end

	-- Meta Data
	local mxwVersion = GetAddOnMetadata("MxW", "Version")
	self.db.profile.version = mxwVersion

	-- Message
	print("MxW v." .. self.db.profile.version .. L["Message_Loaded"]);
end

function MX:OnEnable()
	  MX:ShowMainUI()
end
