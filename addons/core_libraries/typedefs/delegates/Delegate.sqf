#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Delegate
	<TypeDefinition>
        --- prototype
        XPS_typ_Delegate : XPS_ifc_IDelegate
        ---
        --- prototype
        createHashmapObject [XPS_typ_Delegate,_signature]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores a pointer to another function/method and calls it when invoked.
	This object can only hold a single pointer (Single-Casting)

Parameters: 
	_signature - (optional - Default: Anything) - a definition of parameters expected when calling "Invoke" method: in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
	
	This signature is strictly checked when Invoke is called and  will fail if parameters passed are not correct. This ensures a standard
	parameter set is expected by all receivers of the Invoke method. Since default is 'anything' all parameter compositions are initially allowed.

	However, a custom signature can be injected at creation or overridden by a derived class. See Example below.

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Delegate"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",_signature]
        ---
    
	Parameters: 
		_signature - (optional - Default: Anything) - a definition of parameters expected when calling "Invoke" method: in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
	
    Return:
        <True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		if !(isnil "_this") then {
			_self set ["_signature",_this];
		} else {
			_self set ["_signature",[]];
		};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Delegate"
		---
	----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IDelegate>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IDelegate"]],
	["_pointer",nil],
	["_signature",[]], // default signature: Anything
    /*----------------------------------------------------------------------------
    Method: Attach
    
        --- Prototype --- 
        call ["Attach",_pointer]
        ---

        <XPS_ifc_IDelegate>

		Attachs a pointer to another function/method
    
    Parameters: 
        _pointer - <Array> in format [HashMapObject,"MethodName"] -OR- <Code>
		
		Example Using Code:
		--- code 
        call ["Attach", compileFinal { hint "Hello";}]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Attach",[_hashmapobject, "MyMethodName"]]
		---
		
	Returns:
		<True> - if attached

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
    ----------------------------------------------------------------------------*/
	["Attach", compileFinal {
		if (isNil "_this") then {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"Attach","Parameter supplied was Nil"]]};
		//Deep copy the array
		//if (_this isEqualType []) then {_this = +_this};
		
		if (_this isEqualType {} || {							//if just code we're good
				_this isEqualTypeParams [createhashmap,""] && 	//if hmobject with methodname...
				{(_this#1) in (_this#0) && 					//check methodname exists...
				{(_this#0) get (_this#1) isEqualType {}}}}			//if methodname is type code - we're good
			) then {
				_self set ["_pointer",_this];
				true;
		} else {
			throw createHashmapObject[XPS_typ_InvalidArgumentException,[_self,"Attach","Argument supplied was not a code block or [hashmapobject,""methodName""] array.",_this]];
		};
	}],
    /*----------------------------------------------------------------------------
    Method: Detach
    
        --- Prototype --- 
        call ["Detach"]
        ---

        <XPS_ifc_IDelegate>

		Detachs the current function/method pointer from the internal pointer 

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Detach", compileFinal {
		private _pointer = _self get "_pointer";
		_self set ["_pointer",nil];
		_pointer;
	}],
    /*----------------------------------------------------------------------------
    Method: Invoke
    
        --- Prototype --- 
        call ["Invoke",_args]
        ---

        <XPS_ifc_IDelegate>

		Calls the attached <code> block OR <hashmapobject> method with _args as the parameters.
    
    Parameters: 
        _args - <Array> - the parameters to pass to the external function/method 
		which must conform to the custom signature passed during creation if one was provided

	Returns:
		<Anything> - result of delegated function if successfully invoked

	Throws: 
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to defined signature
		<XPS_typ_InvalidOperationException> - when an attached code or method pointer no longer exists
    ----------------------------------------------------------------------------*/
	["Invoke", compileFinal {
		if !(_this isEqualTypeParams (_self get "_signature")) exitWith {
			throw createHashmapObject[XPS_typ_InvalidArgumentException,[_self,"Invoke","Signature does not match supplied parameters.",_this]];
		};
		private _pointer = _self get "_pointer";

		switch (true) do {
			 case (_pointer isEqualTypeParams [createhashmap,""] && {!isNil {_pointer#0} && {_pointer#0 getorDefault[_pointer#1,[]] isEqualType {}}}) : {
				_pointer params ["_object","_method"];
				_object call [_method,_this];
			 };
			 case (_pointer isEqualType {}) : {
				_this call _pointer;
			 };
			 default {
				throw createHashmapObject[XPS_typ_InvalidOperationException,[_self,"Invoke","Attached code or method pointer no longer exists",_this]];
			 };
		};
	}]
]
/*---------------------------------------------------------------------------------------
Example: Override class to change signature

	Lets imagine that we want to pass to the delgated function/method the [sender, method name, and the arguments] 
	that was used to Invoke the call.
	
	--- code 
	private _newDelegate = [
		["#type", "Tag_typ_New_Delegate"],
		["#base", XPS_typ_Delegate],
		["#create", {
			 // new signature : [sender objeCt, methodName, arguments]
			_self call ["XPS_typ_Delegate.#create", [createhashmap, "", []]];
		}],
	];

	Tag_typ_New_Delegate = [_newDelegate, false, true, true] call XPS_fnc_buildTypeDefinition;
	---
	
	Now we can use the new delegate type and call Invoke and pass the extra parameters with a strict check.
	--- code 
	_def = [
		["#type", "Example"],
		["delegate", createHashmapObject [Tag_typ_New_Delegate]],
		["MyMethod",  compileFinal { 
			//do some stuff
			private _someArgs = ["I successfully did some stuff"];

			// _self get "delegate" call ["Invoke",_someArgs] - wouldn't work because parameters sent to it don't match signature

			_self get "delegate" call ["Invoke", [_self, "MyMethod", _someArgs]]; // this is correct
		}]
	]
	---
	So whenever the Example's MyMethod is called, it will send to the delegate's attached method (if any) 
	a set of parameters following the new signature:
	---code 
	Example = createHashmapObject [_def];
	Example get "delegate" call ["Attach", compileFinal {
		params ["_object","_methodname","_args"]; 
		hint format["%1 called %2 and returned %3",_object get "#type" select 0, _methodName,_args];
	}];
	Example call ["MyMethod"]; 
	//hints: Example called MyMethod and returned ["I successfully did some stuff"]
	Example call ["MyMethod"]; 
	//hints again: Example called MyMethod and returned ["I successfully did some stuff"]
	---
	---------------------------------------------------------------------------------------*/