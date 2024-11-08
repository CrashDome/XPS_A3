#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_OrderedCollectionN
	<TypeDefinition>
        --- prototype
        XPS_typ_OrderedCollectionN : XPS_ifc_ICollection, XPS_ifc_ICollectionNotifier, XPS_typ_OrderedCollection
        ---
        --- prototype
        createHashmapObject [XPS_typ_OrderedCollectionN]
        ---

Authors: 
	Crashdome
   
Description:
	A collection which is ordered by a numerical index. Contains event handlers to 
    notify if the collection has changed via Add, Remove, and Set. 

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_OrderedCollectionN"],
    /*----------------------------------------------------------------------------
    Parent: #base
        <XPS_typ_OrderedCollection>
    ----------------------------------------------------------------------------*/    
    ["#base",XPS_typ_OrderedCollection],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---
    
    Return:
        <True>
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self call ["XPS_typ_OrderedCollection.#create"];
        _self set ["_onCollectionChangedEvent",createHashmapObject [XPS_typ_Event]];
        _self set ["CollectionChanged",createHashmapObject [XPS_typ_EventHandler,[_self get "_onCollectionChangedEvent"]]];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_OrderedCollectionN"
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_ICollection>
        <XPS_ifc_ICollectionNotifier>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_ICollection","XPS_ifc_ICollectionNotifier"]],
    ["_onCollectionChangedEvent",nil],
    /*----------------------------------------------------------------------------
    Method: Clear
        <XPS_typ_OrderedCollection.Clear>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Count
        <XPS_typ_OrderedCollection.Count>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: IsEmpty
        <XPS_typ_OrderedCollection.IsEmpty>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: AddItem
        <XPS_typ_OrderedCollection.AddItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        private _index = _self call ["XPS_typ_OrderedCollection.AddItem",_this];
        _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["AddItem",[_index,_this]]]];
        _index;
    }],
    /*----------------------------------------------------------------------------
    Method: RemoveItem
        <XPS_typ_OrderedCollection.RemoveItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        private _item = _self call ["XPS_typ_OrderedCollection.RemoveItem",_this];
        if !(isNil "_item") then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["RemoveItem",[_this,_item]]]];
        };
        _item;
    }],
    /*----------------------------------------------------------------------------
    Method: FindItem
        <XPS_typ_OrderedCollection.FindItem>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: GetItem
        <XPS_typ_OrderedCollection.GetItem>
    ----------------------------------------------------------------------------*/

    /* -----------------------------------------------------------------------
    Method: GetItems
        <XPS_typ_OrderedCollection.GetItems>
    -------------------------------------------------------------------------*/ 
    /*----------------------------------------------------------------------------
    Method: SetItem
        <XPS_typ_OrderedCollection.SetItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["SetItem", compileFinal {
        if (_self call ["XPS_typ_OrderedCollection.SetItem",_this]) then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["SetItem",_this]]];
            true;
        } else {false};
	}],
    /*----------------------------------------------------------------------------
    Method: UpdateItem
        <XPS_typ_OrderedCollection.UpdateItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["UpdateItem", compileFinal {
        if (_self call ["XPS_typ_OrderedCollection.UpdateItem",_this]) then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["UpdateItem",_this]]];
            true;
        } else {false};
	}],
    /*----------------------------------------------------------------------------
    Method: InsertItem
        <XPS_typ_OrderedCollection.InsertItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["InsertItem", compileFinal {
        if (_self call ["XPS_typ_OrderedCollection.UpdateItem",_this]) then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["InsertItem",_this]]];
            true;
        } else {false};
	}],
    /*----------------------------------------------------------------------------
    EventHandler: CollectionChanged
    
        --- Prototype --- 
        get "CollectionChanged"
        ---

        <XPS_ifc_ICollectionNotifier>

    Returns:
        <XPS_typ_EventHandler>

    Signature: 
        [_sender, [_methodName, _item] ]

        _sender - <XPS_typ_OrderedCollection> - this object
        _methodName - <String> - "AddItem", "RemoveItem", "SetItem", "UpdateItem"
        _item - the item that changed or in case of <AddItem> an <array> in form [_index, _item]

    ----------------------------------------------------------------------------*/
    ["CollectionChanged",nil]
]