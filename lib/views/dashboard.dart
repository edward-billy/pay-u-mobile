import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'utils.dart';
import 'login.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    loadTotalPenjualan();
  }

  var totalPenjualanBulan = '';
  var totalPenjualan = '';
  var currentPage;
  var totalProdukTerjual = '';
  var totalPengunjung = '';

  Future<void> loadTotalPenjualan() async {
    var res = await Network().getData('/dashboard');
    print(res);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      setState(() {
        totalPenjualan = body['totalPenjualan']?.toString() ?? '';
        totalPenjualanBulan = body['totalPenjualanBulan']?.toString() ?? '';
        totalProdukTerjual = body['totalProdukTerjual']?.toString() ?? '';
        totalPengunjung = body['totalPengunjung']?.toString() ?? '';
        // print(body);
      });
    }
  }

  String formatCurrency(String value) {
    final intValue = int.tryParse(value);
    if (intValue != null) {
      final formatCurrency =
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
      return formatCurrency.format(intValue);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1194;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(39 * fem, 0 * fem, 26 * fem, 53 * fem),
      padding: EdgeInsets.fromLTRB(28.81 * fem, 19 * fem, 28 * fem, 20 * fem),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff313131),
        borderRadius: BorderRadius.circular(10 * fem),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // todkeA (0:885)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 19 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // todayssalesHPC (0:886)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                  child: Text(
                    'Summary Sales',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                Text(
                  // salessummaryPBL (0:887)
                  'Pay-U',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 10 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffa0a0a0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // cardsWFx (0:888)
            margin: EdgeInsets.fromLTRB(0.19 * fem, 0 * fem, 0 * fem, 0 * fem),
            width: double.infinity,
            height: 107 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // card1R82 (0:889)
                  padding: EdgeInsets.fromLTRB(
                      26.54 * fem, 10 * fem, 26.54 * fem, 10 * fem),
                  width: 230 * fem,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff585858),
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Container(
                    // details18YE (0:891)
                    width: 136 * fem,
                    height: 74 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // icon2dc (0:892)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 12 * fem),
                          width: 26 * fem,
                          height: 26 * fem,
                          child: Image.asset(
                            'assets/images/icon.png',
                            width: 26 * fem,
                            height: 26 * fem,
                          ),
                        ),
                        Container(
                          // body18wY (0:897)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rp1522519800H3k (0:898)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  formatCurrency(totalPenjualan),
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Text(
                                // totalsalesANS (0:899)
                                'Total Penjualan',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xffe7e7e7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20 * fem,
                ),
                Container(
                  // card2g5t (0:900)
                  padding: EdgeInsets .fromLTRB(
                      30.96 * fem, 11 * fem, 30.96 * fem,22 * fem),
                  width: 230 * fem,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff585858),
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Container(
                    // details2awx (0:902)
                    width: 69 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // iconwGi (0:903)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 12 * fem),
                          width: 26 * fem,
                          height: 26 * fem,
                          child: Image.asset(
                            'assets/images/icon-fbt.png',
                            width: 26 * fem,
                            height: 26 * fem,
                          ),
                        ),
                        Container(
                          // body2SDU (0:908)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // b6N (0:909)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  formatCurrency(totalPenjualanBulan),
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Text(
                                // totalorderhfC (0:910)
                                'Penjualan Bulanan',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125 * ffem / fem,
                                  color: const Color(0xffe7e7e7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20 * fem,
                ),
                Container(
                  // card3EQE (0:911)
                  padding: EdgeInsets.fromLTRB(
                      30.96 * fem, 11 * fem, 30.96 * fem, 22 * fem),
                  width: 230 * fem,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff585858),
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Container(
                    // details3ZBc (0:913)
                    width: 62 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // iconW6r (0:914)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 12 * fem),
                          width: 26 * fem,
                          height: 26 * fem,
                          child: Image.asset(
                            'assets/images/icon-fHg.png',
                            width: 26 * fem,
                            height: 26 * fem,
                          ),
                        ),
                        Container(
                          // body3DGA (0:917)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // yWE (0:918)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  '$totalProdukTerjual',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125 * ffem / fem,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Text(
                                // productsoldVjU (0:919)
                                'Produk Terjual',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125 * ffem / fem,
                                  color: const Color(0xffe7e7e7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20 * fem,
                ),
                Container(
                  // card4zgE (0:920)
                  padding: EdgeInsets.fromLTRB(
                      30.96 * fem, 11 * fem, 30.96 * fem, 22 * fem),
                  width: 230 * fem,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff585858),
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Container(
                    // details4UrJ (0:922)
                    width: 72 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // icon1rE (0:923)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 12 * fem),
                          width: 26 * fem,
                          height: 26 * fem,
                          child: Image.asset(
                            'assets/images/icon-4WA.png',
                            width: 26 * fem,
                            height: 26 * fem,
                          ),
                        ),
                        Container(
                          // body4XZg (0:928)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // ghU (0:929)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  '$totalPengunjung',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Text(
                                // newcustomerQ7g (0:930)
                                'Total Pengunjung',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xffe7e7e7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      localStorage.remove('user');
      localStorage.remove('token');

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }
}
