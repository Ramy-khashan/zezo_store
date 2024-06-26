import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/storage_keys.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  getUserData() async {
    emit(SettingsInitial());

    email = await const FlutterSecureStorage().read(key: StorageKeys.userEmail);
    name = await const FlutterSecureStorage().read(key: StorageKeys.userName);
    image = await const FlutterSecureStorage().read(key: StorageKeys.userImage);
    isGoogleSign = await const FlutterSecureStorage()
                .read(key: StorageKeys.isGoogleSign) ==
            "false"
        ? false
        : true;
 
    emit(GetUserDataState());
  }

  String? email = "";
  bool? isGoogleSign = false;
  String? name = "";
  String? image =
      "https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d";
}
