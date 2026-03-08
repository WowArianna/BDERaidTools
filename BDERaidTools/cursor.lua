local ADDON_NAME = ...

---------------------------------------------------------
-- Circle around cursor
---------------------------------------------------------
local cursorCircleFrame = CreateFrame("Frame", "CursorCircleFrame", UIParent)
cursorCircleFrame:SetFrameStrata("TOOLTIP")
cursorCircleFrame:SetSize(64, 64)
cursorCircleFrame:Hide()

local cursorCircleFrameTex = cursorCircleFrame:CreateTexture(nil, "OVERLAY")
cursorCircleFrameTex:SetAllPoints()
cursorCircleFrameTex:SetTexture("Interface\\AddOns\\BDERaidTools\\media\\Ring_20px.tga")
cursorCircleFrameTex:SetBlendMode("ADD")
cursorCircleFrameTex:SetVertexColor(0, 1, 0, 1)

cursorCircleFrame:SetScript("OnUpdate", function(self)
    if not BDE_RAID_TOOLS_DB.CURSOR_CIRCLE then return end
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x / scale, y / scale)
end)

BDE_RAID_TOOLS.updateCursorCircleFrame = function()
    if BDE_RAID_TOOLS_DB.CURSOR_CIRCLE then
        cursorCircleFrame:Show()
    else
        cursorCircleFrame:Hide()
    end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon ~= ADDON_NAME then return end
    BDE_RAID_TOOLS.updateCursorCircleFrame()
    self:UnregisterEvent("ADDON_LOADED")
end)
