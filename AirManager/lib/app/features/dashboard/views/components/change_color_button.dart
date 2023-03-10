part of dashboard;

class _ChangeColorButton extends StatelessWidget {
  const _ChangeColorButton({
    required this.isLoading,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AsyncButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
      onPressed: onPressed,
      child: const Text("Change Color"),
      isLoading: isLoading,
    );
  }
}