import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header2 extends StatelessWidget {
  const Header2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
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
                const Icon(
                  Icons.arrow_back_ios,
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xff5A6FF0).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xff5A6FF0),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/me.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "\$150",
                    style: TextStyle(
                      color: const Color(0xffC31FE6).withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
