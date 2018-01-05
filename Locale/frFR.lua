-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("MxW", "frFR");
if not L then return; end

-- Message
L["Message_Loaded"] = " a été chargé."

-- Option
L["MainForm_Option_MinimumUI"] = "Valeur Minimale (Affichage dans l'UI.)";
L["MainForm_Option_MinimumUI_Desc"] = "Valeur minimale pour qu'un objet soit affiché dans MxW.";
L["MainForm_Option_MinimumUI_Usage"] = "<valeur en cuivre>";

-- MainForm
L["MainForm_Label_Close"] = "FERMER";
L["MainForm_Label_Money_Lab_Today"] = "Auj.";
L["MainForm_Label_Money_Lab_Month"] = "Mois";
L["MainForm_Label_Money_Global"] = "Or (Global) :"
L["MainForm_Label_Money_Player"] = "Or (Joueur):"
L["MainForm_Label_Money_Last"] = "Dernier Loot :";
L["MainForm_Label_Money_Min"] = "Min.";
L["MainForm_Label_LastBoE"] = "Dernier BOE :"
L["MainForm_Label_LastBoE_NONE"] = "n/d"
L["MainForm_Label_Loot"] = "- BUTIN -";

-- Alert Classes
L["Alert_Class_Consumable"] = "Consommable";
L["Alert_Class_TradeGoods"] = "Matériaux d'artisanat";
L["Alert_Class_Weapon"] = "Arme";
L["Alert_Class_Armor"] = "Armure";
