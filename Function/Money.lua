-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.xyz/wow/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

local COLOR_COPPER = "|cffeda55f"
local COLOR_SILVER = "|cffc7c7cf"
local COLOR_GOLD = "|cffffd700"
local COLOR_WHITE = "|cffffffff"

function MX:FormatMoney(money)
    local ret = ""
    local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
    local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
    local copper = mod(money, COPPER_PER_SILVER);

    if (gold == 0) then
      return format("%s%02ds|r %s%02dc|r", COLOR_SILVER, silver, COLOR_COPPER, copper)
    end
    if (gold > 0) then
      return format("%s%02dg|r %s%02ds|r %s%02dc|r", COLOR_GOLD, gold, COLOR_SILVER, silver, COLOR_COPPER, copper)
    end
end

function MX:FormatMoneyGoldOnly(money)
    local ret = ""
    local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
    local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
    local copper = mod(money, COPPER_PER_SILVER);

    if (gold == 0) then
      return "0g"
    end
    if (gold > 0) then
      return format("%s%02dg|r", COLOR_GOLD, gold)
    end
end

function MX:FormatMoneyShort(money)
    local ret = ""
    local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
    local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
    local copper = mod(money, COPPER_PER_SILVER);

    if (gold == 0) then
      return format("%s%02ds|r %s%02dc|r", COLOR_SILVER, silver, COLOR_COPPER, copper)
    end
    if (gold > 0) then
      return format("%s%sg%s", COLOR_GOLD, gold, COLOR_WHITE)
    end
end

function MX:FormatMoneyNoColor(money)
  local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
  local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
  local copper = mod(money, COPPER_PER_SILVER);
  if (gold == 0) then
    return format("%ss %sc", silver, copper)
  end
  if (gold > 0) then
    return format("%sg %ss %sc", gold, silver, copper)
  end
end
