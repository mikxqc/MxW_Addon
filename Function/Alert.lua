-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

-- Alert Cooking
-- Based on [[ AchievementAlertFrame ]] from Blizzard
function CookAlert(frame, item, fvalue)
  local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(item)
  if itemName == nil then return end
  if itemTexture == nil then itemTexture = [[Interface\Icons\INV_Misc_PheonixPet_01]] end

  local displayName = frame.Name;
  local shieldPoints = frame.Shield.Points;
  local shieldIcon = frame.Shield.Icon;
  local unlocked = frame.Unlocked;
  local oldCheevo = frame.OldAchievement;

  displayName:SetText(itemName);

  AchievementShield_SetPoints(0, shieldPoints, GameFontNormal, GameFontNormalSmall);

  frame.oldCheevo = nil
  shieldPoints:Hide();
  shieldIcon:Hide();
  oldCheevo:Hide();
  frame.guildDisplay = nil;
  frame:SetHeight(88);
  local background = frame.Background;
  background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Background");
  background:SetTexCoord(0, 0.605, 0, 0.703);
  background:SetPoint("TOPLEFT", 0, 0);
  background:SetPoint("BOTTOMRIGHT", 0, 0);
  local iconBorder = frame.Icon.Overlay;
  iconBorder:SetTexture("Interface\\AchievementFrame\\UI-Achievement-IconFrame");
  iconBorder:SetTexCoord(0, 0.5625, 0, 0.5625);
  iconBorder:SetPoint("CENTER", -1, 2);
  frame.Icon:SetPoint("TOPLEFT", -26, 16);
  displayName:SetPoint("BOTTOMLEFT", 72, 36);
  displayName:SetPoint("BOTTOMRIGHT", -60, 36);
  unlocked:SetPoint("TOP", 7, -23);
  unlocked:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
  unlocked:SetText(fvalue);
  frame.GuildName:Hide();
  frame.GuildBorder:Hide();
  frame.GuildBanner:Hide();
  frame.glow:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Glow");
  frame.glow:SetTexCoord(0, 0.78125, 0, 0.66796875);
  frame.shine:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Glow");
  frame.shine:SetTexCoord(0.78125, 0.912109375, 0, 0.28125);
  frame.shine:SetPoint("BOTTOMLEFT", 0, 8);

  shieldIcon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields-NoPoints]]);

  frame.Icon.Texture:SetTexture(itemTexture);

  frame.id = item;
  return true;
end

local FarmerAlert = AlertFrame:AddQueuedAlertFrameSubSystem("AchievementAlertFrameTemplate", CookAlert, 2, 6);

function MX:SendAlert(itemId,value)
  local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId)

  if ( not AchievementFrame ) then
    AchievementFrame_LoadUI();
  end

  fvalue = MX:FormatMoney(value);

  FarmerAlert:AddAlert(itemId,fvalue);
  PlaySoundFile("Sound\\Spells\\AchievmentSound1.ogg")
end

local COLOR_GREY = "|cff888888"
local COLOR_GOLD = "|cffffcc00"

function MX:LootMsg(id, link, value, qty)
  local fv = MX:FormatMoney(value);
  local tfv = MX:FormatMoney(value*qty);
  print("")
end
