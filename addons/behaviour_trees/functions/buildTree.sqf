#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: behaviour_trees. XPS_BT_fnc_buildTree
	
	---prototype
	_tree = [_treeDefinition] call XPS_BT_fnc_buildTree;
	---

Description:
    Builds a behaviour tree from a structured array. Array format is as follows:

	* Each Node is represented as a two element array [ NODE_TYPE_VAR, [ ...children...] ]
		* where NODE_TYPE_VAR is a <HashmapObject> type definition 
	* The children are a multidimensional array with each child as a two element array as above
	* If a node has no children, the second element can be omitted
	
	For example:
	---text
		[
			RootNode,
			[
				[ChildA],
				[ChildB, 
					[
						[ChildC],
						[ChildD]
					]
				],
				[ChildE,
					[ChildF],
					[ChildG,
						[
							[ChildH],
							[ChildI]
						]
					]
				]
			]
		]
	---

Returns:
	<HashmaObject> - root node of tree -OR- <Boolean> - false if error

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _treeDefinition
		<Array> - Multidimensional <array> as defined in description above  

	Return: _tree
		<HashmapObject> - A <hashmapObject> with nested children <hashmapobjects>

	Example: Simple Example
		Using the example structure in the description, it would appear like so:

		--- Code
		private _treeDef = [RootNode,[[ChildA],[ChildB,[[ChildC],[ChildD]]],[ChildE,[ChildF],[ChildG,[[ChildH],[ChildI]]]]]];
		private _tree = [_treeDef] call XPS_BT_fnc_buildTree;
		---
		This results in _tree as a <hashmapobject> structured as so:

		- RootNode
			- ChildA
			- ChildB
				- ChildC
				- ChildD
			- ChildE
				- ChildF
				- ChildG
					- ChildH
					- ChildI

---------------------------------------------------------------------------- */
params [["_definition",[],[[]]]];

private _fnc_HandleChildren = compileFinal {
	params ["_parentNode",["_children",[],[[]]]];
	
	private _nodeType = _parentNode getOrDefault ["NodeType",""];
	if (_nodeType in [XPS_BT_NodeType_Composite,XPS_BT_NodeType_Decorator]) then {
		//Validate child count
		private _childCount = count _children;
		if (_childCount isEqualTo 0) exitWith {
			diag_Log format ["No Children assigned to a node that requires children : %1",_parentNode];
			false;
		}; 
		if (_nodeType isEqualTo XPS_BT_NodeType_Decorator && {_childCount > 1}) exitWith {
			diag_Log format["More than one child added to decorator : %1",_parentNode];
			false;
		};
		// Add children to parent
		for "_i" from 0 to _childCount-1 do {
			private _typeDef = _children#_i#0;
			private _grandChildren = [];
			if (count (_children#_i) > 1 && {_children#_i#1 isEqualtype []}) then {_grandchildren = _children#_i#1};
			private _childNode = createHashmapObject [_typeDef];
			_parentNode call ["AddChildNode",_childNode];
			if (_grandchildren isNotEqualTo []) then {
				[_childNode, _grandChildren] call _fnc_HandleChildren;
			};
		};
	};
};

if (_definition isEqualType [] && {_definition isNotEqualTo []}) then {
	private _rootNode = createHashmapObject [_definition#0];
	private _children = [];
	if (count _definition > 1 && {_definition#1 isEqualtype []}) then {
		_children = _definition#1;
	};

	[_rootNode, _children] call _fnc_HandleChildren;

	_rootNode;
};
