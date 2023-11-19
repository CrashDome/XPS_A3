
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC(INode);
		};

		class Enumerations {
			XPS_CFG_ENUM(Status);
		}; 

		class BaseNodes {
			XPS_CFG_TYP_SUB(base,Composite);
			XPS_CFG_TYP_SUB(base,Decorator);
			XPS_CFG_TYP_SUB(base,Leaf);
			XPS_CFG_TYP_SUB(base,LeafAsync);
		};
		class VirtualNodes {
			XPS_CFG_TYP(Action);
			XPS_CFG_TYP(ActionAsync);
			XPS_CFG_TYP(Condition);
			XPS_CFG_TYP(Inverter);
			XPS_CFG_TYP(Parallel);
			XPS_CFG_TYP(Selector);
			XPS_CFG_TYP(Sequence);
			XPS_CFG_TYP(SubTree);
		};		
	};
};