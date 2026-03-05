local ADDON_NAME, ns = ...

-- SavedVariable default
BDE_MPLUS_SCORE_ENABLED = BDE_MPLUS_SCORE_ENABLED ~= true
BDE_JESUS_ENABLED = BDE_JESUS_ENABLED ~= true
-- EXPOS_CombatTimer_Enabled = EXPOS_CombatTimer_Enabled ~= false
-- EXPOS_CombatTimer_Pos = EXPOS_CombatTimer_Pos or { x = 0, y = -100 }

BDE_RAID_TOOLS_DB = BDE_RAID_TOOLS_DB or {
    MPLUS_SCORE_ENABLED = true,
    JESUS_ENABLED = true
}

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
