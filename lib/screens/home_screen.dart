import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_one/provider/cat_provider.dart';

import '../widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      fetchCatImage(Provider.of<CatProvider>(context, listen: false));
    });
    super.initState();
  }

  void fetchCatImage(CatProvider provider) {
    provider.getCatImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CatProvider provider = Provider.of<CatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("C A T S"),
        actions: [
          IconButton(
            onPressed: () {
              fetchCatImage(provider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(width: 8, color: Colors.black),
              ),
              child: provider.loading
                  ? const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : provider.message == "success"
                      ? Image.network("${provider.cat?.url}")
                      : Center(
                          child: Text(
                            provider.message,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                        ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Visibility(
                visible: provider.isNorError,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: "ID",
                      value: "${provider.cat?.id}",
                    ),
                    CustomText(
                      text: "Height",
                      value: "${provider.cat?.height}",
                    ),
                    CustomText(
                      text: "Width",
                      value: "${provider.cat?.width}",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
