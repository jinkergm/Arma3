//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
//
//
//
//null=[player, 200] execVM "suicideBomber.sqf";
_loc =  _this select 0;
_radius = _this select 1;
private ["_civ", "_myman","_mrkciv","_SideHQ","_gp1","_dir","_spawnLoc","_sl","_euroMenArray","_gr1","_gr2","_null","_gr4","_gp2","_grp","_grd3","_gp4","_gp5","_gp6","_gp7","_cars","_r","_objective","_object1","_building","_jwest","_jeast","_jciv","_MenArray","_loc","_cacheA","_cacheB","_grp0"];

	_SideHQ = createCenter EAST;
	_grp0 = createGroup EAST;
	_gp1 = createGroup EAST;

	_r = round(random 50);
	_r = _r+50;
	/*
	_bestPlace = selectBestPlaces [getPos _Loc, 200, "(1 + meadow) * (1 - hills) * (1 - forest) * (1 - trees) * (10 - sea)", 1, 5];
	_spot = _bestPlace select 0;
	_spot2 = _spot select 0;
	*/
	_newPos = [ _loc, 10, _radius, 5, 0, 0.4, 0] call BIS_fnc_findSafePos;
	while {isOnRoad _newpos} do
	{
		_newPos = [ _loc, 10, _radius, 5, 0, 0.4, 0] call BIS_fnc_findSafePos;
	};
	_slum = ["Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_cargo_house_slum_F"];
	_slumHouse = selectRandom _slum;
	_building = createVehicle [_slumHouse, _newpos, [], 0, "CAN_COLLIDE"];
	_building setVectorUp [0,0,1];
	_building setDir random 360;
	_MenArray = ["LOP_Tak_Civ_Random"];
	_myman = selectRandom _MenArray;

	//"O_officer_F" createUnit [getpos _jinkObj1, _gp1,"hvt=this", _skill, "MAJOR"];
	_civ = _gp1 createUnit [_myman,  _loc, [], 0, "NONE"];
	_civ setPos getpos _building;
	_civ disableAI "MOVE";
	_civ addVest "V_BandollierB_cbr";
	for "_i" from 1 to 4 do {_civ addItemToVest "DemoCharge_Remote_Mag";};
	_civ addItemToUniform "ACE_DeadManSwitch";
	sleep 0.1;
	//_null = [_civ,'j_fnc_addactionCiv',true,true] spawn BIS_fnc_MP;

	sleep 0.2;
	hintsilent "";

 	_tr1 = createTrigger ["EmptyDetector",  _loc];
    _tr1 setTriggerArea [300, 300, 0, false ];
    _tr1 setTriggerActivation ["WEST", "PRESENT", false];
    _tr1 setTriggerStatements ["this", "", ""];
    _tr1 setTriggerTimeout [0, 0, 0, true ];
/**/
	//_vest = _civ addVest "V_Chestrig_rgr";


	hint "suicide bomber  end";



	waitUntil {triggerActivated _tr1};
	sleep 5;
	_possTargets = list _tr1;
    _target = selectRandom _possTargets;

	//waitUntil {(_civ distance _target) < 200};
	waitUntil {{_x distance _civ < 100 and side _x == west }  count _possTargets != 0};

		_civ enableAI "MOVE";
		_civ setBehaviour "CARELESS";
		_civ setCombatMode "BLUE";


	[_civ,_target] spawn {
					private ["_civ","_target"];
					_civ = _this select 0;
					_target = _this select 1;
					while {alive _civ} do {
					_civ enableAI "MOVE";
				    _civ move position _target;
				    sleep 3;

		}
	};


	waitUntil {(_civ distance _target) < 10 && alive _civ};
	//playSound3D ["x\alive\addons\mil_ied\audio\alive_akbar.ogg", _civ, false, getPos _civ, 1, 1, 0];
	//playSound3D [MISSION_ROOT + "sound\AllahuAkbar.ogg", _civ, false, getPos _civ, 1, 1, 0];
	////[[_civ], 'j_fnc_soundSUICIV'] call BIS_fnc_MP;
	//_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
	//_soundToPlay = _soundPath + "sound\AllahuAkbar.ogg";
	//playSound3D [_soundToPlay, _civ, false, getPos _civ, 10, 1, 50];
	[_civ, "aa1"] remoteExec ["say3D",-2,false];
	[_civ, "aa1"] remoteExec ["say3D",-2,false];
	[_civ, "aa1"] remoteExec ["say3D",-2,false];
	_boom = "Bo_GBU12_LGB" createVehicle getpos _civ;//[getpos _civ select 0, getpos _civ select 1,(getpos _civ select 2) +2]; //Bo_GBU12_LGB M_NLAW_AT_F





