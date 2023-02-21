part of user_profile;

class _DesiredRoomTemperature extends StatelessWidget {
  const _DesiredRoomTemperature({required this.controller, Key? key}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        icon: Icon(Icons.thermostat),
        hintText: "Desired Temperature",
      ),
    );
  }
}