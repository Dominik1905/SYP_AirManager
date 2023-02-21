part of user_profile;

class _GoToDashboard extends StatelessWidget {
  const _GoToDashboard({
    required this.isLoading,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: onPressed,
    );
  }
}
