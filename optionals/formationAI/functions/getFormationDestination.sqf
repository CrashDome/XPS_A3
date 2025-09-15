params ["_unit",["_isCustom",false,[true]],["_following",nil,[objNull]],"_formPos","_distance"];

private _eDest = (expectedDestination _unit)#0;
private _lPos = getposATL _following;

if (_isCustom) exitwith {
	private _relPos = [
		(_lPos#0)+(_distance*(_formPos#1)),
		(_lPos#1)+(_distance*(_formPos#2)),
		(_lPos#2)+(_distance*(_formPos#3))
	];

	// Transform the positions according to following heading
	private _lHead = getDir _following;

		//Transform X,Y position - rotate on following
		private _actualPos = [
			(cos(_lHead)*(_relPos#0-_lPos#0))+(sin(_lHead)*(_relPos#1-_lPos#1))+_lPos#0,
			(cos(_lHead)*(_relPos#1-_lPos#1))-(sin(_lHead)*(_relPos#0-_lPos#0))+_lPos#1,
			_lPos#2
		];

	_actualPos;
};

_eDest;