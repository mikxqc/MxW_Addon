-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/wow/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("MxW", "enUS");
if not L then return; end

-- Message
L["Message_Loaded"] = " has been loaded."
L["ChatCMD_Help"] = "[MxW] Available Argument(s) : restore/reset/alert/gmsg/config";
L["Settings_Alert_Enabled"] = "[MxW] Alert Disabled. Threshold: ";
L["Settings_Alert_Disabled"] = "[MxW] Alert Enabled.";
L["Settings_GuildMessage_Enabled"] = "[MxW] Guild Message Enabled.";
L["Settings_GuildMessage_Disabled"] = "[MxW] Guild Message Disabled.";
L["Chat_GuildDailyMoneyThresholdMessage"] = "has exceeded the daily stage of";
L["Chat_ChatGuildDailyRecordA"] = "has beaten his daily record of";
L["Chat_ChatGuildDailyRecordEnterWorld"] = "Daily Record: "
L["Chat_ChatGuildDailyRecordUI"] = "(Record)";

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
L["MainForm_Button_Settings"] = "Settings";
L["MainForm_Group_Features"] = "Fonctions";
L["MainForm_Group_Gold"] = "Or";
L["MainForm_Label_DayCounter"] = "Day(s)";

L["SettingsUI_EditBox_MinAlert"] = "Alert Thresold (Gold)";
L["SettingsUI_Button_Reset"] = "Reset";
L["SettingsUI_DropDown_Value"] = "Value Source";

-- Alert Classes
L["Alert_Class_Misc"] = "Miscellaneous";
L["Alert_Class_Consumable"] = "Consumable";
L["Alert_Class_TradeGoods"] = "Trade Goods";
L["Alert_Class_Weapon"] = "Weapon";
L["Alert_Class_Armor"] = "Armor";
