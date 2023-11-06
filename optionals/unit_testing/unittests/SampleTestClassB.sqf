#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_SampleTestClassB
	<TypeDefinition>

	--- prototype
	createhashmapobject [XPS_UT_typ_SampleTestClassB];
	---

Authors: 
	Crashdome
   
Description:
	A sample Unit Test Class.
	
	Contains Methods which will be called according to order defined in <TestOrder> property

Parent:
    <XPS_UT_typ_TestClass>

Implements:
    <XPS_UT_ifc_ITestClass>

Flags:


---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_SampleTestClassB"],
	["#base", XPS_typ_TestClass],
	["TestDescription","Sample Test Class B"],
	["TestOrder",[
		"Check A and B are same type",
		"Check B and C are same type",
		"Check A and C are same type",
		"Check A and B are not the same",
		"Check A and B are not equal to each other",
		"Check We can append [10] to A"
	 ]],
	["InitTest",{
		//Initialize some testing values
		XPS_SampleTest_Values = createhashmapfromarray [
			["A",[1]],
			["B",[2]],
			["C",[3]]
		];
	}],
	["FinalizeTest",{
		//Destroy testing values
		XPS_SampleTest_Values = nil;
	}],
	// Test Methods ------------------------------------
	["Check A and B are same type",{
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["IsEqualType",[_a,_b]];
	}],
	["Check B and C are same type",{
		private _c = XPS_SampleTest_Values get "C";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["IsEqualType",[_c,_b]];
	}],
	["Check A and C are same type",{
		private _a = XPS_SampleTest_Values get "A";
		private _c = XPS_SampleTest_Values get "C";

		XPS_UT_Assert call ["IsEqualType",[_a,_c]];
	}],
	["Check A and B are not the same",{
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["AreNotSame",[_a,_b]];
	}],
	["Check A and B are not equal to each other",{
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["AreNotEqual",[_a,_b]];
	}],
	["Check We can append [10] to A",{
		XPS_SampleTest_Values get "A" append [10];
		private _a = XPS_SampleTest_Values get "A";

		XPS_UT_Assert call ["AreEqual",[_a,[1,10]]];
	}]
]
