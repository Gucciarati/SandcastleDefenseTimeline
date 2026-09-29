--!strict

local PRIORITIES = {
	PhaseStarted = 1,
	SequenceStarted = 2,
	Spawn = 3,
	RangeEnter = 4,
	PredictedDeath = 5,
	Collision = 6,
	RangeLeave = 7,
	Despawn = 8,
}

return function(Left, Right): boolean
	if Left.TimeElapsed ~= Right.TimeElapsed then
		return Left.TimeElapsed < Right.TimeElapsed
	end

	local LeftPriority = PRIORITIES[Left.Type] or 100
	local RightPriority = PRIORITIES[Right.Type] or 100
	if LeftPriority ~= RightPriority then
		return LeftPriority < RightPriority
	end

	return Left.Sequence < Right.Sequence
end
