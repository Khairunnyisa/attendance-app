import 'package:attendance_app/ui/attend/attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // makesure mau kembali atau enggak, takutnya ada data yg belum kesimpen
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didpop) {
        if (didpop) {
          return;
        }
        _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Attendance()));
                      },
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('/assets/images/attend.png'),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Attendace Report",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
        // biar ada yes or no nya pas muncul popup
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Information",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Do you want to exit?",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                TextButton(
                    // gajadi hapus stack (gajadi keluar)
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                TextButton(
                    // untuk keluar dari aplikasi
                    onPressed: () => SystemNavigator.pop(),
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ))
              ],
            )));
  }
}
