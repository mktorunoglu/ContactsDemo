import '../controllers/controller_main.dart';
import '../enums/service_types.dart';
import '../interfaces/interface_user.dart';
import '../services/api/service_api_user.dart';
import '../services/firebase/service_firebase_user.dart';

class ServiceHelper {
  ServiceHelper._init();
  static final ServiceHelper instance = ServiceHelper._init();

  IUser user({ServiceType? service}) => {
        ServiceType.api: UserApiService.instance,
        ServiceType.firebase: UserFirebaseService.instance,
      }[service ?? MainController.instance.service]!;
}
