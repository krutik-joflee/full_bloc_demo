import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_bloc_demo/module/home/view/bloc/user_event.dart';
import 'package:full_bloc_demo/module/home/view/bloc/user_state.dart';
import '../../../../core/api_service.dart';
import '../../model/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  bool moreDataAvailable = true;
  ScrollController scrollController = ScrollController();
  List<User> tempList = [];

  UserBloc() : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      tempList.addAll(await ApiServices.getUserDataFromApi(tempList.length));
      emit(UserLoaded(tempList));
    });
    on<RefreshEvent>((event, emit) async {
      tempList = await ApiServices.getUserDataFromApi(0);
      emit(UserLoaded(tempList));
    });
  }
}
