import 'package:flutter/material.dart';
import 'package:todo_list_app/form_dialog.dart';
import 'package:todo_list_app/service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> todoData = ['Beli Rumah'];
  TextEditingController controller = TextEditingController();

  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Todo List App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: service.fetchDataModelList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return ListView.builder(
              itemCount: todoData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Hapus ${todoData[index]}'),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      todoData.removeAt(index);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                todoData[index],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.text = todoData[index];
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => FormDialog(
                                          isEdit: true,
                                          onPressed: () {
                                            setState(() {
                                              todoData[index] = controller.text;
                                            });
                                            controller.clear();
                                            Navigator.pop(context);
                                          },
                                          controller: controller,
                                        ),
                                  );
                                },
                                child: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 75,
        width: 75,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => FormDialog(
                    controller: controller,
                    onPressed: () {
                      setState(() {
                        todoData.add(controller.text);
                      });
                      controller.clear();
                      Navigator.pop(context);
                    },
                  ),
            );
          },
          child: Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
