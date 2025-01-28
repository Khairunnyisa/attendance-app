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
                // parameter => semua yg dituliskan setelah kurung tutup "()"
                // _buildMenuItem(
                //   context,
                //   imagePath: 'assets/images/attend.png',
                //   label: 'Attendance Report',
                //   destination: Attendance(),
                // ),
                const SizedBox(
                  height: 40,
                ),
                // _buildMenuItem(
                //   context,
                //   imagePath: 'assets/images/permission.png',
                //   label: 'Attendance Report',
                //   destination: Attendance(),
                // ),
                const SizedBox(
                  height: 40,
                ),
                // _buildMenuItem(
                //   context,
                //   imagePath: 'assets/images/history.png',
                //   label: 'Attendance History',
                //   destination: Attendance(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String imagePath,
      required String label,
      required Widget destination}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Expanded(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => destination));
          },
          child: Column(
            children: [
              Image(
                image: AssetImage(imagePath),
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
            ],
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
                  title: const Text(
                    "Information",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    "Do you want to exit?",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                        // gajadi hapus stack (gajadi keluar)
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                    TextButton(
                        // untuk keluar dari aplikasi
                        onPressed: () => SystemNavigator.pop(),
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ))
                  ],
                )))

        /*default value ketika semua kode yg ada di blok alert dialog 
            tidak tereksekusi karena beberapa hal*/
        ??
        false;
  }
}
