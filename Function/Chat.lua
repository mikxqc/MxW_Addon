-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/wow/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

-----------------
-- Guild channel
-----------------

---- Loot Alert Guild Message
function MX:ChatGuildLootMessage(link,value)
  if (Settings_GuildMessage_Enabled) then
    local msg = format("[MxW] %s [%s]",link,MX:FormatMoneyNoColor(value));
    SendChatMessage(msg, "GUILD", nil);
  end
end

---- Daily Record Guild Message
function MX:ChatGuildDailyRecord(oldvalue)
  if (Settings_GuildMessage_Enabled) then
    local pname = UnitName("player")
    local ogv = floor(oldvalue / (COPPER_PER_SILVER * SILVER_PER_GOLD))
    local msg = format("[MxW] %s %s %ig!",pname,L["Chat_ChatGuildDailyRecordA"],ogv);
    SendChatMessage(msg, "GUILD", nil);
  end
end

---- Daily Money Threshold Guild Message
function MX:ChatGuildDailyMoneyThresholdMessage(value)
  if (Settings_GuildMessage_Enabled) then

    local gv = floor(value / (COPPER_PER_SILVER * SILVER_PER_GOLD))
    local post = false
    local msg
    local pname = UnitName("player")
    if(gv >= 10000 and DailyTen == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],10000);
      DailyTen = true;
      post = true;
    elseif(gv >= 20000 and DailyTwenty == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],20000);
      DailyTwenty = true;
      post = true;
    elseif(gv >= 30000 and DailyThirty == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],30000);
      DailyThirty = true;
      post = true;
    elseif(gv >= 40000 and DailyForty == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],40000);
      DailyForty = true;
      post = true;
    elseif(gv >= 50000 and DailyFifty == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],50000);
      DailyFifty = true;
      post = true;
    elseif(gv >= 60000 and DailySixty == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],60000);
      DailySixty = true;
      post = true;
    elseif(gv >= 70000 and DailySeventy == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],70000);
      DailySeventy = true;
      post = true;
    elseif(gv >= 80000 and DailyEighty == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],80000);
      DailyEighty = true;
      post = true;
    elseif(gv >= 90000 and DailyNinety == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],90000);
      DailyNinety = true;
      post = true;
    elseif(gv >= 100000 and DailyHundred == false) then
      msg = format("[MxW] %s %s %ig!",pname,L["Chat_GuildDailyMoneyThresholdMessage"],100000);
      DailyHundred = true;
      post = true;
    end

    if(post) then
      SendChatMessage(msg, "GUILD", nil);
      post = false;
    end

  end
end
