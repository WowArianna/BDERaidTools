local ADDON_NAME = ...

---------------------------------------------------------
-- Shut up Brann!
---------------------------------------------------------
local soundIDs = {
    5769020,5768808,5768801,5768809,5768841,5768797,5768799,5768838,5768837,5768796,5769018,5768836,5768802,5769017,5769019,5769016,5768826,
    5769071,5768819,5768820,5768839,5768967,5768828,5769036,5768827,5768810,5768814,5768975,5768823,5768979,5768963,5768811,5768977,5768800,
    5768965,5768849,5769037,5769059,5768972,5768824,5768840,5768833,5768962,5768978,5768805,5769031,5769060,5768973,5768974,5768974,5768806,
    5769069,5768816,5768822,5769038,5768821,5768971,5768803,5769039,5768807,5768815,5768818,5768825,5769058,5768976,5768817,5769075,5768829,
    5768804,5768964,5768966
}

BDE_RAID_TOOLS.updateBrannSounds = function(shutup)
    for _, soundID in ipairs(soundIDs) do
        if BDE_RAID_TOOLS_DB.SHUTUP_BRANN then
            MuteSoundFile(soundID)
        else
            UnmuteSoundFile(soundID)
        end
    end
end

-- Hauptinitialisierung
local function OnEvent(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        BDE_RAID_TOOLS.updateBrannSounds()
    end
end

-- Frame erstellen und Event-Handling setzen
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", OnEvent)
