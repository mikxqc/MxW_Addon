-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/wow/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

-- local
local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");
local AceGUI = LibStub("AceGUI-3.0")
local GUI_LOOTCOLLECTED, GUI_SCROLLCONTAINER
local lootCollectedLastEntry = nil
local mxwVersion = GetAddOnMetadata("MxW", "Version")

local backdrop = {
		bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 2,
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	}

local labTodayGold = AceGUI:Create("Label")
local labMonthGold = AceGUI:Create("Label")
local labDailyRecord = AceGUI:Create("Label")
local labDayCounter = AceGUI:Create("Label")

local EditBoxMinAlert = AceGUI:Create("EditBox")

function MX:ShowMainUI()
  local MAIN_UI = AceGUI:Create("Window")
  MAIN_UI:SetHeight(80)
  MAIN_UI:SetTitle("MxW " .. self.db.profile.version)
  MAIN_UI:SetStatusTable(self.db.profile.mainUI)
  MAIN_UI:SetLayout("List")
  MAIN_UI:SetWidth(200)
  MAIN_UI:EnableResize(false)

	labDayCounter:SetFont("Interface\\Addons\\MxW\\Media\\Font\\Homespun.ttf", 10)
  labDayCounter:SetColor(1, 1, 1)
  labDayCounter:SetFullWidth(true)
  MAIN_UI:AddChild(labDayCounter)

	local labSpaceA = AceGUI:Create("Label")
  labSpaceA:SetFont("Fonts\\FRIZQT__.TTF", 10)
  labSpaceA:SetColor(1, 1, 1)
  labSpaceA:SetFullWidth(true)
  labSpaceA:SetText("  ")
  MAIN_UI:AddChild(labSpaceA)

  labTodayGold:SetFont("Interface\\Addons\\MxW\\Media\\Font\\Homespun.ttf", 10)
  labTodayGold:SetColor(1, 1, 1)
  labTodayGold:SetFullWidth(true)
  MAIN_UI:AddChild(labTodayGold)

  labMonthGold:SetFont("Interface\\Addons\\MxW\\Media\\Font\\Homespun.ttf", 10)
  labMonthGold:SetColor(1, 1, 1)
  labMonthGold:SetFullWidth(true)
  MAIN_UI:AddChild(labMonthGold)

  local labSpaceB = AceGUI:Create("Label")
  labSpaceB:SetFont("Fonts\\FRIZQT__.TTF", 10)
  labSpaceB:SetColor(1, 1, 1)
  labSpaceB:SetFullWidth(true)
  labSpaceB:SetText("  ")
  MAIN_UI:AddChild(labSpaceB)

	labDailyRecord:SetFont("Interface\\Addons\\MxW\\Media\\Font\\Homespun.ttf", 10)
  labDailyRecord:SetColor(1, 1, 1)
  labDailyRecord:SetFullWidth(true)
  MAIN_UI:AddChild(labDailyRecord)

  local BUTTON_SETTINGS = AceGUI:Create("Button")
	BUTTON_SETTINGS:SetAutoWidth(true)
	BUTTON_SETTINGS:SetText(L["MainForm_Button_Settings"])
  BUTTON_SETTINGS:SetPoint("RIGHT", 5, 15)
	BUTTON_SETTINGS:SetCallback("OnClick",
		function()
		    MX:ShowSettingsUI()
		end
	)
	--MAIN_UI:AddChild(BUTTON_SETTINGS)
end

function MX:ShowSettingsUI()
	local SETTINGS_UI = AceGUI:Create("Window")
  SETTINGS_UI:SetHeight(150)
  SETTINGS_UI:SetTitle(L["MainForm_Button_Settings"])
  SETTINGS_UI:SetStatusTable(self.db.profile.settingsUI)
  SETTINGS_UI:SetLayout("List")
  SETTINGS_UI:SetWidth(300)

	EditBoxMinAlert:SetLabel(L["SettingsUI_EditBox_MinAlert"])
	local money = floor(Farmer_Logic_MinAlert / (COPPER_PER_SILVER * SILVER_PER_GOLD))
	EditBoxMinAlert:SetText(money)
	EditBoxMinAlert:SetCallback("OnEnterPressed",
		function()
			local value = EditBoxMinAlert:GetText()
		  local fv = floor(value * (COPPER_PER_SILVER * SILVER_PER_GOLD))
			Farmer_Logic_MinAlert = fv
			ReloadUI();
		end
	)
	SETTINGS_UI:AddChild(EditBoxMinAlert)

	local labSpace = AceGUI:Create("Label")
	labSpace:SetFont("Fonts\\FRIZQT__.TTF", 10)
	labSpace:SetColor(1, 1, 1)
	labSpace:SetFullWidth(true)
	labSpace:SetText("  ")
	SETTINGS_UI:AddChild(labSpace)

	local BUTTON_RESET = AceGUI:Create("Button")
	BUTTON_RESET:SetAutoWidth(true)
	BUTTON_RESET:SetText(L["SettingsUI_Button_Reset"])
  BUTTON_RESET:SetPoint("RIGHT", 5, 15)
	BUTTON_RESET:SetCallback("OnClick",
		function()
			if (Farmer_Logic_Day ~= day) then
        Farmer_Money_DayGlobal = 0;
        Farmer_Money_MonthBack = Farmer_Money_MonthGlobal;
				Farmer_Money_MonthGlobal = 0;
				ReloadUI();
      else
				Farmer_Money_MonthBack = Farmer_Money_MonthGlobal;
				Farmer_Money_MonthGlobal = Farmer_Money_DayGlobal;
				Farmer_Money_DayGlobal = 0;
				ReloadUI();
			end
		end
	)
	SETTINGS_UI:AddChild(BUTTON_RESET)
end

function MX:ShowListUI()
  local LOOTLIST_UI = AceGUI:Create("Window")
  LOOTLIST_UI:SetHeight(100)
  LOOTLIST_UI:SetTitle(L["MainForm_Button_LootList"])
  LOOTLIST_UI:SetStatusTable(self.db.profile.lootlistUI)
  LOOTLIST_UI:SetLayout("List")
  LOOTLIST_UI:SetWidth(300)

  GUI_SCROLLCONTAINER = AceGUI:Create("SimpleGroup")
	GUI_SCROLLCONTAINER:SetFullWidth(true)
	GUI_SCROLLCONTAINER:SetHeight(150)
	GUI_SCROLLCONTAINER:SetLayout("Fill")
	GUI_SCROLLCONTAINER.frame:SetBackdrop(backdrop)
	GUI_SCROLLCONTAINER.frame:SetBackdropColor(0, 0, 0)
	GUI_SCROLLCONTAINER.frame:SetBackdropBorderColor(0.4, 0.4, 0.4)

  GUI_LOOTCOLLECTED = AceGUI:Create("ScrollFrame")
	GUI_LOOTCOLLECTED:SetLayout("Flow")
	LOOTLIST_UI:AddChild(GUI_SCROLLCONTAINER)
  GUI_SCROLLCONTAINER:AddChild(GUI_LOOTCOLLECTED)
end

local MainFrame_Event_ADDON_LOADED = CreateFrame("Frame")
MainFrame_Event_ADDON_LOADED:RegisterEvent("ADDON_LOADED")
MainFrame_Event_ADDON_LOADED:SetScript("OnEvent", function(self, event, ...)

end)

local MainFrame_Event_PLAYER_ENTERING_WORLD  = CreateFrame("Frame")
MainFrame_Event_PLAYER_ENTERING_WORLD :RegisterEvent("PLAYER_ENTERING_WORLD")
MainFrame_Event_PLAYER_ENTERING_WORLD :SetScript("OnEvent", function(self, event, ...)
	local date = C_Calendar.GetDate()
	local weekday = date.weekday
	local month = date.month
	local day = date.monthDay
	local year = date.year
  -- Init gold variable
  CurrentGold = GetMoney()
	-- Reset Global Daily Counter
	if(DailyRecord == nil) then
		DailyRecord = Farmer_Money_DayGlobal;
		DailyRecordFlag = false;
	end
	if (Farmer_Logic_Day ~= day) then
		if(DailyRecordFlag) then
			DailyRecordFlag = false;
		end
		Farmer_Money_DayGlobal = 0;
		Farmer_Logic_Day = day;
		DailyTen = false;
		DailyTwenty = false;
		DailyThirty = false;
		DailyForty = false;
		DailyFifty = false;
		DailySixty = false;
		DailySeventy = false;
		DailyEighty = false;
		DailyNinety = false;
		DailyHundred = false;
		DayCounter = DayCounter + 1;
	end
	if (DayCounter >= 31) then
		Farmer_Money_MonthBack = Farmer_Money_MonthGlobal;
		Farmer_Money_MonthGlobal = 0;
		Farmer_Money_DayGlobal = 0;
		DayCounter = 1;
		DailyRecord = 1;
		DailyRecordFlag = false;
		DailyTen = false;
		DailyTwenty = false;
		DailyThirty = false;
		DailyForty = false;
		DailyFifty = false;
		DailySixty = false;
		DailySeventy = false;
		DailyEighty = false;
		DailyNinety = false;
		DailyHundred = false;
	end
  MX:UpdateMainUI()
end)

function MX:UpdateMainUI()
	local DayColor = "|cff1ead01";
	local GoldMedian = floor(Farmer_Money_MonthGlobal / DayCounter);
  labTodayGold:SetText(format("%s (%s)", MX:FormatMoney(Farmer_Money_DayGlobal),L["MainForm_Label_Money_Lab_Today"]))
  labMonthGold:SetText(format("%s (%s)", MX:FormatMoney(Farmer_Money_MonthGlobal),L["MainForm_Label_Money_Lab_Month"]))
	labDailyRecord:SetText(format("%s %s", MX:FormatMoneyGoldOnly(DailyRecord), L["Chat_ChatGuildDailyRecordUI"]))
	labDayCounter:SetText(format("%s %s%i/30|r (~%s/%s)", L["MainForm_Label_DayCounter"], DayColor, DayCounter, MX:FormatMoneyGoldOnly(GoldMedian),L["MainForm_Label_Money_Lab_Today"]))
end

function MX:ShowMain()
  f:Show();
end

function MX:ShowHistory()
  MAIN_UI:Show()
end

function MX:addItem2LootCollectedList(v,texture)
	-- prepare text

	-- item / link
	local LABEL = AceGUI:Create("InteractiveLabel")
	LABEL.frame:Show()
	LABEL:SetText(v)
	LABEL.label:SetJustifyH("LEFT")
	LABEL:SetWidth(350)
  LABEL:SetImage(texture)
  LABEL:SetImageSize(18,18)

  if lootCollectedLastEntry then
		GUI_LOOTCOLLECTED:AddChild(LABEL, lootCollectedLastEntry)
	else
		GUI_LOOTCOLLECTED:AddChild(LABEL)
	end

	-- rember the created entry to add the next entry before this -> reverse list with newest entry on top
	lootCollectedLastEntry = LABEL
end
