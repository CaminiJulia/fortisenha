import 'package:flutter/material.dart';
import '../theme.dart';


class FortiLogo extends StatelessWidget {
final double size;
const FortiLogo({super.key, this.size = 28});


@override
Widget build(BuildContext context) {
return Row(
mainAxisSize: MainAxisSize.min,
children: [
Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: kFortiBlue.withOpacity(0.25),
borderRadius: BorderRadius.circular(14),
border: Border.all(color: kFortiBlue.withOpacity(0.6), width: 1),
),
child: const Icon(Icons.lock_rounded, color: kFortiYellow, size: 28),
),
const SizedBox(width: 12),
RichText(
text: TextSpan(
children: const [
TextSpan(text: 'Forti', style: TextStyle(fontWeight: FontWeight.w700)),
TextSpan(text: 'senha', style: TextStyle(fontWeight: FontWeight.w300, color: kFortiYellow)),
],
style: TextStyle(fontSize: size, color: Colors.white),
),
),
],
);
}
}