
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		tag = "xps";
		class Exceptions {
			XPS_CFG_IFC_SUB(exceptions,IException);
			XPS_CFG_TYP_SUB(exceptions,Exception);
			XPS_CFG_TYP_SUB(exceptions,ArgumentNilException);
			XPS_CFG_TYP_SUB(exceptions,ArgumentOutOfRangeException);
			XPS_CFG_TYP_SUB(exceptions,InvalidArgumentException);
			XPS_CFG_TYP_SUB(exceptions,InvalidOperationException);
		};
		class Delegates {
			XPS_CFG_IFC_SUB(delegates,IDelegate);
			XPS_CFG_IFC_SUB(delegates,IMultiCastDelegate);
			XPS_CFG_TYP_SUB(delegates,Delegate);
			XPS_CFG_TYP_SUB(delegates,MultiCastDelegate);

		};
		class Enumerations {
			XPS_CFG_IFC_SUB(enumerations,IEnumeration);
			XPS_CFG_TYP_SUB(enumerations,Enumeration);
		};
		class Collections {
			XPS_CFG_IFC_SUB(collections,ICollection);
			XPS_CFG_IFC_SUB(collections,IOrderedCollection);
			XPS_CFG_IFC_SUB(collections,IQueue);
			XPS_CFG_IFC_SUB(collections,IStack);
			XPS_CFG_IFC_SUB(collections,ITypeRestrictor);
			XPS_CFG_TYP_SUB(collections,NoTypeRestrictor);
			XPS_CFG_TYP_SUB(collections,NativeTypeRestrictor);
			XPS_CFG_TYP_SUB(collections,HashmapObjectTypeRestrictor);
			XPS_CFG_TYP_SUB(collections,TypeCollection);
			XPS_CFG_TYP_SUB(collections,Queue);
			XPS_CFG_TYP_SUB(collections,Stack);
		};
		class Searching {
			XPS_CFG_IFC_SUB(searching,IAstarNode);
			XPS_CFG_IFC_SUB(searching,IAstarGraph);
			XPS_CFG_IFC_SUB(searching,IAstarSearch);
			XPS_CFG_TYP_SUB(searching,AstarSearch);
		};

		XPS_CFG_IFC(IBlackboard);
		XPS_CFG_IFC(IJobScheduler);
		XPS_CFG_TYP(Blackboard);
		XPS_CFG_TYP(JobScheduler);		

	};
};