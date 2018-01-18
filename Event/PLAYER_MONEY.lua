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

    local DiffGold = 0
    local NewGold = GetMoney() -- Get the player gold after the event
    DiffGold = NewGold - CurrentGold -- Get the gold difference

    if (DiffGold > 0) then -- Gold gain

      local weekday, month, day, year = CalendarGetDate();
      -- Reset Global Daily Counter
      if (Farmer_Logic_Day ~= day) then
        Farmer_Money_DayGlobal = 0;
        MX:UpdateMainUI()
        Farmer_Logic_Day = day;
      end

      -- Write to SavedVariables
      Farmer_Money_MonthGlobal = Farmer_Money_MonthGlobal + DiffGold;
      Farmer_Money_DayGlobal = Farmer_Money_DayGlobal + DiffGold;

      MX:UpdateMainUI()

  elseif (DiffGold <= 0) then -- Gold lost

  end

  CurrentGold = GetMoney()
  DiffGold = 0

end)
