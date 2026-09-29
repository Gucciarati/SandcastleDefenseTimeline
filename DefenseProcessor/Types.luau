--!strict

export type BlockData = {
	Id: string,
	CFrame: CFrame,
	Size: Vector3,
	Health: number,
	MaxHealth: number,
	Resistance: number,
	IsWeapon: boolean,
	WeaponRange: number?,
	WeaponDPS: number?,
	IsGrounded: boolean?,
	Connections: { string }?,
	Instance: Instance?,
}

export type PlotData = {
	CFrame: CFrame,
	Size: Vector3,
	SpawnPadding: number,
}

export type BuildSnapshot = {
	Blocks: { [string]: BlockData },
	Plot: PlotData,
}

export type AttackData = {
	Id: string,
	Type: string,
	Variant: string,
	SizeId: string,
	Size: Vector3,
	SpawnTime: number,
	SpawnPosition: Vector3,
	Direction: Vector3,
	Speed: number,
	MaxHealth: number,
	Pressure: number,
	CollisionCost: number,
	EndTime: number,
}

export type Keypoint = {
	Type: string,
	TimeElapsed: number,
	Sequence: number,
	AttackId: string?,
	BlockId: string?,
	Position: Vector3?,
	Revision: number?,
	Cue: string?,
}

export type Timeline = {
	Seed: number,
	Duration: number,
	Attacks: { [string]: AttackData },
	Keypoints: { Keypoint },
}

return {}
