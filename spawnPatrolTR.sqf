//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
// null = [thisTrigger,numberEnemy,skill(0.11),radius,building patrol(true by default)] execVM "spawnPatrolTR.sqf";
// null = [spawn position, number of enemies, general skill, radius,building patrol(true by default)] execVM "spawnPatrolTR.sqf";
// null = [player, 4, 0.05, 150, false] execVM "spawnPatrolTR.sqf";
//===========================================================================================
_j_fnc_taskPatrol = {

private ["_grp", "_pos", "_maxDist", "_patrolPoints","_building","_buildingPos","_buildingPoses","_buildingPatrol"];
_grp = _this select 0;
_pos = _this select 1;
_maxDist = _this select 2;
_patrolPoints = _this select 3;
_buildingPatrol = if (count _this > 4) then {_this select 4} else {true};
if !(local _grp) exitWith {}; // Don't create waypoints on each machine
_grp setBehaviour "SAFE";
// Clear existing waypoints first
[_grp] call CBA_fnc_clearWaypoints;
//Create a string of randomly placed waypoints.
private ["_prevPos","_rad"];
_prevPos = _pos;
_rad = _maxDist;
_form = ["STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","FILE","DIAMOND"];

for "_i" from 0 to _patrolPoints do
{
	private ["_wp", "_newPos","_water","_building","_buildingPoses","_buildingPos"];

	_newPos = [_prevPos, _rad, random 360] call BIS_fnc_relPos;

	//Check if WP is on water or too close to previous WP
	if (_newPos distance _prevPos > _rad || surfaceIsWater _newPos) then{_water = true;} else {_water = false};

	while {_water} do {
			_newPos = [_prevPos, _rad, random 360] call BIS_fnc_relPos;
			_rad = _rad - 15;
			if (!surfaceIsWater _newPos) then{_water = false;};
		};
	//Building patrol true, put WP in nearby buildings
	if (_buildingPatrol && _newPos distance (nearestBuilding _newPos) < 30 && _i >= 2) then
	{
		_building = nearestBuilding _newPos;
		_buildingPoses = [_building] call BIS_fnc_buildingPositions;
		if (count _buildingPoses == 0) exitWith {hint "no building positions"};
		_buildingPos = selectRandom _buildingPoses;
		_newPos = _buildingPos;
	};
	_wp = _grp addWaypoint [_newPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 12;

	//Set the group's speed and formation at the first & second waypoint.
	if (_i == 1 || _i == 2) then
	{
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointFormation selectRandom _form;
	};

};//for

//Cycle back to the first position.
private ["_wp", "_newPos","_water"];
_newPos = [_prevPos, _rad, random 360] call BIS_fnc_relPos;
if (_newPos distance _prevPos > _rad || surfaceIsWater _newPos) then{_water = true;} else {_water = false};

		while {_water} do {
				_newPos = [_prevPos, _rad, random 360] call BIS_fnc_relPos;
				_rad = _rad - 15;
				if (!surfaceIsWater _newPos) then{_water = false;};
			};
_wp = _grp addWaypoint [_newPos, 0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 20;
hint "";
true

};
//==============================================================================================
private ["_SideHQ","_grp1","_sl","_num","_gr1","_gr2","_MenArray","_buildingPatrol"];

_sl = _this select 0;
_num =  _this select 1;
_skill = _this select 2;
_radius = if (count _this > 3) then {_this select 3} else {300};
_buildingPatrol = if (count _this > 4) then {_this select 4} else {true};
//_eside = if (count _this > 5) then {_this select 5} else {J_ENEMY_ARRAY};


if (isServer) then
	{

	hintsilent "SPAWN PATROL V160610";

	_SideHQ = createCenter J_SIDE;
	_grp1 = createGroup _SideHQ;

	_MenArray = J_ENEMY_ARRAY;

	for "_x" from 1 to _num do
		{
		//make team
		_man = selectRandom _MenArray;
		_m1 = _grp1 createUnit [_man, getPos _sl, [], 0, "FORM"];
		//_m1 setskill ["general",1];
        _m1 setskill ["aimingAccuracy",_skill];
        _m1 setskill ["aimingShake",0.7];
        _m1 setskill ["aimingSpeed",0.9];
        _m1 setskill ["endurance",0.7];
        _m1 setskill ["spotDistance",0.7];
        _m1 setskill ["spotTime",0.7];
        _m1 setskill ["courage",0.3];
        _m1 setskill ["reloadSpeed",0.7];
        _m1 setskill ["commanding",1];
		sleep 0.8;
		};
_null = [_grp1,_sl, _radius, 7] call _j_fnc_taskPatrol;
//_nul = [_grp1,getPosATL _sl, _radius, 10] call j_fnc_taskPatrol;
sleep 1;
_wPosArray = getWPPos [_grp1, 1];

{_x setPos [( _wPosArray select 0) + 2 - random 4,( _wPosArray select 1) + 2 - random 4,( _wPosArray select 2)]; sleep 0.01;_x allowDamage false;} forEach units _grp1;
sleep 1;
{_x allowDamage true;} forEach units _grp1;


};//isserver


