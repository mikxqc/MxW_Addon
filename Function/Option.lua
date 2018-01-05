-- MxW (MxW Addon)
-- By mikx
-- https://git.mikx.ca/wow-addons/MxW_Addon
-- Licensed under the GNU General Public License 3.0
-- See included License file for more informations.

local MX = LibStub("AceAddon-3.0"):GetAddon("MxW");
local L = LibStub("AceLocale-3.0"):GetLocale("MxW");

function MX:OptionMinimumUIGet()
  return Farmer_Logic_MinUI;
end

function MX:OptionMinimumUISet(value)
  Farmer_Logic_MinUI = value;
end

function MX:OnInitialize()
  LibStub("AceConfig-3.0"):RegisterOptionsTable("MxW", options)
  self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MxW", "MxW")
  self:RegisterChatCommand("mxw", "ChatCommand")
end

function MX:ChatCommand(input)
    if not input or input:trim() == "" then
        MX:ShowHistory();
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("mxw", "MxW", input)
    end
end

options = {
	type = 'group',
	name = "Général",
	order = 1,
	args = {
				text = {
					type = 'group',
					name = "Affichage",
					inline = true,
					args = {
						mouseheader = {
							type = 'header',
							name = "Général",
							order = 0,
						},
						delaydivisor = {
						type = 'range',
						name = 'Text speed',
						desc = "Description",
						min = 5,
						max = 40,
						step = 5,
						order = 1,
						get = function(self, val)
							--
						end,
						set = function(self, val)
							--
						end,
						},
					},
				}
			}
}
