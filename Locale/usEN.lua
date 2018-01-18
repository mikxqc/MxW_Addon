-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("MxW", "enUS");
if not L then return; end

-- Message
L["Message_Loaded"] = " has been loaded."

-- Option
L["MainForm_Option_MinimumUI"] = "Minimum Value (Display in the UI.)";
L["MainForm_Option_MinimumUI_Desc"] = "Minimum value for an item to be displayed in MxW.";
L["MainForm_Option_MinimumUI_Usage"] = "<value in copper>";

--*_ADDON locales
L["MainForm_Label_Close"] = "CLOSE";
L["MainForm_Label_Money_Lab_Today"] = "Today";
L["MainForm_Label_Money_Lab_Month"] = "Month";
L["MainForm_Label_Money_Global"] = "Gold (Global):"
L["MainForm_Label_Money_Player"] = "Gold (Player):"
L["MainForm_Label_Money_Last"] = "Last Loot:";
L["MainForm_Label_Money_Min"] = "Min.";
L["MainForm_Label_LastBoE"] = "Last BOE:"
L["MainForm_Label_LastBoE_NONE"] = "n/a"
L["MainForm_Label_Loot"] = "- LOOT -";
L["MainForm_Button_LootList"] = "Loot List";
L["MainForm_Group_Features"] = "Fonctions";
L["MainForm_Group_Gold"] = "Or";

L["Alert_TradeGoods"] = "Trade Goods";
