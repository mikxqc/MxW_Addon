-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/wow/MxW_Addon
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

      local date = C_Calendar.GetDate()
    	local weekday = date.weekday
    	local month = date.month
    	local day = date.monthDay
    	local year = date.year

      -- Write to SavedVariables
      Farmer_Money_MonthGlobal = Farmer_Money_MonthGlobal + DiffGold;
      Farmer_Money_DayGlobal = Farmer_Money_DayGlobal + DiffGold;

      if(Farmer_Money_DayGlobal >= DailyRecord and DailyRecordFlag == false) then
        MX:ChatGuildDailyRecord(DailyRecord)
        DailyRecord = Farmer_Money_DayGlobal;
        DailyRecordFlag = true;
      end

      if(DailyRecordFlag) then
        DailyRecord = Farmer_Money_DayGlobal;
      end

      MX:UpdateMainUI()
      MX:ChatGuildDailyMoneyThresholdMessage(Farmer_Money_DayGlobal)

  elseif (DiffGold <= 0) then -- Gold lost

  end

  CurrentGold = GetMoney()
  DiffGold = 0

end)
