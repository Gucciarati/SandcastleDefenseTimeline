--!strict

local DispatchEvent = require(script.Parent.DispatchEvent)
local CompareKeypoints = require(script.Parent.CompareKeypoints)
local SortKeypoints = require(script.Parent.SortKeypoints)

type PlaybackOptions = {
	StartTime: number?,
	IsCancelled: (() -> boolean)?,
	ProcessKeypoint: ((any, (any) -> ()) -> (boolean, any?))?,
	SetInsertKeypoint: (((any) -> ()) -> ())?,
}

return function(Timeline, Options: PlaybackOptions?)
	local PlaybackOptionsValue = Options or {}
	local StartTime = PlaybackOptionsValue.StartTime or workspace:GetServerTimeNow()
	local Keypoints = Timeline.Keypoints
	local CurrentIndex = 1
	local NextSequence = #Keypoints + 1

	SortKeypoints(Keypoints)

	local function InsertKeypoint(Keypoint)
		NextSequence += 1
		Keypoint.Sequence = Keypoint.Sequence or NextSequence

		local InsertAt = #Keypoints + 1
		for Index = CurrentIndex, #Keypoints do
			local Existing = Keypoints[Index]
			if CompareKeypoints(Keypoint, Existing) then
				InsertAt = Index
				break
			end
		end

		table.insert(Keypoints, InsertAt, Keypoint)
	end

	if PlaybackOptionsValue.SetInsertKeypoint then
		PlaybackOptionsValue.SetInsertKeypoint(InsertKeypoint)
	end

	while CurrentIndex <= #Keypoints do
		if PlaybackOptionsValue.IsCancelled and PlaybackOptionsValue.IsCancelled() then
			return false, "Cancelled"
		end

		local Keypoint = Keypoints[CurrentIndex]
		local TargetTime = StartTime + Keypoint.TimeElapsed

		while workspace:GetServerTimeNow() < TargetTime do
			if PlaybackOptionsValue.IsCancelled and PlaybackOptionsValue.IsCancelled() then
				return false, "Cancelled"
			end

			task.wait(math.min(0.05, TargetTime - workspace:GetServerTimeNow()))
			Keypoint = Keypoints[CurrentIndex]
			TargetTime = StartTime + Keypoint.TimeElapsed
		end

		local Confirmed = true
		local Result = nil
		if PlaybackOptionsValue.ProcessKeypoint then
			Confirmed, Result = PlaybackOptionsValue.ProcessKeypoint(Keypoint, InsertKeypoint)
		end

		if Confirmed then
			DispatchEvent(Keypoint.Type, Keypoint, Timeline, Result)
		end

		CurrentIndex += 1
	end

	return true
end
