---------------------------------------------------------
-- M+ Score
---------------------------------------------------------
local ShortenScore = function(score)
    score = math.floor((score + 50) / 100)
    return score / 10.0 .. "k"
end

local GetScoreColor = function(score)
    local colors = {
        [1] = { ["score"] = 3000, ["color"] = { 1.00, 0.50, 0.00 } },
        [2] = { ["score"] = 2800, ["color"] = { 0.64, 0.21, 0.93 } },
        [3] = { ["score"] = 2000, ["color"] = { 0.00, 0.44, 0.87 } },
        [4] = { ["score"] = 1760, ["color"] = { 0.12, 1.00, 0.00 } },
        [5] = { ["score"] = 1600, ["color"] = { 1.00, 1.00, 1.00 } },
    }

    for i = 1, #colors do
        local tier = colors[i]
        if score >= tier.score then
            return tier.color[1], tier.color[2], tier.color[3]
        end
    end

    return 0.62, 0.62, 0.62
end

local GetColorString = function(score)
    local r, g, b = GetScoreColor(score)

    local rString = string.format("%x", 255 * r)
    local gString = string.format("%x", 255 * g)
    local bString = string.format("%x", 255 * b)

    if r * 255 <= 15 then rString = rString .. "0" end
    if g * 255 <= 15 then gString = gString .. "0" end
    if b * 255 <= 15 then bString = bString .. "0" end

    local color = string.format("|cff%s%s%s", rString, gString, bString)
    return color
end

local getScore = function(mScore)
    local mplusCurrent = 0
    if mScore and mScore > 0 then
        mplusCurrent = mScore
    end
    return mplusCurrent
end

local chIdToName = function(id)
    local name = C_ChallengeMode.GetMapUIInfo(id)
    return name
end

-- Tooltip Hook
local function OnTooltipSetUnit(self)
    if not BDE_RAID_TOOLS_DB.MPLUS_SCORE_ENABLED then return end

    local unitName, unit = self:GetUnit()
    if issecretvalue and issecretvalue(unit) then return end
    if UnitAffectingCombat("player") then return end
    if not type(unit) == "string" then return end

    if UnitIsPlayer(unit) then
        local data = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(unit)
        local seasonScore = data and data.currentSeasonScore
        local mplusCurrent = getScore(seasonScore)

        self:AddDoubleLine("----- M+ Score ------", mplusCurrent, 1, 1, 1, GetScoreColor(mplusCurrent))

        local runs = data and data.runs
        if runs then
            for index, run in pairs(runs) do
                local name = " " .. chIdToName(run.challengeModeID)
                if run.finishedSuccess then
                    self:AddDoubleLine(name, run.bestRunLevel, 0, 1, 0.75, 0, 1, 0)
                else
                    self:AddDoubleLine(name, run.bestRunLevel, 0, 1, 0.75, 1, 0, 0)
                end
            end
        end

        self:AddLine("------------------------", 1, 1, 1)
    end
end

-- LFG Applicant Member
local function UpdateApplicantMember(member, appID, memberIdx, status, pendingStatus)
    if not BDE_RAID_TOOLS_DB.MPLUS_SCORE_ENABLED then return end

    local _, _, _, _, _, _, _, _, _, _, _, dungeonScore = C_LFGList.GetApplicantMemberInfo(appID, memberIdx)
    local mplusCurrent = getScore(dungeonScore)

    if member.Rating then
        member.Rating:SetText(GetColorString(mplusCurrent) .. mplusCurrent)
        member.Rating:Show()
        member:SetWidth(256)
    end
end

-- LFG Search Entry
local function SearchEntry_Update(group)
    if not BDE_RAID_TOOLS_DB.MPLUS_SCORE_ENABLED then return end

    local searchResultInfo = C_LFGList.GetSearchResultInfo(group.resultID)
    if not searchResultInfo or not searchResultInfo.activityIDs or not searchResultInfo.activityIDs[1] then
        return
    end

    local activityTable = C_LFGList.GetActivityInfoTable(searchResultInfo.activityIDs[1], nil, searchResultInfo.isWarMode)
    if activityTable and activityTable.isMythicPlusActivity and searchResultInfo.leaderOverallDungeonScore then
        local mplusCurrent = getScore(searchResultInfo.leaderOverallDungeonScore)
        local oldText = group.Name:GetText() or ""
        local newGrpText = string.format("%s%s|r %s", GetColorString(mplusCurrent), mplusCurrent, oldText)
        group.Name:SetText(newGrpText)
    end
end

-- Register Hooks
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, OnTooltipSetUnit)
hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", UpdateApplicantMember)
hooksecurefunc("LFGListSearchEntry_Update", SearchEntry_Update)
