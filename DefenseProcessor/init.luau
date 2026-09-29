--!strict

local Operations = script.Internal.Operations

return table.freeze({
	PlayTimeline = require(Operations.PlayTimeline),
	RegisterEventCallback = require(Operations.RegisterEventCallback),
})
