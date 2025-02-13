import 'package:flutter/material.dart';

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(text),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38),
            ),
            onPressed: onTap,
            child: const Text(
              'Try again',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
}
