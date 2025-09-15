params [["_unit",objNull,[objNull]]];
private _distThreshold = 0;
switch (true) do {
	case ((vehicle _unit) iskindof "Man") : {_distThreshold = 2;};
	case ((vehicle _unit) iskindof "LandVehicle") : {_distThreshold = 3;};
	case ((vehicle _unit) iskindof "Helicopter") : {_distThreshold = 6;};
	case ((vehicle _unit) iskindof "Plane") : {_distThreshold = 25;};
	default {_distThreshold = 0};
};

_distThreshold;