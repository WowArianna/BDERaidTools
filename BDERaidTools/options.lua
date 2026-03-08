---------------------------------------------------------
-- Options Panel
---------------------------------------------------------
local panel = CreateFrame("Frame")
panel.name = "BDERaidTools"

local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("BDE Raid Tools")

local mScoreToggle = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
mScoreToggle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 5, -10)
mScoreToggle.Text:SetText("M+ Tooltip")
mScoreToggle:SetScript("OnClick", function(self)
    BDE_RAID_TOOLS_DB.MPLUS_SCORE_ENABLED = self:GetChecked()
end)

local jesusToggle = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
jesusToggle:SetPoint("TOPLEFT", mScoreToggle, "BOTTOMLEFT", 0, -5)
jesusToggle.Text:SetText("Jesus")
jesusToggle:SetScript("OnClick", function(self)
    BDE_RAID_TOOLS_DB.JESUS_ENABLED = self:GetChecked()
end)

local cursorCircleToggle = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
cursorCircleToggle:SetPoint("TOPLEFT", jesusToggle, "BOTTOMLEFT", 0, -5)
cursorCircleToggle.Text:SetText("Cursor Circle")
cursorCircleToggle:SetScript("OnClick", function(self)
    BDE_RAID_TOOLS_DB.CURSOR_CIRCLE = self:GetChecked()
    BDE_RAID_TOOLS.updateCursorCircleFrame()
end)

-- local checkbox2 = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
-- checkbox2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 5, -40)
-- checkbox2.Text:SetText("CombatTimer")
-- checkbox2:SetChecked(EXPOS_CombatTimer_Enabled)
-- checkbox2:SetScript("OnClick", function(self)
--     EXPOS_CombatTimer_Enabled = self:GetChecked()
-- end)
--
-- -- X Slider
-- local xSlider = CreateFrame("Slider", "EXPOS_XSlider", panel, "OptionsSliderTemplate")
-- xSlider:SetPoint("TOPLEFT", checkbox2, "BOTTOMLEFT", 140, 0)
-- xSlider:SetWidth(200)
-- xSlider:SetMinMaxValues(-1000, 1000)
-- xSlider:SetValueStep(1)
-- xSlider:SetObeyStepOnDrag(true)
-- xSlider:SetScript("OnValueChanged", function(self, value)
--     value = math.floor(value)
--     EXPOS_CombatTimer_Pos.x = value
--     CombatTimerFrame:SetPoint("CENTER", EXPOS_CombatTimer_Pos.x, EXPOS_CombatTimer_Pos.y)
-- end)
--
-- EXPOS_XSliderLow:SetText("-1000")
-- EXPOS_XSliderHigh:SetText("1000")
-- EXPOS_XSliderText:SetText("X Position")
--
-- -- Y Slider
-- local ySlider = CreateFrame("Slider", "EXPOS_YSlider", panel, "OptionsSliderTemplate")
-- ySlider:SetPoint("TOPLEFT", xSlider, "BOTTOMLEFT", 0, -30)
-- ySlider:SetWidth(200)
-- ySlider:SetMinMaxValues(-500, 500)
-- ySlider:SetValueStep(1)
-- ySlider:SetObeyStepOnDrag(true)
-- ySlider:SetScript("OnValueChanged", function(self, value)
--     value = math.floor(value)
--     EXPOS_CombatTimer_Pos.y = value
--     CombatTimerFrame:SetPoint("CENTER", EXPOS_CombatTimer_Pos.x, EXPOS_CombatTimer_Pos.y)
-- end)
--
-- EXPOS_YSliderLow:SetText("-500")
-- EXPOS_YSliderHigh:SetText("500")
-- EXPOS_YSliderText:SetText("Y Position")

panel:SetScript("OnShow", function()
    mScoreToggle:SetChecked(BDE_RAID_TOOLS_DB.MPLUS_SCORE_ENABLED)
    jesusToggle:SetChecked(BDE_RAID_TOOLS_DB.JESUS_ENABLED)
    cursorCircleToggle:SetChecked(BDE_RAID_TOOLS_DB.CURSOR_CIRCLE)
--     xSlider:SetValue(EXPOS_CombatTimer_Pos.x or 0)
--     ySlider:SetValue(EXPOS_CombatTimer_Pos.y or 0)
end)


local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
Settings.RegisterAddOnCategory(category)
