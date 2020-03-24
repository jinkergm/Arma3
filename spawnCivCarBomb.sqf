//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
//
// Place a game logic down and name it "HONKER" without quotes. Then add the line below to the game logic.
//
//if (isServer) then {null=[this, 200, 2000, 0.1, 200] execVM "spawnCivCarBomb.sqf";};

if (!isServer) exitWith {};
	_center =  _this select 0;
	_minradius = _this select 1;
	_maxradius = _this select 2;
	_skill = _this select 3;
	_startDis = _this select 4;
	_cnt = 0;
	_cntWP = 0;
	hintsilent "spawn civ car bomb v1";
	_SideHQ = createCenter civilian;
	_grp0 = createGroup civilian;

	_hpad = "Land_HelipadEmpty_F" createVehicle getpos _center;
	_roadList =  _center nearRoads _startDis;
	if (count _roadList == 0) then
	{
		_minradius = _minradius + 500;
		_maxradius = _maxradius + 1000;
		_startDis = _startDis+1000;
		_roadList = _center nearRoads _startDis;
	};

	_road = selectRandom _roadList;
	_cpos = getPos _road;
	_cDir = getDir _road;
	_carArray = ["C_Offroad_01_F","C_Van_01_box_F","C_SUV_01_F","C_Van_01_box_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F"];

	_civArray = ["LOP_Tak_Civ_Random"];
	//Make vehicle
	hint 'make car & civ';
	_v1 = createVehicle [(selectRandom _carArray), _cpos, [], 0, "NONE"];
	//createVehicleCrew _v1;
	_rciv= selectRandom _civArray ;
	_civ = _grp0 createUnit [_rciv, _center, [], 0, "NONE"];
	_civ addVest "V_BandollierB_cbr";
	for "_i" from 1 to 4 do {_civ addItemToVest "DemoCharge_Remote_Mag";};
	_civ addItemToUniform "ACE_DeadManSwitch";
	_civ moveInDriver _v1;
	_v1 setDir _cDir;
	_civ setBehaviour "CARELESS";
	_civ setCombatMode "BLUE";
	_v1 lock true;
	_v1 allowDamage false;
		[_v1,_civ] spawn
		{
			_v1 	= _this select 0;
			_civ	= _this select 1;
			while {alive _v1 || alive _civ} do
			{
				_v1 setFuel 1;
				sleep 600;
			};
		};

	hint "make waypoints";
	for "_x" from 1 to 5 do
		{

		//make waypoints
		_wp = str _cntWP;
		_roadList = _center nearRoads _minradius;
		if (count _roadList == 0) then
			{
				_minradius = _minradius+1000;
				_roadList = _center nearRoads _minradius;
			};
		_road = selectRandom _roadList;
		_wp = _grp0 addWaypoint [_road, _cnt];

		_cnt = _cnt+1;
		_cntWP = _cntWP+1;
		_wp = str _cntWP;

		_roadList = _center nearRoads _maxradius;
		_road = selectRandom _roadList;
		if (count _roadList == 0) then
			{
				_maxradius = _maxradius+1000;
				_roadList = _center nearRoads _maxradius;
			};
		_wp = _grp0 addWaypoint [_road, _cnt];

		_cnt = _cnt+1;
		_cntWP = _cntWP+1;
		_wp = str _cntWP;
		};
	_road = selectRandom _roadList;
	_cntWP = _grp0 addWaypoint [_road, _cnt];
	_cntWP setWaypointType "CYCLE";

 	_tr1 = createTrigger ["EmptyDetector",  _center];
    _tr1 setTriggerArea [500, 500, 0, false ];
    _tr1 setTriggerActivation ["WEST", "PRESENT", false];
    _tr1 setTriggerStatements ["this", "", ""];
    _tr1 setTriggerTimeout [0, 0, 0, true ];

	deleteVehicle _hpad;

    waitUntil {triggerActivated _tr1};
	_possTargets = list _tr1;
    _target = selectRandom _possTargets;

	hint "end civ car bomb";
	//waitUntil {(_civ distance _target) < 100};

	waitUntil {{_x distance _civ < 100 && side _x == west }  count _possTargets != 0 || !alive _civ};
	if (!alive _civ) exitWith {_v1 allowDamage true;};
		//_civ enableAI "MOVE";
		_civ setBehaviour "CARELESS";
		_civ setCombatMode "BLUE";


	[_civ,_target] spawn {
				private ["_target","_civ"];
				_civ = _this select 0;
				_target = _this	 select 1;
				while {alive _civ} do {
				_civ move position _target;
				sleep 3;
				}
	};

	waitUntil {(_civ distance _target) < 15 && alive _civ};
	_v1 allowDamage true;
	HONKER action ["useWeapon",_v1,_civ,0];
	sleep 0.5;
	_boom = "Bo_GBU12_LGB" createVehicle getpos _v1;


