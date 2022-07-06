import '../../model/user_model.dart';

class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> listOfUsers;

  UserLoaded(this.listOfUsers);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class RefreshUser extends UserState {
  final List<User> listOfUser;

  RefreshUser(this.listOfUser);
}
