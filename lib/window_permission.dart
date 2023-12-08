import 'dart:ffi';
import 'package:admin/helping_widgets.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

WindowPermission() {
  // Request storage permissions
  final result = CoInitializeEx(
    nullptr,
    COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE,
  );

  if (result == S_OK || result == S_FALSE) {
    final hr = CoInitializeSecurity(
      nullptr,
      -1,
      nullptr,
      nullptr,
      RPC_C_AUTHN_LEVEL_DEFAULT,
      RPC_C_IMP_LEVEL_IMPERSONATE,
      nullptr,
      0, // Use 0 instead of EOAC_NONE
      nullptr,
    );

    if (SUCCEEDED(hr)) {
      showError("Storage permissions granted!");
      // Your application logic here
      print('Storage permissions granted!');
    } else {
      if (hr == RPC_E_TOO_LATE) {
        showError("Error: COM security initialized too late. Ensure proper privileges.");

        print('Error: COM security initialized too late. Ensure proper privileges.');
      } else {
        print('Failed to initialize security: ${HRESULT_FROM_WIN32(hr)}');
      }
    }
  } else {
    print('Failed to initialize COM: ${HRESULT_FROM_WIN32(result)}');
  }
}
