#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_AP_typ_CompoundTask
	<TypeDefinition>
		---prototype
		XPS_AP_typ_CompoundTask : XPS_AP_ifc_ICompoundTask
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_CompoundTask"]
    	---

Authors: 
	Crashdome

Description:
	A Compound task is a collection of methods tested in order until a condition
	is Satisfied within the Method
Returns:
	<HashmapObject> of a Method

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_CompoundTask"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_CompoundTask"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_ICompoundTask>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_ICompoundTask"]],
	/*----------------------------------------------------------------------------
	Property: Methods
    
    	--- Prototype --- 
    	get "Methods"
    	---

		<XPS_AP_ifc_ICompoundTask>
    
    Returns: 
		<Array> - ordered list of usually <XPS_AP_typ_Methods>
	-----------------------------------------------------------------------------*/
	["Methods",[]],
	/*----------------------------------------------------------------------------
	Method: PreCondition
    
    	--- Prototype --- 
    	call ["PreCondition",_args*]
    	---

        Alternative: 

        --- code ---
        get "PreCondition"  //allows lazy execution
        ---

		<XPS_AP_ifc_ICompoundTask>
    
    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Precondition when executed

    Returns: 
		<Boolean> - True if satisfied, otherwise False

	-----------------------------------------------------------------------------*/
    ["PreCondition",{}]
]