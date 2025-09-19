import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/forti_logo.dart';


class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});


@override
State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
super.initState();
Future.delayed(const Duration(seconds: 2), () {
if (!mounted) return;
Navigator.pushReplacementNamed(context, '/login');
});
}


@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [kFortiBlack, kFortiBlue],
),
),
child: const Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
FortiLogo(size: 30),
SizedBox(height: 18),
CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(kFortiYellow)),
],
),
),
),
);
}
}