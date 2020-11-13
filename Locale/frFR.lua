-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/mikx/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("MxW", "frFR");
if not L then return; end

-- Message
L["Message_Loaded"] = " a été chargé."
L["ChatCMD_Help"] = "[MxW] Argument(s) dispo. : restore/reset/alert/gmsg/config";
L["Settings_Alert_Enabled"] = "[MxW] Alerte activée. Seuil : ";
L["Settings_Alert_Disabled"] = "[MxW] Alerte désactivée.";
L["Settings_GuildMessage_Enabled"] = "[MxW] Message de guilde activé.";
L["Settings_GuildMessage_Disabled"] = "[MxW] Message de guilde désactivé.";
L["Chat_GuildDailyMoneyThresholdMessage"] = "a dépassé le palier journalier de";
L["Chat_ChatGuildDailyRecordA"] = "a battu son record journalier de";
L["Chat_ChatGuildDailyRecordEnterWorld"] = "Record journalier : "
L["Chat_ChatGuildDailyRecordUI"] = "(Record)";

-- Option
L["MainForm_Option_MinimumUI"] = "Valeur Minimale (Affichage dans l'UI.)";
L["MainForm_Option_MinimumUI_Desc"] = "Valeur minimale pour qu'un objet soit affiché dans MxW.";
L["MainForm_Option_MinimumUI_Usage"] = "<valeur en cuivre>";

-- MainForm
L["MainForm_Label_Close"] = "FERMER";
L["MainForm_Label_Money_Lab_Today"] = "Jour";
L["MainForm_Label_Money_Lab_Month"] = "Mois";
L["MainForm_Label_Money_Global"] = "Or (Global) :"
L["MainForm_Label_Money_Player"] = "Or (Joueur) :"
L["MainForm_Label_Money_Last"] = "Dernier Loot :";
L["MainForm_Label_Money_Min"] = "Min.";
L["MainForm_Label_LastBoE"] = "Dernier BOE :"
L["MainForm_Label_LastBoE_NONE"] = "n/d"
L["MainForm_Label_Loot"] = "- BUTIN -";
L["MainForm_Button_Settings"] = "Options";
L["MainForm_Group_Features"] = "Fonctions";
L["MainForm_Group_Gold"] = "Or";
L["MainForm_Label_DayCounter"] = "Jour(s)";

L["SettingsUI_EditBox_MinAlert"] = "Seuil d'alerte (Or)";
L["SettingsUI_Button_Reset"] = "Remise à zéro";
L["SettingsUI_DropDown_Value"] = "Source des valeurs";

-- Alert Classes
L["Alert_Class_Misc"] = "Divers";
L["Alert_Class_Consumable"] = "Consommable";
L["Alert_Class_TradeGoods"] = "Artisanat";
L["Alert_Class_Weapon"] = "Arme";
L["Alert_Class_Armor"] = "Armure";
