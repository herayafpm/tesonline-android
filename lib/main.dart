import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Trans;
import 'package:tes_online/controllers/home/home_controller.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/splash_screen_page.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/auth/login_page.dart';
import 'package:tes_online/ui/auth/lupa_password/cek_kode_page.dart';
import 'package:tes_online/ui/auth/lupa_password/lupa_password_page.dart';
import 'package:tes_online/ui/auth/lupa_password/ubah_password_page.dart';
import 'package:tes_online/ui/auth/register_page.dart';
import 'package:tes_online/ui/home/admin/soal/edit_soal_page.dart';
import 'package:tes_online/ui/home/admin/soal/soal_page.dart';
import 'package:tes_online/ui/home/admin/soal/tambah_soal_page.dart';
import 'package:tes_online/ui/home/admin/tes/tes_page.dart';
import 'package:tes_online/ui/home/akun/profile_page.dart';
import 'package:tes_online/ui/home/akun/ubah_password_profile_page.dart';
import 'package:tes_online/ui/home/akun/ubah_profile_page.dart';
import 'package:tes_online/ui/home/home_page.dart';
import 'package:tes_online/ui/home/test_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Digunakan untuk memaksa potrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Inisialisasi library hive (penyimpanan mirip SQLite)
  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserModelAdapter());
  // Run Aplikasi
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(StaticData.screenWidth, StaticData.screenHeight),
      builder: () => GetMaterialApp(
          title: "Tes Online 129",
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: appThemeData,
          defaultTransition: Trans.Transition.native,
          getPages: [
            GetPage(name: "/", page: () => SplashScreenPage()),
            GetPage(name: "/auth/login", page: () => LoginPage()),
            GetPage(name: "/auth/register", page: () => RegisterPage()),
            GetPage(
                name: "/auth/lupa_password", page: () => LupaPasswordPage()),
            GetPage(
                name: "/auth/lupa_password/cek_kode",
                page: () => CekKodePage()),
            GetPage(
                name: "/auth/lupa_password/ubah_password",
                page: () => UbahPasswordPage()),
            GetPage(name: "/home", page: () => HomePage(), binding: HomeBind()),
            GetPage(name: "/akun/profile", page: () => ProfilePage()),
            GetPage(name: "/akun/profile/ubah", page: () => UbahProfilePage()),
            GetPage(
                name: "/akun/profile/ubah_password",
                page: () => UbahPasswordProfilePage()),
            GetPage(name: "/tes", page: () => TestPage()),
            GetPage(name: "/admin/soal", page: () => ManajemenSoalPage()),
            GetPage(name: "/admin/soal/tambah", page: () => TambahSoalPage()),
            GetPage(name: "/admin/soal/edit", page: () => UbahSoalPage()),
            GetPage(name: "/admin/tes", page: () => TesPage()),
          ]),
    );
  }
}

class HomeBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
