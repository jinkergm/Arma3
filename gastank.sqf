// this addEventHandler ["killed", {Null = _this execVM "gastank.sqf";}];
//if(!isServer) exitWith{};
_item= _this select 0;
_item removeAllEventHandlers "killed";


	_center = createCenter sideLogic;
	_group = createGroup _center;
	_pos = getpos _item;
	_rand = 5+random 5;
	sleep _rand;

	_nearBarrels = nearestObjects [_item, ["BarrelBase"], 2.5];
	{_x setDamage 1;} forEach _nearBarrels;
	_nearBarrels = nearestObjects [_item, ["AmmoBoxEast"], 3.5];
	{_x setDamage 1;} forEach _nearBarrels;
	_fire = _group createUnit ["ModuleEffectsFire_F",[0,0,0], [], 0, ""];
	_fire setVariable ["Timeout", 16];
	_fire setVariable ["ParticleSize",(1+ random 1)];
	_fire setVariable ["ParticleDensity",(15 + random 8)];
	_fire setVariable ["ParticleSpeed",(0.8 + random 0.5)];
	_fire setVariable ["FireDamage",1];
	_fire setVariable ["EffectSize",(0.1 + random 2)];
	_fire setVariable ["ParticleOrientation",3];
	_fire attachto [_item,[0,0,0]];
	detach _fire;
/*
_colorRed = _logic getVariable ["ColorRed",0.5];
_colorGreen = _logic getVariable ["ColorGreen",0.5];
_colorBlue = _logic getVariable ["ColorBlue",0.5];
_timeout = _logic getVariable ["Timeout",0];
_particleLifeTime = _logic getVariable ["ParticleLifeTime",2];
_particleDensity = _logic getVariable ["ParticleDensity",20];
_particleSize = _logic getVariable ["ParticleSize",1];
_particleSpeed = _logic getVariable ["ParticleSpeed",1];
_effectSize = _logic getVariable ["EffectSize",1];
_orientation = _logic getVariable ["ParticleOrientation",5.4];
_damage = _logic getVariable ["FireDamage",1];

*/

	_smoke = _group createUnit ["ModuleEffectsSmoke_F",[0,0,0], [], 0, ""];
	_smoke setVariable ["ColorAlpha",0.8];
	_smoke setVariable ["Timeout", 17.5];
	_smoke setVariable ["ParticleLifeTime",2];
	_smoke setVariable ["ParticleDensity",10];
/*
	_smoke setVariable ["ParticleSize",0.001];
	_smoke setVariable ["ParticleSpeed",0.03];

	_smoke setVariable ["EffectSize",0.001];
	_smoke setVariable ["Expansion",0.5];
	*/
	_smoke attachto [_item,[0,0,0]];
	detach _smoke;

/*
_colorRed = _logic getVariable ["ColorRed",0.5];
_colorGreen = _logic getVariable ["ColorGreen",0.5];
_colorBlue = _logic getVariable ["ColorBlue",0.5];
_colorAlpha = _logic getVariable ["ColorAlpha",0.5];
_timeout = _logic getVariable ["Timeout",0];
_particleLifeTime = _logic getVariable ["ParticleLifeTime",50];
_particleDensity = _logic getVariable ["ParticleDensity",10];
_particleSize = _logic getVariable ["ParticleSize",1];
_particleSpeed = _logic getVariable ["ParticleSpeed",1];
_particleLifting = _logic getVariable ["ParticleLifting",1];
_windEffect = _logic getVariable ["WindEffect",1];
_effectSize = _logic getVariable ["EffectSize",1];
_expansion = _logic getVariable ["Expansion",1];

*/

	for "_x" from 1 to 3 do
		{
			_oil = "Oil_Spill_F" createVehicle [0,0,0];
			_oil setDir random 360;
			_oil attachto [_item,[0,0,0]];
			detach _oil;
		};

//_item setPos getpos _fire;
_boomType = ["M_NLAW_AT_F","R_TBG32V_F","SLAMDirectionalMine_Wire_Ammo","M_NLAW_AT_F"];// M_NLAW_AT_F "R_80mm_HE","R_TBG32V_F","SLAMDirectionalMine_Wire_Ammo","Bo_Mk82"
_boomer = selectRandom _boomType;
_boom = _boomer createVehicle [getpos _item select 0, getpos _item select 1,(getpos _item select 2) +0.2];
_boom setDamage 1;
_item setDamage 1;
_item setVelocity [5-random 10,5-random 10,15+random 15];



