--!strict

local State = require(script.Parent.Parent.Parent.State)

return function(EventName: string, Callback: (...any) -> ()): () -> ()
	local Callbacks = State.EventCallbacks[EventName]
	if not Callbacks then
		Callbacks = {}
		State.EventCallbacks[EventName] = Callbacks
	end

	table.insert(Callbacks, Callback)
	local Connected = true

	return function()
		if not Connected then
			return
		end
		Connected = false

		local Index = table.find(Callbacks, Callback)
		if Index then
			table.remove(Callbacks, Index)
		end
	end
end
