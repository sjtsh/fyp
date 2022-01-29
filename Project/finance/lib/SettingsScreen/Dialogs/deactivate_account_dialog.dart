import 'package:flutter/material.dart';

class DeactivateAccountDialog extends StatelessWidget {
  const DeactivateAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: const Color(0xffFAFAFA),
          child: Container(
            height: 100,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Expanded(
                      child: Center(
                          child: Text("Are you sure you want to deactivate the account?"))),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MaterialButton(
                                onPressed: () {},
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MaterialButton(
                                onPressed: () {},
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
