-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
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

function MX:ShowMainUI()
  local MAIN_UI = AceGUI:Create("Window")
  MAIN_UI:SetHeight(100)
  MAIN_UI:SetTitle("MxW " .. self.db.profile.version)
  MAIN_UI:SetStatusTable(self.db.profile.mainUI)
  MAIN_UI:SetLayout("List")
  MAIN_UI:SetWidth(300)
  MAIN_UI:EnableResize(false)

  labTodayGold:SetFont("Fonts\\FRIZQT__.TTF", 10)
  labTodayGold:SetColor(1, 1, 1)
  labTodayGold:SetFullWidth(true)
  MAIN_UI:AddChild(labTodayGold)

  labMonthGold:SetFont("Fonts\\FRIZQT__.TTF", 10)
  labMonthGold:SetColor(1, 1, 1)
  labMonthGold:SetFullWidth(true)
  MAIN_UI:AddChild(labMonthGold)

  local labSpace = AceGUI:Create("Label")
  labSpace:SetFont("Fonts\\FRIZQT__.TTF", 10)
  labSpace:SetColor(1, 1, 1)
  labSpace:SetFullWidth(true)
  labSpace:SetText("  ")
  MAIN_UI:AddChild(labSpace)

  local BUTTON_LOOTLIST = AceGUI:Create("Button")
	BUTTON_LOOTLIST:SetAutoWidth(true)
	BUTTON_LOOTLIST:SetText(L["MainForm_Button_LootList"])
  BUTTON_LOOTLIST:SetPoint("RIGHT", 5, 15)
	BUTTON_LOOTLIST:SetCallback("OnClick",
		function()
		    MX:ShowListUI()
		end
	)
	MAIN_UI:AddChild(BUTTON_LOOTLIST)
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
  -- Init gold variable
  CurrentGold = GetMoney()
  MX:UpdateMainUI()
end)

function MX:UpdateMainUI()
  labTodayGold:SetText(format("%s (%s)", MX:FormatMoney(Farmer_Money_DayGlobal),L["MainForm_Label_Money_Lab_Today"]))
  labMonthGold:SetText(format("%s (%s)", MX:FormatMoney(Farmer_Money_MonthGlobal),L["MainForm_Label_Money_Lab_Month"]))
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
