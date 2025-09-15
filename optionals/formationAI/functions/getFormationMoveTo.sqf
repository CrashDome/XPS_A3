params ["_unit","_leader","_destination","_distanceThreshold"];

private _z = _destination#2; 
private _pos = _destination vectorAdd ((velocity _leader) vectorMultiply _distanceThreshold); 
_pos set [2,_z];
_pos;