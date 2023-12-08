import 'dart:developer';
import 'dart:io';

import 'package:admin/api/api_urls.dart';
import 'package:admin/api/http_service.dart';
import 'package:admin/employee_list_screen.dart';
import 'package:admin/helping_widgets.dart';
import 'package:admin/keyboard_activity.dart';
import 'package:admin/local_storage/local_storage.dart';
import 'package:admin/model/user_model.dart';
import 'package:admin/window_permission.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_idle/system_idle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //WindowPermission();
  runApp(const MyApp());
  //check();
  doWhenWindowReady(() {
    final win = appWindow;
    win.alignment = Alignment.topRight;
    win.title = "Admin";
    win.size = Size(600, 340);
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(MediaQuery
            .of(context)
            .size
            .width,
            MediaQuery
                .of(context)
                .size
                .height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Admin',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            themeMode: ThemeMode.dark,
            home: MyHomePage(title: 'Flutter Demo Home Page', toggle: true,),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, this.toggle});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  bool? toggle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool obscure = true;
  final passwordController = TextEditingController();

  check() async {
    await SystemIdle.instance.initialize(time: 10);
    SystemIdle.instance.onIdleStateChanged.listen(
          (isIdle) =>
          setState(() {
            log(isIdle.toString());
          }),
    );
  }

  @override
  void initState() {
    check();
    if (widget.toggle == true) {
      // DesktopWindow.toggleFullScreen();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Admin Login",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: .7.sw,
              height: 35,
              child: TextFormField(
                style: TextStyle(fontSize: 13),
                obscureText: obscure,
                controller: passwordController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),

                    prefixIcon: const InkWell(child: Icon(Icons.password)),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: obscure
                              ? null
                              : Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary,
                        )),
                    label: const Text(
                      "Password", style: TextStyle(fontSize: 13),),
                    border: const OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Theme
                  .of(context)
                  .colorScheme
                  .inversePrimary,
              onPressed: () async {
                if (passwordController.value.text
                    .trim()
                    .isEmpty) {
                  showError("Please Enter Password");
                  return;
                }
                var body = await HttpService().post(url: ApiBaseUrl.login,
                    body: {"password": passwordController.value.text});
                UserModel userModel = UserModel.fromJson(body);
                LocalStorage().writeUserModel(userModel);
                Get.offAll(() => const EmployeeListScreen());
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
