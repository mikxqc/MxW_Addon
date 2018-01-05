-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

local PLAYER_MONEY_Frame = CreateFrame("Frame")
PLAYER_MONEY_Frame:RegisterEvent("PLAYER_MONEY")
PLAYER_MONEY_Frame:SetScript("OnEvent", function(self, event, ...)
    local tmpMoney = GetMoney()
    if self.CurrentMoney then
        self.DiffMoney = tmpMoney - self.CurrentMoney
    else
        self.DiffMoney = 0
    end
    self.CurrentMoney = tmpMoney
    if self.DiffMoney > 0 then
        -- Money Gain
          -- Reset daily counter if this is a new day
        local weekday, month, day, year = CalendarGetDate();
        -- Reset Global Daily Counter
        if (Farmer_Logic_Day ~= day) then
          Farmer_Money_DayGlobal = 0;
          MX:UpdateText()
          Farmer_Logic_Day = day;
        end
        -- Reset Player Daily Counter
        if (Farmer_Logic_PlayerDay ~= day) then
          Farmer_Money_DayPlayer = 0;
          MX:UpdateText()
          Farmer_Logic_PlayerDay = day;
        end
          -- Write to SavedVariables
        Farmer_Money_DayPlayer = Farmer_Money_DayPlayer + self.DiffMoney;
        Farmer_Money_MonthPlayer = Farmer_Money_MonthPlayer + self.DiffMoney;
        Farmer_Money_MonthGlobal = Farmer_Money_MonthGlobal + self.DiffMoney;
        Farmer_Money_DayGlobal = Farmer_Money_DayGlobal + self.DiffMoney;
    elseif self.DiffMoney < 0 then
        -- Money Lost
    end
end)
