import 'package:finance/Entities/avatar.dart';
import 'package:finance/Providers/LogInManagement.dart';
import 'package:finance/Providers/ThemeManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../EntityServices/AvatarService.dart';
import '../../EntityServices/userService.dart';
import '../../database.dart';

class AvatarDialog extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  final PageController controller;

  AvatarDialog(this.url, this.height, this.width, this.controller);

  @override
  State<AvatarDialog> createState() => _AvatarDialogState();
}

class _AvatarDialogState extends State<AvatarDialog> {
  Avatar? selected;
  int? selectedIndex;
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeManagement>().background,
      body: Column(
        children: [
          Container(
            height: 200,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: (widget.height - 48) / 4,
                    width: (widget.width - 48) / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("http://$localhost/" +
                              (selected?.avatar_url ?? widget.url)),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                selected == null
                    ? Container()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Currently Chosen",
                                style: TextStyle(
                                    color: context
                                        .watch<ThemeManagement>()
                                        .allTextColorOpacity5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ...[
                                ["Gender", "${selected?.gender}"],
                                [
                                  "Age Estimation",
                                  "${selected?.minAgeEstimation} - ${selected?.maxAgeEstimation}"
                                ],
                                [
                                  "Id",
                                  "#AV${selected?.avatarID.toString().padLeft(4, "0")}"
                                ]
                              ]
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            e[0],
                                            style: TextStyle(
                                                color: context
                                                    .watch<ThemeManagement>()
                                                    .allTextColor),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            e[1],
                                            style: TextStyle(
                                                color: context
                                                    .watch<ThemeManagement>()
                                                    .allTextColorOpacity5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
          Divider(
            color: context.watch<ThemeManagement>().allTextColorOpacity5,
          ),
          Expanded(
            child: FutureBuilder(
                future: AvatarService().fetchAvatars(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Avatar> avatars = snapshot.data;
                    return GridView.count(
                      crossAxisCount: 3,
                      children: avatars.asMap().entries.map((e) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = e.key;
                              selected = e.value;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: e.key == selectedIndex
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                              ),
                              child: Container(
                                width: (widget.width - 48) / 3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage("http://$localhost/" +
                                          e.value.avatar_url),
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
          Container(
            height: 60,
            color: selected == null ? Colors.blueGrey : Colors.green,
            child: MaterialButton(
              onPressed: () {
                if (selected != null && !isDisabled) {
                  isDisabled = true;
                  UserService()
                      .changeAvatar(
                          avatarID: selected!.avatarID,
                          meUser: context.read<LogInManagement>().meUser!)
                      .then((value) {
                    isDisabled = false;

                    context.read<LogInManagement>().userChangeAvatar(selected!.avatar_url);
                    widget.controller.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  }).onError((error, stackTrace) {
                    isDisabled = false;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Unsuccessful")));
                  });
                }
              },
              child: Center(
                  child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
