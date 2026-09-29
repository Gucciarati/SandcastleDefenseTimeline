# Sandcastle defense timeline processor

This is an unchanged excerpt from my personal, in-progress Roblox project **Build A Sandcastle**. It is a code sample, not a shipped-game claim or a standalone playable project.

`DefenseProcessor/` provides a small event timeline service. Callers provide keypoints with elapsed times; the processor sorts them, waits for each due time, optionally processes or inserts keypoints, and dispatches registered event callbacks. The public module is `DefenseProcessor/init.luau`. `DefenseProcessor/Types.luau` documents the broader defense data model used by the project.

The folder requires a Roblox Luau environment. The surrounding project supplies the timeline and any callback behavior; this excerpt does not include game assets or a runnable place. No automated tests or Studio verification are included with this sample.
