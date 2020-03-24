//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////


//waituntil {BIS_fnc_init};
	  	private ["_posA","_posB","_cnt","_dst","_dir","_pos","_d","_p"];
	  	_posA = _this select 0;
	  	_posB = _this select 1;
	  	if (typename _posA == "OBJECT") then {_posA = getpos _posA};
	  	if (typename _posB == "OBJECT") then {_posB = getpos _posB};
	  	_cnt  = _this select 2;

	  	_dst = _posA distance _posB;
	  	_dst = _dst / (_cnt + 1);
	  	_dir = [_posA,_posB] call BIS_fnc_dirTo;
	  	sleep 0.2;
	  	_pos = [];
	  	for "_i" from 0 to (_cnt - 1) do {
    	_d = _dst * (_i + 1);
    	_p = [_posA,_d,_dir] call BIS_fnc_relPos;
    	_pos set [_i,_p];
		sleep 0.2;
    	_rwl = "Land_runway_edgelight" createVehicle  _p;
    	_rwl setPos [(getPos _rwl select 0),(getPos _rwl select 1),(getPos _rwl	 select 2)-0.1];
    	sleep 0.2;
    	};
/**
//if (!isServer) exitWith {};

	_start = _this select 0;
	_end = _this select 1;

	//_roadList = _Loc nearRoads _rad;

	//_count = count _roadList;
	//_count = _count/2;
	for "_x" from 1 to 20 do
		{	//hint "drop";
		//_roadList = _Loc nearRoads 500;

		_lamps = ["Land_runway_edgelight","Land_runway_edgelight_blue_F"];
		_lampx = _lamps call BIS_fnc_selectRandom;
		//_road = _roadList call BIS_fnc_selectRandom;
		_cpos = getPos _road;
		_dir = getDir _road;
		_dir = _dir+90;



/
		};
hint "LIGHTS ON!";
if (true) exitWith {};
