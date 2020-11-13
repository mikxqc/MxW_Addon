-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/mikx/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):NewAddon("MxW", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");
local AceGUI = LibStub("AceGUI-3.0")

local date = C_DateAndTime.GetCurrentCalendarTime();
local weekday, month, day, year = date.weekday, date.month, date.monthDay, date.year;

local MXLDB = LibStub("LibDataBroker-1.1"):NewDataObject("MxW", {
	type = "data source",
	text = "MxW",
	icon = "Interface\\Icons\\Inv_misc_herb_goldclover",
	OnClick = function() MX:ShowMainUI(); end,
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
	  Farmer_Logic_Day = day;
	end
	if (Farmer_Money_DayGlobal == nil) then
	  Farmer_Money_DayGlobal = 0;
	end
	if (Farmer_Money_MonthGlobal == nil) then
	  Farmer_Money_MonthGlobal = 0;
	end
	if (Farmer_Money_LootSession == nil) then
	  Farmer_Money_LootSession = 0;
	end
	if (Farmer_Logic_MinUI == nil) then
	  Farmer_Logic_MinUI = 500000; -- 50 golds
	end
	if (Farmer_Logic_MinAlert == nil) then
	  Farmer_Logic_MinAlert = 1000000; -- 100 golds
	end
	if (Settings_Alert_Enabled == nil) then
	  Settings_Alert_Enabled = true;
	end
	if (Settings_GuildMessage_Enabled == nil) then
	  Settings_GuildMessage_Enabled = true;
	end

	local parentHeight = UIParent:GetHeight()

	if (self.db.profile.mainUI == nil) then
		self.db.profile.mainUI = { ["height"] = 100, ["top"] = parentHeight-50, ["left"] = 50, ["width"] = 300, }
	end

	if (self.db.profile.lootlistUI == nil) then
		self.db.profile.lootlistUI = { ["height"] = 100, ["top"] = parentHeight-50, ["left"] = 50, ["width"] = 300, }
	end

	if (self.db.profile.settingsUI == nil) then
		self.db.profile.settingsUI = { ["height"] = 140, ["top"] = parentHeight-50, ["left"] = 50, ["width"] = 250, }
	end

	if (DailyTen == nil) then
		DailyTen = false
	end
	if (DailyTwenty == nil) then
		DailyTwenty = false
	end
	if (DailyThirty == nil) then
		DailyThirty = false
	end
	if (DailyForty == nil) then
		DailyForty = false
	end
	if (DailyFifty == nil) then
		DailyFifty = false
	end
	if (DailySixty == nil) then
		DailySixty = false
	end
	if (DailySeventy == nil) then
		DailySeventy = false
	end
	if (DailyEighty == nil) then
		DailyEighty = false
	end
	if (DailyNinety == nil) then
		DailyNinety = false
	end
	if (DailyHundred == nil) then
		DailyHundred = false
	end

	if (DayCounter == nil) then
		DayCounter = 1;
	end

	-- Meta Data
	local mxwVersion = GetAddOnMetadata("MxW", "Version")
	self.db.profile.version = mxwVersion

	-- Message
	print("MxW v." .. self.db.profile.version .. L["Message_Loaded"]);
end

local function MyAddonCommands(msg, editbox)
  if msg == 'restore' then
		if (Farmer_Logic_Day ~= day) then
			Farmer_Money_DayGlobal = 0;
			Farmer_Money_MonthGlobal = Farmer_Money_MonthBack;
			ReloadUI();
		elseif (Farmer_Logic_Day == day) then
			Farmer_Money_MonthGlobal = Farmer_Money_MonthBack + Farmer_Money_DayGlobal;
			ReloadUI();
		end
  elseif (msg == 'reset') then
		if (Farmer_Logic_Day ~= day) then
			Farmer_Money_DayGlobal = 0;
			Farmer_Money_MonthBack = Farmer_Money_MonthGlobal;
			Farmer_Money_MonthGlobal = 0;
			DayCounter = 1;
			DailyRecord = 1;
			DailyRecordFlag = false;
			ReloadUI();
		else
			Farmer_Money_MonthBack = Farmer_Money_MonthGlobal;
			Farmer_Money_MonthGlobal = Farmer_Money_DayGlobal;
			Farmer_Money_DayGlobal = 0;
			DayCounter = 1;
			DailyRecord = 1;
			DailyRecordFlag = false;
			ReloadUI();
		end
	elseif (msg == 'resetd' or msg == 'resetday') then
		Farmer_Money_DayGlobal = 0;
		ReloadUI();
	elseif (msg == 'resetl' or msg == 'resetloot') then
		Farmer_Money_LootSession = 0;
		ReloadUI();
	elseif (msg == 'alert') then
		if (Settings_Alert_Enabled) then
			Settings_Alert_Enabled = false;
			print(L["Settings_Alert_Disabled"])
		else
			Settings_Alert_Enabled = true;
			print(L["Settings_Alert_Enabled"] .. MX:FormatMoney(Farmer_Logic_MinAlert))
		end
	elseif (msg == 'gmsg') then
		if (Settings_GuildMessage_Enabled) then
			Settings_GuildMessage_Enabled = false;
			print(L["Settings_GuildMessage_Disabled"])
		else
			Settings_GuildMessage_Enabled = true;
			print(L["Settings_GuildMessage_Enabled"])
		end
	elseif (msg == 'config') then
			MX:ShowSettingsUI();
	else
    print(L["ChatCMD_Help"])
  end
end

SLASH_MXW1 = '/mxw'

SlashCmdList["MXW"] = MyAddonCommands

function MX:OnEnable()
	  MX:ShowMainUI()
end
