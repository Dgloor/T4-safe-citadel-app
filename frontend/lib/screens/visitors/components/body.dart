import 'package:flutter/material.dart';
import 'package:safecitadel/utils/Persistence.dart';
import '../../../size_config.dart';
import '../../../utils/widgetQR.dart';
import '../../home/components/welcome_banner.dart';
import '../../home/home_screen.dart';
import '../components/visitsPending.dart';
import '../components/visitsRegistered.dart';
import '../components/visitsCancelled.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _Body();
}

void errorGetVisits(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Problemas para obtener visitas."),
      backgroundColor: Colors.red,
    ),
  );
}

List<dynamic> visitasPendientes = [];
List<dynamic> visitasIngresadas = [];
List<dynamic> visitasAnuladas = [];

///Widget   principal
class _Body extends State<Body> with TickerProviderStateMixin {
  bool isGuard = false;
  final apiClient = ApiGlobal.api;
  @override
  void initState() {
    super.initState();
    _loadData();
    _loadisGuard();
  }

  Future<void> _loadData() async {
    try {
      apiClient.fillVisits().then((updatedVisits) {
        setState(() {
          visitasPendientes = updatedVisits['pending']!;
          visitasIngresadas = updatedVisits['registered']!;
          visitasAnuladas = updatedVisits['cancelled']!;
        });
      }).catchError((error) {
        errorGetVisits(context);
      });
    } catch (error) {
      errorGetVisits(context);
    }
  }

  Future<void> _loadisGuard() async {
    try {
      bool guard = await apiClient.isGuard();
      setState(() {
        isGuard = guard;
      });
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadData(); // Reinicia la carga de datos cada vez que el widget se actualiza
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(length: isGuard ? 2 : 3, vsync: this);
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.green,
        color: Colors.white,
        displacement: 30.0,
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: getProportionateScreenWidth(450),
                  child: Column(
                    children: [
                      const WelcomeBanner(),
                      const SizedBox(height: 25),
                      Container(
                        child: TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 33, 128, 72),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          tabs: <Tab>[
                            Tab(text: "Ingresada"),
                            Tab(text: "Pendiente"),
                            if (!isGuard) Tab(text: "Anulada"),
                          ],
                          labelColor: const Color.fromARGB(255, 214, 221, 214),
                          unselectedLabelColor:
                              const Color.fromARGB(255, 81, 173, 85),
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: getProportionateScreenWidth(500),
                        height: getProportionateScreenHeight(450),
                        child: SizedBox(
                            height: getProportionateScreenHeight(450),
                            child: TabBarView(
                                controller: tabController,
                                children: [
                                  ContainerVisitaIngresada(
                                      visitasIngresadas: visitasIngresadas),
                                  ContainerVisitaPendiente(
                                      visitasPendientes: visitasPendientes),
                                  if (!isGuard)
                                    ContainerVisitaAnulada(
                                        visitasAnuladas: visitasAnuladas)
                                ])),
                      ),
                    ],
                  ),
                )
              ],
            )),
        onRefresh: _loadData,
      ),
    );
  }
}
