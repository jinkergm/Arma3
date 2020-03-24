//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
// null = [thisTrigger,numberEnemy,skill(0.11),radius,building threshold,delay,% that stay] execVM "spawnDefendTR.sqf";
// null = [thisTrigger,4+random 2,0.2,200,2,9999,0.5] execVM "spawnDefendTR.sqf";
/*
j_fnc_taskDefend ={

private ["_group","_position","_radius","_threshold"];
_group = (_this select 0) call CBA_fnc_getgroup;
_position = (if (count _this > 1) then {_this select 1} else {_group}) call CBA_fnc_getpos;
_radius = if (count _this > 2) then {_this select 2} else {50};
_threshold = if (count _this > 3) then {_this select 3} else {2};

_group enableattack false;

private ["_count", "_list", "_list2", "_units", "_i"];
_statics = [_position, vehicles, _radius, {(_x iskindof "StaticWeapon") && {(_x emptypositions "Gunner" > 0)}}] call CBA_fnc_getnearest;
_buildings = _position nearObjects ["building",_radius];
_buildings2 = _position nearObjects ["house",_radius];
_buildings append _buildings2;
_units = units _group;
_count = count _units;

{
    if (str(_x buildingpos _threshold) == "[0,0,0]") then {_buildings = _buildings - [_x]};
} foreach _buildings;
_i = 0;
{
    _count = (count _statics) - 1;
    if (random 1 < 0.31 && {_count > -1}) then {
        _x assignasgunner (_statics select _count);
        _statics resize _count;
        [_x] ordergetin true;
        _i = _i + 1;
    } else {
        if (random 1 < 0.93 && {count _buildings > 0}) then {
            private ["_building","_p","_array"];
            _building = selectRandom _buildings;
            _array = _building getvariable "CBA_taskDefend_positions";
            if (isnil "_array") then {
                private "_k"; _k = 0;
                _building setvariable ["CBA_taskDefend_positions",[]];
                while {str(_building buildingpos _k) != "[0,0,0]"} do {
                    _building setvariable ["CBA_taskDefend_positions",(_building getvariable "CBA_taskDefend_positions") + [_k]];
                    _k = _k + 1;
                };
                _array = _building getvariable "CBA_taskDefend_positions";
            };
            if (count _array > 0) then {
                _p = selectRandom (_building getvariable "CBA_taskDefend_positions");
                _array = _array - [_p];
                if (count _array == 0) then {
                    _buildings = _buildings - [_building];
                    _building setvariable ["CBA_taskDefend_positions",nil];
                };
                _building setvariable ["CBA_taskDefend_positions",_array];
                [_x,_building buildingpos _p] spawn {
                    if (surfaceIsWater (_this select 1)) exitwith {};
                    (_this select 0) domove (_this select 1);
                    sleep 5;
                    waituntil {unitready (_this select 0)};
                    (_this select 0) disableai "move";
                    dostop _this;
                    waituntil {not (unitready (_this select 0))};
                    (_this select 0) enableai "move";
                };
                _i = _i + 1;
            };
        };
    };
} foreach _units;
{
    _x setvariable ["CBA_taskDefend_positions",nil];
} foreach _buildings;
if (count _this > 4 && {!(_this select 4)}) then {_i = _count};

};
*/
//====================================main===========================================
private ["_SideHQ","_grp1","_dir","_man","_sl","_num","_grp1","_","_redMenArray","_gr4","_buildThresh","_delay","_radius"];

_sl = _this select 0;
_num =  _this select 1;
_skill = _this select 2;
_radius = if (count _this > 3) then {_this select 3} else {200};
_buildThresh = if (count _this > 4) then {_this select 4} else {2};
_delay = if (count _this > 5) then {_this select 5} else {9999};
_dontMove = if (count _this > 6) then {_this select 6} else {0.5};
//_eside = if (count _this > 7) then {_this select 7} else {J_ENEMY_ARRAY};
if (isServer) then
	{

	hintsilent "SPAWN DEFEND V160529";

	_SideHQ = createCenter J_SIDE;
	_grp1 = createGroup _SideHQ;

	for "_x" from 1 to _num do
		{
		//make team
		_man = selectRandom J_ENEMY_ARRAY;

		_m1 = _grp1 createUnit [_man, getPosATL _sl, [], 0, "FORM"];
		//_m1 setskill ["general",1];
        _m1 setskill ["aimingAccuracy",_skill];
        _m1 setskill ["aimingShake",0.7];
        _m1 setskill ["aimingSpeed",0.4];
        _m1 setskill ["endurance",0.7];
        _m1 setskill ["spotDistance",0.7];
        _m1 setskill ["spotTime",0.7];
        _m1 setskill ["courage",0.3];
        _m1 setskill ["reloadSpeed",0.7];
        _m1 setskill ["commanding",1];
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
        sleep 0.05;
        //_null = [_grp1, _grp1, _radius, _buildThresh, true] call j_fnc_taskDefend;
	};
    _grp2 = createGroup _SideHQ;
    sleep 3;
    _numofunits = count units _grp1;
    _numDontMove = _numofunits * _dontMove;
    for "_i" from 1 to _numDontMove do
    {
        _grouppp = units _grp1 select 0;
        [_grouppp] join _grp2;
    };


    //[_grp1] call CBA_fnc_searchNearby;

    //CBA_fnc_waypointGarrison
     [_grp1, getPos _sl] execVM "\x\cba\addons\ai\fnc_waypointGarrison.sqf";
     [_grp2, getPos _sl] execVM "\x\cba\addons\ai\fnc_waypointGarrison.sqf";
    //_null = [_grp1, _grp1, _radius, _buildThresh, true] call CBA_fnc_taskDefend;
    //_null = [_grp2, _grp2, _radius, _buildThresh, true] call j_fnc_taskDefend;
while {({alive _x} count units _grp1) >= 0} do {
     [_grp1, getPos _sl] execVM "\x\cba\addons\ai\fnc_waypointGarrison.sqf";

     //_null = [_grp1, getPos _sl] call bis_fnc_taskDefend;
     //_null = [_grp1, _grp1, _radius, _buildThresh, true] call CBA_fnc_taskDefend;
     //_null = [_grp1, _grp1, _radius, _buildThresh, true] execVM "defendArea.sqf";
     //[_grp1] call CBA_fnc_searchNearby;
     //_null = [_grp1, _grp1, _radius, _buildThresh, true] call j_fnc_taskDefend;
    sleep _delay;//+random 30

	};

hintSilent "end defendTR";
};//isserver



