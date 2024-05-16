import '../controllers/controller_main.dart';
import '../enums/service_types.dart';
import '../services/api/service_api_user.dart';
import '../services/firebase/service_firebase_user.dart';
import '../services/service_user.dart';

class ServiceHelper {
  ServiceHelper._init();
  static final ServiceHelper instance = ServiceHelper._init();

  UserService userService({ServiceType? service}) => {
        ServiceType.api: UserApiService.instance,
        ServiceType.firebase: UserFirebaseService.instance,
      }[service ?? MainController.instance.service]!;
}
