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
--

-- main frame
local f = CreateFrame("Frame","FarmerMainFrame", UIParent)

local mxwVersion = GetAddOnMetadata("MxW", "Version")
local mainFrameWidth = 350;

	-- make it draggable with the mouse
f:SetMovable(true)
f:EnableMouse(true)
f:SetScript("OnMouseDown", function(self, button)
  if button == "LeftButton" and not self.isMoving then
   self:StartMoving();
   self.isMoving = true;
  end
end)
f:SetScript("OnMouseUp", function(self, button)
  if button == "LeftButton" and self.isMoving then
   self:StopMovingOrSizing();
   self.isMoving = false;
  end
end)
f:SetScript("OnHide", function(self)
  if ( self.isMoving ) then
   self:StopMovingOrSizing();
   self.isMoving = false;
  end
end)

f:SetFrameStrata("BACKGROUND") --Set its strata
f:SetHeight(100) --Give it height
f:SetWidth(mainFrameWidth) --and width

f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", --Set the background and border textures
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 10,
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
f:SetBackdropColor(0, 0, 0) --Set the background colour to black
f:SetPoint("CENTER") --Put it in the centre of the parent frame (UIParent)

f.txtLogo = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtLogo:SetFont("Fonts\\FRIZQT__.TTF", 14) --Set the font and size
f.txtLogo:SetTextColor(1, 1, 1) --Set the text colour
f.txtLogo:SetPoint("TOP", 0, -5) --Put it in the centre of the frame
f.txtLogo:SetText("MxW") --Change the displayed text

f.txtVersion = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtVersion:SetFont("Fonts\\FRIZQT__.TTF", 9) --Set the font and size
f.txtVersion:SetTextColor(1, 1, 1) --Set the text colour
f.txtVersion:SetPoint("TOP", -(mainFrameWidth/2) + (#mxwVersion*3.0), -5) --Put it in the centre of the frame
f.txtVersion:SetText(mxwVersion) --Change the displayed text

  local button = CreateFrame("Button", nil, f)
	button:SetPoint("TOP", f, "TOP", (mainFrameWidth/2) - #L["MainForm_Label_Close"]*6.0, -5)
	button:SetWidth(#L["MainForm_Label_Close"]*10.5)
	button:SetHeight(17)

	button:SetText(L["MainForm_Label_Close"])
	button:SetNormalFontObject("GameFontNormal")

	local ntex = button:CreateTexture()
	ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()
	button:SetNormalTexture(ntex)

	local htex = button:CreateTexture()
	htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	htex:SetTexCoord(0, 0.625, 0, 0.6875)
	htex:SetAllPoints()
	button:SetHighlightTexture(htex)

	local ptex = button:CreateTexture()
	ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	ptex:SetAllPoints()
	button:SetPushedTexture(ptex)

  button:SetScript("OnClick", function(self, arg1)
    f:Hide();
  end)

f.txtLabTM = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtLabTM:SetFont("Fonts\\FRIZQT__.TTF", 10) --Set the font and size
f.txtLabTM:SetTextColor(1, 1, 1) --Set the text colour
f.txtLabTM:SetPoint("TOP", 0, -20) --Put it in the centre of the frame
f.txtLabTM:SetText(format("%s / %s",L["MainForm_Label_Money_Lab_Today"],L["MainForm_Label_Money_Lab_Month"])) --Change the displayed text

f.txtPlayer = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtPlayer:SetFont("Fonts\\FRIZQT__.TTF", 10) --Set the font and size
f.txtPlayer:SetTextColor(1, 1, 1) --Set the text colour
f.txtPlayer:SetPoint("TOPLEFT", 10, -32) --Put it in the centre of the frame
f.txtPlayer:SetText(L["MainForm_Label_Money_Player"]) --Change the displayed text

f.txtGlobal = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtGlobal:SetFont("Fonts\\FRIZQT__.TTF", 10) --Set the font and size
f.txtGlobal:SetTextColor(1, 1, 1) --Set the text colour
f.txtGlobal:SetPoint("TOPLEFT", 10, -42) --Put it in the centre of the frame
f.txtGlobal:SetText(L["MainForm_Label_Money_Global"]) --Change the displayed text

f.txtLootLabel = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtLootLabel:SetFont("Fonts\\FRIZQT__.TTF", 10) --Set the font and size
f.txtLootLabel:SetTextColor(1, 1, 1) --Set the text colour
f.txtLootLabel:SetPoint("TOP", 0, -56) --Put it in the centre of the frame
f.txtLootLabel:SetText(L["MainForm_Label_Loot"]) --Put it in the centre of the frame

f.txtLootLinkQty = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtLootLinkQty:SetFont("Fonts\\FRIZQT__.TTF", 10) --Set the font and size
f.txtLootLinkQty:SetTextColor(1, 1, 1) --Set the text colour
f.txtLootLinkQty:SetPoint("TOP", 0, -66)

f.txtLast = f:CreateFontString(nil, "ARTWORK") --Create a FontString to display text
f.txtLast:SetFont("Fonts\\FRIZQT__.TTF", 10) --Set the font and size
f.txtLast:SetTextColor(1, 1, 1) --Set the text colour
f.txtLast:SetPoint("TOPLEFT", 10, -62) --Put it in the centre of the frame

local MAIN_UI = AceGUI:Create("Window")
MAIN_UI:Hide()
MAIN_UI:SetHeight(200)
MAIN_UI:SetTitle("MxW")
MAIN_UI:SetLayout("Flow")
MAIN_UI:SetWidth(300)
MAIN_UI:EnableResize(true)

GUI_SCROLLCONTAINER = AceGUI:Create("SimpleGroup")
GUI_SCROLLCONTAINER:SetFullWidth(true)
GUI_SCROLLCONTAINER:SetHeight(150)
GUI_SCROLLCONTAINER:SetLayout("Fill")
GUI_SCROLLCONTAINER.frame:SetBackdrop(backdrop)
GUI_SCROLLCONTAINER.frame:SetBackdropColor(0, 0, 0)
GUI_SCROLLCONTAINER.frame:SetBackdropBorderColor(0.4, 0.4, 0.4)

GUI_LOOTCOLLECTED = AceGUI:Create("ScrollFrame")
GUI_LOOTCOLLECTED:SetLayout("Flow")
GUI_SCROLLCONTAINER:AddChild(GUI_LOOTCOLLECTED)
MAIN_UI:AddChild(GUI_SCROLLCONTAINER)

local MainFrame_Event_ADDON_LOADED = CreateFrame("Frame")
MainFrame_Event_ADDON_LOADED:RegisterEvent("ADDON_LOADED")
MainFrame_Event_ADDON_LOADED:SetScript("OnEvent", function(self, event, ...)
  MX:UpdateText()
end)

local MainFrame_Event_PLAYER_MONEY = CreateFrame("Frame")
MainFrame_Event_PLAYER_MONEY:RegisterEvent("PLAYER_MONEY")
MainFrame_Event_PLAYER_MONEY:SetScript("OnEvent", function(self, event, ...)
  MX:UpdateText()
end)

local MainFrame_Event_ENCOUNTER_LOOT_RECEIVED = CreateFrame("Frame")
MainFrame_Event_ENCOUNTER_LOOT_RECEIVED:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")
MainFrame_Event_ENCOUNTER_LOOT_RECEIVED:SetScript("OnEvent", function(self, event, ...)
  local arg1, iid, ilink, iqty, arg5, arg6, arg7, arg8, arg9 = ...
  --name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(iid);
  value = MX.TSM:GetItemValue(iid, "DBMarket");
  if (value ~= nil and value >= Farmer_Logic_MinAlert and quality >= 0) then
    --f.txtLast:SetText(format("%s %s (%s) (%s %s)",L["MainForm_Label_Money_Last"],link,MX:FormatMoney(value),L["MainForm_Label_Money_Min"],MX:FormatMoney(Farmer_Logic_MinAlert)));
    local fv = MX:FormatMoneyShort(value);
    local tfv = MX:FormatMoneyShort(value*iqty);
    if (iqty > 1) then
      f.txtLootLinkQty:SetText(format("%sx %s (%s) (T. %s)", iqty, ilink, fv, tfv));
      MX:addItem2LootCollectedList(format("%sx %s (%s) (T. %s)", iqty, ilink, fv, tfv),texture)
    elseif (iqty == 1) then
      f.txtLootLinkQty:SetText(format("%sx %s (%s)", iqty, ilink, fv));
      MX:addItem2LootCollectedList(format("%sx %s (%s)", iqty, ilink, fv),texture)
    end
  end
end)

function MX:UpdateText()
  f.txtPlayer:SetText(format("%s %s / %s",L["MainForm_Label_Money_Player"], MX:FormatMoney(Farmer_Money_DayPlayer), MX:FormatMoney(Farmer_Money_MonthPlayer))) --Change the displayed text
  f.txtGlobal:SetText(format("%s %s / %s",L["MainForm_Label_Money_Global"], MX:FormatMoney(Farmer_Money_DayGlobal), MX:FormatMoney(Farmer_Money_MonthGlobal))) --Change the displayed text
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
