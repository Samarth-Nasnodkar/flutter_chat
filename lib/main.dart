import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat/pages/chat_page.dart';
import 'package:flutter_chat/pages/home_page.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/new_user_setup.dart';
import 'package:flutter_chat/pages/signup_page.dart';
import 'package:flutter_chat/pages/welcome_page.dart';
import 'package:flutter_chat/utils/auth_service.dart';
import 'package:flutter_chat/utils/gauth.dart';
import 'package:flutter_chat/widgets/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (ctx) => ctx.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (_) => GAuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        routes: {
          // "/": (context) => const AuthWrapper(),
          "/home": (context) => const HomePage(),
          "/signup": (context) => SignUpPage(),
          "/login": (context) => LoginPage(),
          "/welcome": (context) => const WelcomePage()
          // "/chat": (context) => const ChatPage(index: 0),
        },
      ),
    );
  }
}
