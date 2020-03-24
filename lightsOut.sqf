 //_null = [thisTrigger,1600, false] execVM "lightsout.sqf";
 //_null = [center,radius, on (true/false)] execVM "lightsout.sqf";

 _center = _this select 0;
 _radius = _this select 1;
 _on = _this select 2;

 {
 	[_x,_on] call BIS_fnc_switchLamp;
      false;
 } count nearestObjects [ _center,["Lamps_base_F","PowerLines_base_F","PowerLines_Small_base_F","Land_fs_roof_F","Land_fs_sign_F","Land_fs_feed_F","Land_fs_price_F"],_radius];
_list = getPos _center nearObjects ["Land_fs_roof_F", _radius]; _list select 0 setDammage 0.95;
