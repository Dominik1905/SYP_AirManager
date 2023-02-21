part of user_profile;

class _TelephonenumberTextField extends StatelessWidget {
  const _TelephonenumberTextField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        icon: Icon(Icons.add_call),
        hintText: "Telephonenumber",
      ),
    );
  }
}