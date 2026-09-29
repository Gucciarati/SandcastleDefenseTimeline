--!strict

local CompareKeypoints = require(script.Parent.CompareKeypoints)

return function(Keypoints)
	table.sort(Keypoints, CompareKeypoints)

	return Keypoints
end
