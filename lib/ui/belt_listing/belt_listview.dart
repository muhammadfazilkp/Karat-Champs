import 'package:flutter/material.dart';
import 'package:karatte_kid/ui/belt_listing/belt_listviewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class BeltSelector extends StatelessWidget {
  final Function(String) onSelected;
  final String? selectedBelt;

  const BeltSelector({
    Key? key,
    required this.onSelected,
    required this.selectedBelt,
  }) : super(key: key);

  final Map<String, Color> beltColors = const {
    'White': Color.fromARGB(255, 161, 158, 158),
    'Yellow': Colors.yellow,
    'Orange': Colors.orange,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Brown': Colors.brown,
    'Black': Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BeltListviewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const    SizedBox(height: 10,),
              const Text(
                'Select Belt',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.beltModel?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final belt = viewModel.beltModel?.data?[index];
                    final beltName = belt?.name ?? 'Unknown';
                    final color = beltColors[beltName] ?? Colors.grey;

                    return ListTile(
                      leading: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          color,
                          BlendMode.modulate,
                        ),
                        child: Image.asset(
                          'assets/images/belt.png',
                          color: color,
                          width: 40,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(beltName),
                      trailing: Radio<String>(
                        value: beltName,
                        groupValue: selectedBelt,
                        onChanged: (value) {
                          if (value != null) {
                            onSelected(value);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      onTap: () {
                        onSelected(beltName);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => BeltListviewmodel(
        apiservice: Provider.of(context, listen: false),
      ),
    );
  }
}
