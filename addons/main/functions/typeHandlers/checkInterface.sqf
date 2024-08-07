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
	<Boolean> - (optional - Default: false) - used to allow keys with nil values. Nil values might be required if a <TypeDefinition> 
	contains properties 'by ref' where the <TypeDefinition> is set to nil but the concrete <HashmapObject> instantiates the property at #create.

Returns: _result
	<Boolean> - <True> if <TypeDefinition>/<Hashmap> or <HashmapObject> has keys defined with types that match <Interface> definition

Example: Check a hashmap if it supports interface
    --- Code
		MyHashmap = createhashmapfromArray [["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
		MyInterface = [["PropertyA","STRING"],["Method","CODE"],["PropertyB","SCALAR"]];
        private _result = [MyHashmap,["MyInterface"]] call XPS_fnc_checkInterface; 
		// _result is 'true'
    ---

---------------------------------------------------------------------------- */

params [["_hashmap",createhashmap,[createhashmap]],["_interfaces",[],[[],""]],["_allowNils",false,[true]]];

if (_hashmap isEqualTo createhashmap) exitwith {
	diag_log text (format ["XPS_fnc_checkInterface: parameters not valid.  -- Hashmap: %1 -- Interfaces:%1",_this select 0,_this select 1]);
	false;
};

if (_interfaces isEqualType "") then {_interfaces = [_interfaces]};
if !(_interfaces isEqualTypeAll "") exitwith {
	diag_log text (format ["XPS_fnc_checkInterface: Interface parameter must be an array of all strings.  Param:%1",_this select 1]);
	false;
};

private _result = true;

for "_a" from 0 to (count _interfaces -1) do {
	private _interface = [];
	//Loose Check - get interface ref direct from type def
	if ((_interfaces#_a) in (_hashmap getOrDefault ["@interfaces",createhashmap])) then {
		_interface = _hashmap get "@interfaces" get (_interfaces#_a);
	} else { 
	// Strict Check - interface not in declared list - build it from string var
		_interface = call compile (_interfaces#_a);
		if !(_interface isEqualType createhashmap) then {
			// Not a valid hashmap - exit without checking and fail
			diag_log text (format ["XPS_fnc_checkInterface: Interface was not a valid hashmap.  Interface provided:%1",_interfaces#_a]);
			_interface = createhashmap;
			_result = false;
		};
	};

	if (isNil {_interface}) exitwith {
		diag_log text (format ["XPS_fnc_checkInterface: Interface was nil.  Interface provided:%1",_interfaces#_a]);
		_result = false;
	};
	
	//Check each interface loop
	{
		[_x,_y] params ["_key","_checkType"];
		//Check key exists
		if !(_key in _hashmap) then {
			diag_log text (format ["XPS_fnc_checkInterface: Type:%1 - %2 key is missing for Interface: %3",_hashmap get "#type",_key,_interfaces#_a]);
			_result = false;
			continue;
		};
		//Check value type
		if !(_checkType in ["ANYTHING","ANY"]) then {
			private _type = typename (_hashmap get _key);
			if (isNil {_type}) then { 
				if !(_allowNils) then {
					diag_log text (format ["XPS_fnc_checkInterface: Type:%1 - %2 key set to nil during a check where they are not allowed",_hashmap get "#type",_key]);
					_result = false;
				} else {continue};
			};
			// Check if Hashmap Object and get type if exists
			if (_type == "HASHMAP") then {
				private _types = (_hashmap get _key) getOrDefault ["#type",_type];
				private _typeIfcs = (_hashmap get _key) getOrDefault ["@interfaces",_type];
				// Check type if actual instantiated object
				if (_types isEqualtype []) then {
					if (toLower _checkType in (_types apply {toLower _x})) then {
						continue;
					};
				};
				// Check Interfaces last
				if (_typeIfcs isEqualtype createhashmap) then {
					if (toLower _checkType in ((keys _typeIfcs) apply {toLower _x})) then {
						continue;
					};
				};
			};
			if !(tolower _type isEqualTo tolower _checkType) then {
				diag_log text (format ["XPS_fnc_checkInterface: Type:%1 - %2 key has a value type %3. Type %4 expected",_hashmap get "#type",_key,_type,_checkType]);
				_result = false;
			};
		};
	} foreach _interface;
};
_result;
