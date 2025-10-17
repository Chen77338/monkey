#include "monkeyApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
monkeyApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

monkeyApp::monkeyApp(const InputParameters & parameters) : MooseApp(parameters)
{
  monkeyApp::registerAll(_factory, _action_factory, _syntax);
}

monkeyApp::~monkeyApp() {}

void
monkeyApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAllObjects<monkeyApp>(f, af, syntax);
  Registry::registerObjectsTo(f, {"monkeyApp"});
  Registry::registerActionsTo(af, {"monkeyApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
monkeyApp::registerApps()
{
  registerApp(monkeyApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
monkeyApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  monkeyApp::registerAll(f, af, s);
}
extern "C" void
monkeyApp__registerApps()
{
  monkeyApp::registerApps();
}
