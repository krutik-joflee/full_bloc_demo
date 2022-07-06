class UserEvent {}

class GetUserEvent extends UserEvent {
  final bool showLoader;

  GetUserEvent(this.showLoader);
}

class RefreshEvent extends UserEvent {}
