extends State

const VectorUtils = preload("res://Utils/VectorUtils.gd")
const MovingResource = preload("res://Player/MovingResource.tscn")

var towingTarget: TrailerBase
var succTarget: GameResource
var gathering_particle_system: CPUParticles
var isSucc = false

onready var path: Path = $Path
onready var timer: Timer = $Timer
onready var secondaryTimer: Timer = $SecondaryTimer

#Sounds
onready var sfx_cloud_succ: AudioStreamSample = preload("res://Audio/SFX/GWJ34_CloudSuckingLoop.wav")
onready var sfx_detach: AudioStreamSample = preload("res://Audio/SFX/GWJ34_DetachTrailer.wav")

func OnStateLoad(parameters: Array):
	towingTarget = parameters[0]
	
func OnStateUnload():
	path.curve.clear_points()
	timer.stop()
	
func Process(delta: float):
	if Input.is_action_just_pressed("select"):
		if !towingTarget.IsTowingCelestialBody():
			if target.nearbyCelestialBody != null:
				towingTarget.AttachCelestialBody(target.nearbyCelestialBody)
				towingTarget.slow_spin()
				
			else:
				stateMachine.SetState("empty")
				AudioManager.play_sfx(sfx_detach)
			
	if Input.is_action_pressed("succ") or Input.is_action_pressed("special"):
		if target.nearbyResourceCloud != null and !isSucc:
			TurnOnSucc(target.nearbyResourceCloud, Input.is_action_pressed("special"))
		elif target.nearbyResourceCloud == null and isSucc:
			TurnOffSucc(Input.is_action_pressed("special"))
	
	if Input.is_action_just_released("succ") or Input.is_action_just_released("special"):
		TurnOffSucc(Input.is_action_just_released("special"))

func PhysicsProcess(delta: float):
	pass
	
func Draw():
	pass
	
func Input(event: InputEvent):
	pass
	
func TurnOnSucc(nearestSucc: GameResource, isSpecial: bool):
	towingTarget.fast_spin()
	
	gathering_particle_system = nearestSucc.gathering_ps.instance()
	towingTarget.add_child(gathering_particle_system)
	
	AudioManager.play_sfx(sfx_cloud_succ, true)
	
	succTarget = nearestSucc
	isSucc = true
	if !isSpecial:
		timer.start()
	else:
		secondaryTimer.start()

func TurnOffSucc(isSpecial: bool):
	
	towingTarget.slow_spin()
	
	if is_instance_valid(gathering_particle_system):
		gathering_particle_system.queue_free()
		gathering_particle_system = null
	
	AudioManager.stop_sfx(sfx_cloud_succ)
	
	if !isSpecial:
		timer.stop()
	else:
		secondaryTimer.stop()
	isSucc = false
	succTarget = null

func SpawnMovingResource():
	if !isSucc:
		pass
	
	towingTarget.PerformAction(succTarget)

func PerformSecondaryAction():
	towingTarget.PerformSecondaryAction(succTarget)
