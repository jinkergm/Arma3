//null = [center, ammo, radius, number, delay] execVM "spawnArty.sqf";
//null = [thisTrigger, "R_80mm_HE", 80, 5, 4] execVM "spawnArty.sqf";
//M_PG_AT R_80mm_HE G_40mm_HE M_NLAW_AT_F M_RPG32_F Bo_GBU12_LGB
if (isServer) then
	{
_center = _this select 0;
_ammo = _this select 1;
_rad = _this select 2;
_num = _this select 3;
_delay = _this select 4;

for "_i" from 1 to _num do
{
    //Bo_GBU12_LGB
    private ["_r","_d","_p","_boom"];
	_r = random _rad;
	_d = random 360;
	_p = _center getrelPos  [_r, _d];
	_boom = _ammo createVehicle _p;
	//_boom = "M_TOW_AT" createVehicle [_p select 0, _p select 1,(_p select 2) +300];
	//_boom setVelocity [0,0,-300];
	sleep _delay;
};
	sleep 10;

	_SideHQ = createCenter J_SIDE;
	_grp1 = createGroup _SideHQ;

	_spawn = "Land_Wrench_F" createVehicleLocal [0,0,0];
	_p = _center getPos [600, random 360];
	_spawn setPos _p;

	_man = selectRandom J_ENEMY_ARRAY;
	_m1 = _grp1 createUnit [_man, position _spawn, [], 0, "FORM"];
	//_m1 setskill ["general",1];
    _m1 setskill ["aimingAccuracy",0.2];
    _m1 setskill ["aimingShake",0.7];
    _m1 setskill ["aimingSpeed",0.9];
    _m1 setskill ["endurance",0.7];
    _m1 setskill ["spotDistance",0.7];
    _m1 setskill ["spotTime",0.7];
    _m1 setskill ["courage",0.7];
    _m1 setskill ["reloadSpeed",0.7];
    _m1 setskill ["commanding",1];
    _m1 addBackpack "RHS_Podnos_Bipod_Bag";

	_man = selectRandom J_ENEMY_ARRAY;
	_m2 = _grp1 createUnit [_man, position _spawn, [], 0, "FORM"];
	//_m2 setskill ["general",1];
    _m2 setskill ["aimingAccuracy",0.2];
    _m2 setskill ["aimingShake",0.7];
    _m2 setskill ["aimingSpeed",0.9];
    _m2 setskill ["endurance",0.7];
    _m2 setskill ["spotDistance",0.7];
    _m2 setskill ["spotTime",0.7];
    _m2 setskill ["courage",0.7];
    _m2 setskill ["reloadSpeed",0.7];
    _m2 setskill ["commanding",1];
    _m2 addBackpack "RHS_Podnos_Gun_Bag";

    [_grp1, [getPos _center, 800, 800, 0, false]] call CBA_fnc_taskSearchArea;
	deleteVehicle _spawn;
};