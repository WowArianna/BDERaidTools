---------------------------------------------------------
-- Jesus (Death Texture)
---------------------------------------------------------
local displayFrame = CreateFrame("Frame", nil, UIParent)
displayFrame:SetSize(512, 512)
displayFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -20)
displayFrame:Hide()

-- Jesus-Textur
local tex = displayFrame:CreateTexture(nil, "BACKGROUND")
tex:SetAllPoints(displayFrame)
tex:SetTexture("Interface\\AddOns\\BDERaidTools\\media\\jesus.tga")

-- Text "Ned Freilassen"
local text = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
text:SetPoint("BOTTOM", displayFrame, "TOP", 0, 0)
text:SetText("Ned Freilassen")
text:SetTextColor(1, 0, 0)
text:SetScale(3)

-- Animation Group
local ag = text:CreateAnimationGroup()

-- Nach oben
local up = ag:CreateAnimation("Translation")
up:SetOffset(0, 20)
up:SetDuration(0.5)
up:SetOrder(1)
up:SetSmoothing("OUT")

-- Nach unten
local down = ag:CreateAnimation("Translation")
down:SetOffset(0, -20)
down:SetDuration(0.5)
down:SetOrder(2)
down:SetSmoothing("IN")

ag:SetLooping("REPEAT")

-- Rotationsgeschwindigkeit (Radiant pro Sekunde)
local ROT_SPEED = 0.8
local currentRotation = 0

-- OnUpdate für Rotation
displayFrame:SetScript("OnUpdate", function(self, elapsed)
    currentRotation = currentRotation + (elapsed * ROT_SPEED)
    tex:SetRotation(currentRotation)
end)

-- Funktionen
local jesusShown = false

local showJesus = function()
    currentRotation = 0
    if not BDE_RAID_TOOLS_DB.JESUS_ENABLED then return end
    displayFrame:Show()
    ag:Play()
    jesusShown = true
    print("|cff00ff00[BDE]|r Hello Jesus")
end

local hideJesus = function()
    displayFrame:Hide()
    ag:Stop()
    jesusShown = false
    print("|cff00ff00[BDE]|r Baba Jesus.")
end

-- Event-Frame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_DEAD")
f:RegisterEvent("PLAYER_ALIVE")
f:RegisterEvent("PLAYER_UNGHOST")

f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_DEAD" then
        showJesus()
    elseif event == "PLAYER_ALIVE" or event == "PLAYER_UNGHOST" then
        hideJesus()
    end
end)

---------------------------------------------------------
-- Slash Commands
---------------------------------------------------------
SLASH_BDECMD1 = "/bdejesus"
SlashCmdList["BDECMD"] = function(msg)
    msg = msg:lower()

    if msg == "show" then
        showJesus()
    elseif msg == "hide" then
        hideJesus()
    elseif true == jesusShown then
        hideJesus()
    elseif false == jesusShown then
        showJesus()
    end
end

