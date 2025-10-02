params [["_unit",objNull,[objNull]]];
private _dist = 1;
switch (true) do {
	case ((vehicle _unit) iskindof "Man") : {_dist = 6;};
	case ((vehicle _unit) iskindof "LandVehicle") : {_dist = 12;};
	case ((vehicle _unit) iskindof "Helicopter") : {_dist = 25;};
	case ((vehicle _unit) iskindof "Plane") : {_dist = 50;};
	default {_dist = 1};
};

_dist;
