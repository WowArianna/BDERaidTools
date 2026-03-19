local ADDON_NAME, ns = ...

local defaults = {
    MPLUS_SCORE_ENABLED = false,
    JESUS_ENABLED = true,
    CURSOR_CIRCLE = false,
    SHUTUP_BRANN = true,
}

-- SavedVariable default
BDE_RAID_TOOLS_DB = BDE_RAID_TOOLS_DB or defaults

BDE_RAID_TOOLS = BDE_RAID_TOOLS or {}

-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("ADDON_LOADED")
-- frame:SetScript("OnEvent", function(self, event, addon)
--     if addon ~= ADDON_NAME then return end
--     -- Jetzt sind die SavedVariables sicher geladen
--     CombatTimerFrame:ClearAllPoints()
--     CombatTimerFrame:SetPoint("CENTER", EXPOS_CombatTimer_Pos.x, EXPOS_CombatTimer_Pos.y)
--
--     self:UnregisterEvent("ADDON_LOADED")
-- end)

local function MergeDefaults(db, defaults)
    for k, v in pairs(defaults) do
        if db[k] == nil then
            db[k] = v
        end
    end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon ~= ADDON_NAME then return end

    -- resync the addon db (updates the defaults)
    MergeDefaults(BDE_RAID_TOOLS_DB, defaults)
end)

---------------------------------------------------------
-- Debug Function
---------------------------------------------------------
BDE_RAID_TOOLS.dumpTable = function(tbl, ind)
    if type(tbl) ~= "table" then
        print(tbl)
        return
    end
    ind = ind or 0
    local indent = string.rep("  ", ind)
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(indent, k, "= {")
            BDE_RAID_TOOLS.dumpTable(v, ind + 1)
            print(indent, "}")
        else
            print(indent, k, "=", v)
        end
    end
end
