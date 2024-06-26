#include "\x\xps\addons\core\script_macros.hpp"

#define XPS_UT_CFG_BASECLASSNAME XPS_Unit_Testing
#define QXPS_UT_CFG_BASECLASSNAME Q(XPS_UT_CFG_BASECLASSNAME)

#define XPS_UT_CFG_TEST(typName) class typName {\
    file = FILEPATH_C_Q(unittests\typName.sqf);\
}

#define XPS_UT_CFG_TEST_SUB(sub,typName) class typName {\
    file = FILEPATH_C_Q(unittests\sub\typName.sqf);\
}