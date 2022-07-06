// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_bloc_demo/module/home/view/bloc/user_bloc.dart';
import 'package:full_bloc_demo/module/home/view/bloc/user_event.dart';
import 'package:full_bloc_demo/module/home/view/bloc/user_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserBloc newBloc = UserBloc();
  Completer refreshCompleter = Completer();

  Future<void> handleRefresh() async {
    refreshCompleter = Completer();
    newBloc.add((RefreshEvent()));
    await refreshCompleter.future;
  }

  void pagination() {
    newBloc.scrollController.addListener(() {
      if (newBloc.scrollController.position.pixels ==
          newBloc.scrollController.position.maxScrollExtent) {
        newBloc.add(GetUserEvent(false));
      }
    });
  }

  @override
  void initState() {
    pagination();
    newBloc.add(GetUserEvent(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BLOC"),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => newBloc,
          child: BlocListener<UserBloc, UserState>(listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }, child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                refreshCompleter.complete;
                return RefreshIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                    onRefresh: () async {
                      newBloc.tempList.clear;
                      handleRefresh();
                    },
                    child: ListView.separated(
                      controller: newBloc.scrollController,
                      itemCount: state.listOfUsers.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.listOfUsers.length &&
                            newBloc.moreDataAvailable) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 160, bottom: 10, right: 160, top: 10),
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        var FirstName = state.listOfUsers[index].firstName;
                        var LastName = state.listOfUsers[index].lastName;
                        return Column(
                          children: [
                            Container(
                              height: 80,
                              decoration:
                                  BoxDecoration(color: Colors.grey[100]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: ListTile(
                                  trailing: Icon(Icons.star),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.grey[800],
                                    child: Text(
                                      "${FirstName![0]}${LastName![0]}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  title: Text("${FirstName} ${LastName}"),
                                  subtitle: Text(
                                    state.listOfUsers[index].email ?? '',
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ));
              }
              return Container();
            },
          )),
        ),
      ),
    );
  }
}
