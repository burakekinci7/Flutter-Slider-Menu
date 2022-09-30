import 'package:flutter/material.dart';

const TextStyle menuFontStyleMy = TextStyle(color: Colors.white, fontSize: 20);
const Color anaBackColor = Color(0xFF343442);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late double ekranYuk, ekranGen;
  bool menuAcikMi = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _menuAnimation;
  late Animation<Offset> _menuOfsetAni;
  final Duration _duration = const Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _menuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuOfsetAni = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuk = MediaQuery.of(context).size.height;
    ekranGen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: anaBackColor,
      body: SafeArea(
        child: Stack(
          children: [
            menuOlustur(context),
            dashBoardOLustur(context),
          ],
        ),
      ),
    );
  }

  menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOfsetAni,
      child: ScaleTransition(
        scale: _menuAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("DashBoard", style: menuFontStyleMy),
                SizedBox(height: 10),
                Text("Mesajlar", style: menuFontStyleMy),
                SizedBox(height: 10),
                Text("Utility Bills", style: menuFontStyleMy),
                SizedBox(height: 10),
                Text("Fund Transfer", style: menuFontStyleMy),
                SizedBox(height: 10),
                Text("Branches", style: menuFontStyleMy),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dashBoardOLustur(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: menuAcikMi ? 0.4 * ekranGen : 0,
      right: menuAcikMi ? 0.2 * -ekranGen : 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _animation,
        child: Material(
          borderRadius:
              menuAcikMi ? BorderRadius.all(Radius.circular(30)) : null,
          elevation: 8,
          color: anaBackColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Icon(Icons.menu, color: Colors.white),
                      onTap: () {
                        setState(() {
                          if (menuAcikMi) {
                            _controller.reverse();
                          } else {
                            _controller.forward();
                          }
                          menuAcikMi = !menuAcikMi;
                        });
                      },
                    ),
                    const Text("My Cards",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    const Icon(Icons.add_circle_outline, color: Colors.white),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 200,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        color: Colors.pink,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.purple,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.teal,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ],
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
