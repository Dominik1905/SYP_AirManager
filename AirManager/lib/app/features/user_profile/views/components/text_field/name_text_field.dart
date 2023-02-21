part of user_profile;

class _NameTextField extends StatelessWidget {
  const _NameTextField({required this.controller, Key? key}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        icon: Icon(Icons.accessibility),
        hintText: "Name",
      ),
    );
  }
}