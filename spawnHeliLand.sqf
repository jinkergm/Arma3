//null = [LandObject thisTrigger,AttackTarget thisTrigger,skill(0.2)] execVM 'heliLand.sqf';
// null = [player,player,0.1] execVM 'heliLand.sqf';

if (!isServer) exitWith {};
	hint "heli squad landing v200205";
	_land = _this select 0;
	_goto = _this select 1;
	_skill = _this select 2;

	_dir = 180 + random 360;
	//_land = _end;
	_sp1 = createMarker ["sp11", position _land];
	_dz1 = createMarker ["dz1", position _land];

	sleep 1;
	"sp11" setMarkerPos [(getPos _land select 0)-3000*sin(_dir),(getPos _land select 1)-3000*cos(_dir),(getPos _land select 2)+0];
	"dz11" setMarkerPos [getPos _land select 0,(getPos _land select 1)+0];


	//_newPos = [getPos _land, 200, 400, 20, 0, 0.3, 0] call BIS_fnc_findSafePos;
	_p = [_land, 200 +random 200, _dir] call BIS_fnc_relPos;

	sleep 1;
	_hpad = "Land_HelipadEmpty_F" createVehicleLocal position _land;
	sleep 2;
	hint "";
	_hpad setPosATL _p;
	//_land setPos getPos _road;
	//_jinklights = 0;
	_SideHQ = createCenter J_SIDE;

	_spawnLoc = getMarkerPos "sp11";
	_dropLoc = getMarkerPos "dz1";
	_transportHelo = "RHS_Mi8mt_vvsc";//Cha_Mi24_D_Cuba

	_grp1 = createGroup J_SIDE;
	/*
	_pilot 	= _grp1 createUnit [J_PILOT, getMarkerPos "sp11", [], 0, "NONE"];
	_vehicle = createVehicle [_transportHelo, _spawnLoc, [], 0, "FLY"];
	clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
	_pilot moveInDriver _vehicle;
	_pilot setskill 1;
	*/
	//_pilot doMove position _land;
	_veh = [getMarkerPos "sp11", _dir, _transportHelo, _grp1] call Bis_fnc_spawnvehicle;
	_vehicle = _veh select 0;
	//createVehicleCrew _vehicle;
	_vehicle doMove position _land;
	//_vehicle setVelocity [0,0,10];
	_vehicle flyInHeight 50;
	_grp1 setSpeedMode "FULL";
	_grp1 setBehaviour "STEALTH";
	_grp1 setCombatMode "GREEN";

	_wp = _grp1 addWaypoint [position _hpad, 0];
	_wp setWaypointType  "TR UNLOAD";

	_grp2 = createGroup EAST;

	_m1 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m2 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m3 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m4 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m5 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m6 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m7 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];
	_m8 = _grp2 createUnit [selectRandom J_ENEMY_ARRAY, [0,0,10000], [], 0, "FORM"];

	{_x moveInCargo _vehicle;_x setSkill _skill;} foreach units _grp2;

	//_light = "Chemlight_red" createVehicle getPos _vehicle;
	_light = createVehicle ["F_20mm_Red", [0,0,0], [], 0, "NONE"];
	//_light enableSimulationGlobal false;
	_light attachto [_vehicle,[0,0,-0.5]];


	_vehicle setSpeedMode "FULL";
	_grp1 setBehaviour "SAFE";
	_grp2 setBehaviour "COMBAT";

	_vehicle doMove position _land;

	waitUntil {(_vehicle distance _hpad) < 600};
	hintSilent "close to LZ";
	_vehicle setSpeedMode "LIMITED";
	/*
	waitUntil {unitReady _pilot};
	_wp = _grp1 addWaypoint [position _hpad, 0];
	_wp setWaypointType  "TR UNLOAD";
	*/
	//_vehicle land "land";

	waitUntil {(_vehicle distance _hpad) < 40};
	hintSilent "very close to LZ";
	//lightDetachObject _light;
	deleteVehicle _light;
	//_light = "Chemlight_yellow" createVehicle getPos _vehicle;
	_light = createVehicle ["F_20mm_Yellow", [0,0,0], [], 0, "NONE"];
	//_light enableSimulationGlobal false;
	_light attachto [_vehicle,[0,0,-1]];


	//waitUntil {(_pilot distance _hpad) < 7};
	waitUntil {(getPosATL _vehicle select 2) < 7};
	hintSilent "landing";
	//lightDetachObject _light;
	deleteVehicle _light;
	//_light = "Chemlight_green" createVehicle getPos _vehicle;
	_light = createVehicle ["F_20mm_green", [0,0,0], [], 0, "NONE"];
	//_light enableSimulationGlobal false;
	_light attachto [_vehicle,[0,0,-0.5]];


	//waitUntil {(_vehicle distance _hpad) < 5};
	waitUntil {(getPosATL _vehicle select 2) < 1};
	_vehicle setFuel 0;
	waitUntil {(speed _vehicle) < 1};


	{_x action ["GETOUT",_vehicle];
		unassignVehicle _x;
		sleep 0.2;} foreach units _grp2;


	sleep 2;
	_vehicle setFuel 1;
	_vehicle setSpeedMode "FULL";
	_grp1 setBehaviour "COMBAT";
	_grp2 setBehaviour "COMBAT";


	sleep 1;

	_vehicle doMove _spawnLoc;
	{_x doMove position _goto;} foreach units _grp2;

	/**/
	//lightDetachObject _light;
	deleteVehicle _light;
	_light = createVehicle ["Chemlight_red", [0,0,0], [], 0, "NONE"];
	_light enableSimulationGlobal false;
	_light attachto [_vehicle,[0,0,-0.5]];

	_vehicle doMove _spawnLoc;
	_vehicle setBehaviour "SAFE";
	_vehicle setCombatMode "BLUE";
	player action ["lightOn", _vehicle];
	_vehicle setBehaviour "SAFE";

	_null=[_vehicle] spawn
		{
		_vehicle = _this select 0;
		while {alive _vehicle} do {
			player action ["lightOn", _vehicle];
			//sleep 0.00;
			};
		};

	_vehicle flyInHeight 50;

	sleep 20;
	{_x doMove position _goto;} foreach units _grp2;

	waitUntil {(_vehicle distance _spawnLoc) < 500};
	hint "delete heli";
	deleteVehicle _vehicle;
	//deleteVehicle _pilot;
	deleteVehicle _light;
	deleteVehicle _hpad;

if (true) exitwith{hintSilent "end heliLand";};