import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/data/model/remoteUser.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';
@injectable
class AuthMapper {
  UserEntity getUser(RemoteUser remoteUser)=> UserEntity(id: remoteUser.id??"", email:remoteUser.email??"" , name: remoteUser.name??"", phoneNumber: remoteUser.phoneNumber??"",avatarUrl: remoteUser.avatarPath??"");
}