import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/auth/data/model/remoteUser.dart';
import 'auth_remote_data_source.dart';
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthRemoteDataSourceImpl(this._auth,this._firestore);

  @override
  Future<ApiResult<RemoteUser>> signUp(String email,String password,String name,String phoneNumber,String avatarUrl,)async{
    try {
      final credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        if (credential.user == null) {
          throw Exception('Failed to create user');
      }
        final remoteUser=RemoteUser(
          id: credential.user!.uid,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          avatarPath: avatarUrl
        );
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(remoteUser.toJson());
      return SuccessApiResult(remoteUser);
    } on Exception catch (e) {
      return ErrorApiResult(ServerErrors(errorMessage: e.toString()));
    }
  
  }
  @override
  Future<ApiResult<void>>login(String email,String pass)async{
try {
  await _auth.signInWithEmailAndPassword(email: email, password: pass);
  return SuccessApiResult(null);

} on FirebaseException catch (e) {
  return ErrorApiResult(ServerErrors(errorMessage: e.toString()));

}


  }
  @override
  Future<ApiResult<void>>logout()async{
    try {
      await _auth.signOut();
      return SuccessApiResult(null);
    } on FirebaseException catch (e) {
     return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }
  @override
  Future<ApiResult<RemoteUser>>getCurrentUser()async{
    try {
      var firebaseUser= _auth.currentUser;
      if (firebaseUser == null) {
        return ErrorApiResult(UnKnownErrors(errorMessage: "No user is currently signed in"));
      }
      var userCollection = _firestore.collection("users");
      DocumentSnapshot snapshot = await userCollection.doc(firebaseUser.uid).get();
      Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
      var currentUser=RemoteUser.fromJson(json);
      return SuccessApiResult(currentUser);
    } on FirebaseException catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.message??""));
    }
  }
}