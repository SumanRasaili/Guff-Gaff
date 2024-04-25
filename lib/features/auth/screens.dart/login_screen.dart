import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/custom_button.dart';
import 'package:guffgaff/config/app_colors.dart';
import 'package:guffgaff/features/auth/controller/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils/utils.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  static const String routeName = "/login-screen";
  const LoginScreen({super.key});
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => const LoginScreen(),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final country = useState<Country>(Country.worldWide);
    final size = MediaQuery.of(context).size;
    final phoneController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text("Enter your phone number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("GuffGaff needs to verify your phone number"),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      showCountryPicker(
                          context: context,
                          onSelect: (Country countries) {
                            country.value = countries;
                            print(country.value.phoneCode);
                          });
                    },
                    child: const Center(
                      child: Text("Pick Country"),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (country.value.phoneCode.isNotEmpty)
                        Text("+${country.value.phoneCode}"),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Please enter your number";
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration:
                              const InputDecoration(hintText: "Phone number"),
                        ),
                      ),
                    ]),
              ],
            ),
            SizedBox(
                width: 100,
                child: CustomButton(
                    text: "NEXT",
                    onPressed: () {
                      final phoneNo = phoneController.text.trim();
                      print("ph no is  +${country.value.phoneCode}$phoneNo");
                      if (country.value.phoneCode.isNotEmpty) {
                        ref.read(authControllerProvider).signInWithPhone(
                            context: context,
                            phoneNumber: "+${country.value.phoneCode}$phoneNo");
                      } else {
                        showSnackBar(
                            context: context,
                            content: "Fill out all the fields");
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
