//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dart_wormhole_william/dart_wormhole_william_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dart_wormhole_william_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DartWormholeWilliamPlugin");
  dart_wormhole_william_plugin_register_with_registrar(dart_wormhole_william_registrar);
}
