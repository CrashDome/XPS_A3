#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_HashmapCollection
    <TypeDefinition>

Description:
Stores only <HashmapObjects> 

Parent:
    <XPS_typ_Collection>

Implements:
    <XPS_ifc_ICollection>

Flags:
    none

Authors: 
	Crashdome

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_HashmapCollection"],
    ["#base", XPS_typ_Collection],
    ["_allowed",[]],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_Collection,[_allowedTypes]]
        ---
    
    Parameters: 
        _allowedTypes (optional) - <Array> -of <Strings> which are <HashmapObject> '#type's
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self call ["XPS_typ_Collection.#create"];
        params [["_allowedTypes",[],[[]]]];
        if (_allowedTypes isEqualTypeAll "") then {
            _self set ["_allowed",_allowedTypes];
        };
    }],
    /*----------------------------------------------------------------------------
    Method: RegisterType 
    
        --- Prototype --- 
        call ["RegisterType",_type]
        ---
    
    Parameters: 
        _type - <Type> - used to add a type after object creation. In shorthand - i.e. [] or objNull or 0 or createhashmap, etc..
	----------------------------------------------------------------------------*/
    ["RegisterType",compileFinal {
        if !(params [["_type",nil,[]]]) exitwith {false;};
        private _list = _self get "_allowed";
        if (_type in _list) exitwith {false;};
        _list pushback _type;
        true;
    }],
    /* -----------------------------------------------------------------------
    Method: AddItem

        ---prototype
        call ["AddItem",[_key,_item]];
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _key - Anything - Key used when adding to store
        _item - <HashmapObject> - to add to the store

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[createhashmap]]]) exitwith {false;};
        if ((_key == "") || (_key in (keys (_self get "_items")))) exitwith {false;};
        private _allowlist = _self get "_allowed";
        private _types = _item getOrDefault ["#type",[]];
        if !(count (_types arrayIntersect _allowlist) > 0) exitwith {false;};
        (_self get "_items") set [_key,_item];
        true;
    }]

    /* -----------------------------------------------------------------------
    Method: RemoveItem
		<XPS_typ_Collection.RemoveItem>

    -------------------------------------------------------------------------*/ 

    /* -----------------------------------------------------------------------
    Method: GetItems
		<XPS_typ_Collection.GetItems>

    -------------------------------------------------------------------------*/ 
]