import 'package:flutter/material.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search your Student now ',
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 8,
                          endIndent: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                width: 280,
                color: Colors.redAccent,
                child: const Column(
                  children: [],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 580,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 180,
                      childAspectRatio: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 10,
                      maxCrossAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        // height: 89,
                        // width: 299,
                        color: Colors.amber,
                      );
                    },
                    itemCount: 4,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
