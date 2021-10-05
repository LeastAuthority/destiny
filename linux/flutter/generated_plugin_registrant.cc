//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <dart_wormhole_william/dart_wormhole_william_plugin.h>
#include <desktop_window/desktop_window_plugin.h>
#include <window_size/window_size_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dart_wormhole_william_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DartWormholeWilliamPlugin");
  dart_wormhole_william_plugin_register_with_registrar(dart_wormhole_william_registrar);
  g_autoptr(FlPluginRegistrar) desktop_window_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DesktopWindowPlugin");
  desktop_window_plugin_register_with_registrar(desktop_window_registrar);
  g_autoptr(FlPluginRegistrar) window_size_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WindowSizePlugin");
  window_size_plugin_register_with_registrar(window_size_registrar);
}
