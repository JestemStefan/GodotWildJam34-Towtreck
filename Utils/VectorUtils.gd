extends Node

static func GetDistance(fromWhere: Spatial, toWhere: Spatial) -> float:
	return fromWhere.global_transform.origin.distance_to(toWhere.global_transform.origin)
