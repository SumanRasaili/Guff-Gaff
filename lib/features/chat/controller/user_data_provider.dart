import 'package:guffgaff/features/auth/controller/auth_controller.dart';
import 'package:guffgaff/models/user_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserModel?>((ref) {
  return UserDataNotifier(ref: ref);
});

class UserDataNotifier extends StateNotifier<UserModel?> {
  UserDataNotifier({required this.ref}) : super(null) {
    getUserData();
  }
  Ref ref;

  Future<UserModel?> getUserData() async {
    final data = await ref.read(authControllerProvider).getUserData();
    state = data;
    // state = state?.copyWith(
    //     groupId: data?.groupId ?? [],
    //     isOnline: data?.isOnline ?? false,
    //     name: data?.name ?? "",
    //     phoneNumber: data?.phoneNumber ?? "",
    //     profilePic: data?.profilePic ?? "",
    //     uid: data?.uid ?? "");
    print("The state is $state");
    return state;
  }
}
