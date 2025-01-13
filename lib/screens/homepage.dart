import 'package:flutter/material.dart';
import 'package:time_api/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController zoneController = TextEditingController();

  String timeZone = "Asia/Colombo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: zoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("TimeZone")),
                ),
                const SizedBox(
                  height: 5,
                ),
                FilledButton(
                    onPressed: () {
                      if (zoneController.text.isNotEmpty) {
                        setState(() {
                          timeZone = zoneController.text;
                        });
                      }
                    },
                    child: const Text("Get Data")),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                    future: ApiServices().getTime(timeZone),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError || snapshot.data == null) {
                        // Handle the error or null data case here
                        return const Text("Error");
                      }

                      return Column(
                        children: List.generate(snapshot.data!.length,
                            (index) => Text(snapshot.data![index])),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
