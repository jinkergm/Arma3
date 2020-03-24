//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
// null = [center(thisTrigger), minimum radius, maximum radius, skill(0.11), max starting distance, speed] execVM "spawnHmgINS.sqf";
// null = [thisTrigger, 100, 500, 0.2, 300, 50] execVM "spawnHmgINS.sqf";
if (!isServer) exitWith {};
	_center = _this select 0;
	_minradius = _this select 1;
	_maxradius = _this select 2;
	_skill = _this select 3;
	_startDis = _this select 4;
	_speed = if (count _this > 5) then {_this select 5} else {50};;
	_cnt = 0;
	_cntWP = 0;
	hintsilent "spawn HMG/GMG v1";
	_SideHQ = createCenter J_SIDE;
	_grp0 = createGroup _SideHQ;

	_roadList = getPos _center nearRoads _startDis;
	_road = selectRandom _roadList;

	while {(getpos _center distance getPos _road) <_startDis-200}  do
        {
       		_roadList = getPos _center nearRoads _startDis;
			_road = selectRandom _roadList;
			sleep 0.03;
        };

	_cpos = getPos _road;
	_cDir = getDir _road;
	_carArray = ["rhs_btr80a_msv"];//rhs_tigr_sts_vdv

	//Make vehicle
	hint 'make car';
	_car = selectRandom _carArray;
	_v1 = _car createVehicle _cpos;
	//MCC_Curator addCuratorEditableObjects [[_v1],true];
	createVehicleCrew _v1;
	_grp0 = group _v1;
	_grp0 addVehicle _v1;
	//_driver = _grp0 createUnit ["75_o_tl", getPos _center, [], 0, "NONE"];
	//_gunner = _grp0 createUnit ["75_o_rifle", getPos _center, [], 0, "NONE"];
	//_driver moveInDriver _v1;
	//_gunner moveInGunner _v1;
	_v1 setDir _cDir;
	_grp0 setBehaviour "SAFE";
	_grp0 setSpeedMode "LIMITED";
	_v1 limitSpeed _speed;
	{_x setskill ["aimingAccuracy",0.10];} forEach units _grp0;
	hint "make waypoints";
	for "_x" from 1 to 10 do
		{

		//make waypoints
		_wp = str _cntWP;
		_roadList = getPos _center nearRoads _minradius; //ensure blank trigger 'island' is present, covering the island
		_road = selectRandom _roadList;
		_wp = _grp0 addWaypoint [_road, _cnt];

		_cnt = _cnt+1;
		_cntWP = _cntWP+1;
		_wp = str _cntWP;

		_roadList = getPos _center nearRoads _maxradius; //ensure blank trigger 'island' is present, covering the island
		_road = selectRandom _roadList;
		_wp = _grp0 addWaypoint [_road, _cnt];

		_cnt = _cnt+1;
		_cntWP = _cntWP+1;
		_wp = str _cntWP;
		};
	_road = selectRandom _roadList;
	_cntWP = _grp0 addWaypoint [_road, _cnt];
	_cntWP setWaypointType "CYCLE";

hint "end spawnHMG";