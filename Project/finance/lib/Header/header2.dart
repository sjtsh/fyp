import 'package:countup/countup.dart';
import 'package:finance/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/LogInManagement.dart';
import '../Providers/ThemeManagement.dart';
import '../database.dart';

class Header2 extends StatefulWidget {
  const Header2({Key? key}) : super(key: key);

  @override
  State<Header2> createState() => _Header2State();
}

class _Header2State extends State<Header2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: context.watch<ThemeManagement>().containerColors,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Icon(
                Icons.arrow_back_ios,
                color: context.watch<ThemeManagement>().allIconColor,
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: context.watch<ThemeManagement>().logoBgColorOpacity5,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: context.watch<ThemeManagement>().logoBgColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage("http://$localhost/" +
                              context
                                  .watch<LogInManagement>()
                                  .meUser!
                                  .avatarURL),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                // child: Text(
                //   "\$${addCommas(meUser?.bankBalance ?? 0)}",
                //   style: TextStyle(
                //     color: const Color(0xffC31FE6).withOpacity(0.7),
                //     fontSize: 16,
                //   ),
                // ),

                child: Countup(
                  begin: 0,
                  end:
                      context.watch<LogInManagement>().meUser?.bankBalance ?? 0,
                  duration: Duration(milliseconds: 200),
                  separator: ',',
                  prefix: "\$",
                  style: TextStyle(
                    color: context
                        .watch<ThemeManagement>()
                        .headerTextColorOpacity7,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
