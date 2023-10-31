#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_checkInterface
	
	---prototype
	_result = [_type, _interfaces] call XPS_fnc_checkInterface
	---

	---prototype
	_result = [_type, _interfaces, true] call XPS_fnc_checkInterface
	---

Description:
    Used to determine if a <Hashmap> or <HashmapObject> has the desired keys returning the desired type.

	Keys can be anything that is valid for a <HashmapKey> although strings as keys are typically used for <HashmapObjects>

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _type 
	<HashMap> or <HashmapObject> - the map/object to check

Parameter: _interfaces 
	<Array> - an <array> of <Strings> in the format ["Interface1","Interface2"...] string should be a global variable of type <Interface>

Optional: _allowNils* 
	<Boolean> - (optional) default: true - used to allow keys with nil values

Returns: _result
	<Boolean> - True if <TypeDefinition> has keys defined with types that match <Interface> definition

Example: Check a hashmap if it supports interface
    --- Code
		MyHashmap = createhashmapfromArray [["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];
        private _result = [MyHashmap,["MyInterface"]] call XPS_fnc_checkInterface; 
		// _result is 'true'
    ---

---------------------------------------------------------------------------- */

if !(params [["_hashmap",nil,[createhashmap]],["_interfaces",nil,[[]]],"_allowNils"]) exitwith {
	diag_log (format ["XPS_fnc_checkInterface: parameters not valid.  -- Hashmap: %1 -- Interfaces:%1",_this select 0,_this select 1]);
	false;
};
if !(_interfaces isEqualTypeAll "") exitwith {
	diag_log (format ["XPS_fnc_checkInterface: Interfaces must be all strings.  Interfaces:%1",_this select 1]);
	false;
};

_allowNils = [_allowNils] param [0,false,[true]];

private _result = true;

for "_a" from 0 to (count _interfaces -1) do {
	private _interface = [];
	//Loose Check - get interface ref direct from type def
	if ((_interfaces#_a) in keys (_hashmap getOrDefault ["@interfaces",createhashmap])) then {
		_interface = _hashmap get "@interfaces" get (_interfaces#_a);
	} else { 
	// Strict Check - interface not in declared list - build it
		_interface = call compile (_interfaces#_a);
	};

	if (isNil {_interface}) exitwith {
		diag_log (format ["XPS_fnc_checkInterface: Interface was nil.  Interfaces:%1",_interfaces#_a]);
		_result = false;
	};
	
	{
		[_x,_y] params ["_key","_checkType"];
		//Check key exists
		if !(_key in keys _hashmap) then {
			diag_log (format ["XPS_fnc_checkInterface: Type:%1 - %2 key is missing",_hashmap get "#type",_key]);
			_result = false;
			continue;
		};
		//Check value type
		if !(_checkType in ["ANYTHING","ANY"]) then {
			private _type = typename (_hashmap get _key);
			if (isNil {_type}) then { 
				if !(_allowNils) then {
					diag_log (format ["XPS_fnc_checkInterface: Type:%1 - %2 key set to nil during a check where they are not allowed",_hashmap get "#type",_key]);
					_result = false;
				} else {continue};
			};
			// Check if Hashmap Object and get type if exists
			if (_type isEqualTo "HASHMAP") then {
				private _types = (_hashmap get _key) getOrDefault ["#type",_type];
				if (typeName _types isEqualto "ARRAY") then {
					if !(_checkType in _types) then {
						diag_log (format ["XPS_fnc_checkInterface: Type:%1 - %2 key has a value type %3. Type %4 expected",_hashmap get "#type",_key,_type,_checkType]);
						_result = false;
					};
					continue;
				};
			};
			if !(_type isEqualTo _checkType) then {
				diag_log (format ["XPS_fnc_checkInterface: Type:%1 - %2 key has a value type %3. Type %4 expected",_hashmap get "#type",_key,_type,_checkType]);
				_result = false;
			};
		};
	} foreach _interface;
};
_result;