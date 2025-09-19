import 'package:flutter/material.dart';


class FortiButton extends StatelessWidget {
final String label;
final VoidCallback onPressed;
final bool loading;
final Widget? leading;


const FortiButton({
super.key,
required this.label,
required this.onPressed,
this.loading = false,
this.leading,
});


@override
Widget build(BuildContext context) {
return SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: loading ? null : onPressed,
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
mainAxisSize: MainAxisSize.min,
children: [
if (leading != null) ...[
leading!,
const SizedBox(width: 8),
],
if (loading)
const SizedBox(
width: 20,
height: 20,
child: CircularProgressIndicator(strokeWidth: 2),
)
else
Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
],
),
),
);
}
}