//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
// null = [starting distance,numberEnemy,skill(0.11),target(thisTrigger),direction] execVM "spawnAttackTR.sqf";
private ["_SideHQ","_grp1","_dir","_spawn","_sl","_p","_gr1","_urbanMenArray","_redMenArray","_target","_num","_skill","_man"];

_dist = _this select 0;
_num =  _this select 1;
_skill = _this select 2;
_target = _this select 3;
_dir = if (count _this > 4) then {_this select 4} else {random 360};
if (isServer) then
	{

	hintsilent "SPAWN ATTACK V181123";

	_SideHQ = createCenter J_SIDE;
	_grp1 = createGroup _SideHQ;

	_spawn = "Land_Wrench_F" createVehicleLocal [0,0,0];
	_p = _target getPos [_dist, _dir];
	_spawn setPos _p;


	for "_x" from 1 to _num do
		{

		//make team

		_man = selectRandom J_ENEMY_ARRAY;

		_m1 = _grp1 createUnit [_man, position _spawn, [], 0, "FORM"];
		//_m1 setskill ["general",1];
        _m1 setskill ["aimingAccuracy",_skill];
        _m1 setskill ["aimingShake",0.7];
        _m1 setskill ["aimingSpeed",0.9];
        _m1 setskill ["endurance",0.7];
        _m1 setskill ["spotDistance",0.7];
        _m1 setskill ["spotTime",0.7];
        _m1 setskill ["courage",0.7];
        _m1 setskill ["reloadSpeed",0.7];
        _m1 setskill ["commanding",1];
		_m1 domove position _target;
		sleep 0.3;
		hint "";
		//_result = [_m1, [], []] call BIS_fnc_unitHeadgear; // Headgear and face wear
		 if (_man == "j_lat") then
        {
        	for "_i" from 1 to 2 do {_m1 addItemToBackpack "rhs_rpg7_PG7VL_mag";};
        };
        if (_man == "j_aa") then
        {
        	_m1 addBackpack "rhs_sidor";
			_m1 addItemToBackpack "rhs_mag_9k38_rocket";
        };
		};
		_grp1 setBehaviour "COMBAT";
		deleteVehicle _spawn;
		waitUntil {(units _grp1 select 0) distance _spawn > _dist-15};
		hintsilent "searching...";
		[_grp1, [getPos _target, 200, 200, 0, false]] call CBA_fnc_taskSearchArea;
		deleteVehicle _spawn;

sleep 3;
hint "";
};//isserver


