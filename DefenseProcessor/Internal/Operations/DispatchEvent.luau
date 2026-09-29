--!strict

local State = require(script.Parent.Parent.Parent.State)

return function(EventName: string, ...: any)
	local Callbacks = State.EventCallbacks[EventName]
	if not Callbacks then
		return
	end

	for _, Callback in Callbacks do
		task.spawn(Callback, ...)
	end
end
