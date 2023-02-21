part of user_profile;

class _AdressTextFiel extends StatelessWidget {
  const _AdressTextFiel({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        icon: Icon(Icons.add_home_outlined),
        hintText: "Adress",
      ),
    );
  }
}