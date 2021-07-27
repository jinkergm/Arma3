//////////////////////////////////////////////////////////////////
// Function file for Arma 3
// Created by: Jinker
//////////////////////////////////////////////////////////////////
// null = [player] execVM "tunnel.sqf";

    _loc = _this select 0;
/*
	_grp = createGroup EAST;

	_trap = _grp createUnit ["vn_module_tunnel_init",_pos, [], 0, ""];
    //_trap setVariable ["vn_tunnel_trapped",true];
    _trap setVariable ["vn_tunnel_trapped", false, true];
    [[_trap], EAST,30] spawn vn_fnc_tunnel_spawn_units;
*/
// The tunnel you would like to have
private _tunnelNo = floor(random 5); // from 0 to 5 !!!

// These are the tunnel positions on the map
private _pos = [[393.346,16979.3,0],[253.172,18696.2,0],[540.936,20206.0,0],[2730.52,20066.4,0],[4252.47,20084.8,0],[5769.42,20088.9,0]] select _tunnelNo;

// Find the tunnel objects for your location
private _tunnels = nearestObjects [_pos,["Land_vn_tunnel_01_building_01_01","Land_vn_tunnel _01_building_04_01","Land_vn_tunnel_01_building_03 _01","Land_vn_tunnel_01_building_02_01"],200];

// Create the logic and stor logic object into global variable
private _grp = createGroup sideLogic;
"vn_module_tunnel_init" createUnit [_loc,_grp,
"this setVariable ['BIS_fnc_initModules_disableAutoActivation',true,true];myTunnel = this;"];

// Now set the wanted tunnel
myTunnel setvariable ["tunnel_position",_tunnelNo];

myTunnel setVariable ["vn_tunnel_trapped", false, true];
// Call the init module function
["",[myTunnel,true]] call vn_fnc_module_tunnel_init;

// And finally spawn the units in your tunnel segments
private _group = [_tunnels,EAST,30,['vn_o_men_vc_regional_01','vn_o_men_vc_regional_04 ']] call vn_fnc_tunnel_spawn_units;

