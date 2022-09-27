import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/colors.dart';
import '../../../../shared/widgets/custom_top_bar.dart';
import '../sidebar/navigation_drawer.dart';
import 'category_model.dart';
import 'category_repository.dart';
import 'widgets/category_icon.dart';
import 'widgets/delete_category_alert.dart';
import 'widgets/grid_view_colors.dart';

class CategoryPage extends StatefulWidget {
  final Function? callback;
  final String avatar;
  final String name;
  const CategoryPage(
      {Key? key, this.callback, required this.avatar, required this.name})
      : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int? cor;
  String categoryName = "";
  int selectedIcon = Icons.more_horiz.codePoint;
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController? editCategoryNameController;

  var box = Hive.box('catBox');

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  void setCor(int c) {
    cor = c;
  }

  void setName(String name) {
    categoryName = name;
  }

  void setIcon(IconData iconData) {
    selectedIcon = iconData.codePoint;
  }

  void clear() {
    CategoryRepository repository = CategoryRepository(box);
    repository.clearCat();
  }

  @override
  Widget build(BuildContext context) {
    CategoryRepository repository = CategoryRepository(box);
    //repository.clearCat();
    List<dynamic> namesList = box.get("names") ?? [];

    return Scaffold(
      drawer: NavigationDrawer(
        callback: widget.callback,
        avatar: widget.avatar,
        name: widget.name,
      ),
      appBar: const CustomTopBar(title: 'Categorias'),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categorias customizadas',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 5),
              const Text(
                '5 disponíveis',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      namesList.isEmpty
                          ? const Text(
                              "Crie uma nova categoria",
                              style: TextStyle(color: Colors.white60),
                            )
                          : SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * .9,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemExtent: 80,
                                shrinkWrap: true,
                                itemCount: namesList.length,
                                itemBuilder: (context, index) {
                                  List<CategoryModel> categoriesList =
                                      repository.getCategories();
                                  return GestureDetector(
                                    onTap: () {
                                      String editCat = namesList[index];
                                      int editColor =
                                          categoriesList[index].color;
                                      int editIcon = categoriesList[index].icon;
                                      showModalBottomSheet<void>(
                                        backgroundColor: const Color.fromARGB(
                                            255, 20, 20, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setModalState) =>
                                                Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              width: 3,
                                                              height: 25,
                                                              color: Color(
                                                                  editColor)),
                                                          const SizedBox(
                                                              width: 20),
                                                          Text(
                                                            editCat,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        192,
                                                                        190,
                                                                        190),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        IconData(editIcon,
                                                            fontFamily:
                                                                'MaterialIcons'),
                                                        color: Color(editColor),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // categoryNameController.clear();
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          backgroundColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  20,
                                                                  20,
                                                                  20),
                                                          content:
                                                              TextFormField(
                                                                  initialValue:
                                                                      editCat,
                                                                  controller:
                                                                      editCategoryNameController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          188,
                                                                          31,
                                                                          70),
                                                                    )),
                                                                    label: const Text(
                                                                        "Categoria"),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                  )),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                categoryName =
                                                                    editCategoryNameController!
                                                                        .text;
                                                                // debugPrint(
                                                                //     categoryNameController
                                                                //         .text);
                                                                // setName(
                                                                //     categoryNameController
                                                                //         .text);

                                                                return Navigator
                                                                    .pop(
                                                                        context,
                                                                        'ok');
                                                              },
                                                              child: const Text(
                                                                  'Salvar'),
                                                            ),
                                                          ],
                                                          actionsAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                        ),
                                                      );
                                                    },

                                                    //debugPrint("Nome da categoria");

                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.edit_outlined,
                                                          color: Color.fromARGB(
                                                              255, 95, 94, 94),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          'Alterar o nome da categoria',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      192,
                                                                      190,
                                                                      190),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.interests_sharp,
                                                          color: Color.fromARGB(
                                                              255, 95, 94, 94),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          'Alterar o icone da categoria',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      192,
                                                                      190,
                                                                      190),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            SingleChildScrollView(
                                                          child: AlertDialog(
                                                            scrollable: true,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25.0))),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    20,
                                                                    20,
                                                                    20),
                                                            content: Column(
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                    "Icone da categoria",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Colors
                                                                            .white60),
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                ),
                                                                Center(
                                                                  child:
                                                                      SizedBox(
                                                                    height: 280,
                                                                    width: 450,
                                                                    child: GridView
                                                                        .count(
                                                                      shrinkWrap:
                                                                          true,
                                                                      crossAxisCount:
                                                                          4,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(Colors.yellow.value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Colors.amber,
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 255, 154, 59).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 255, 154, 59),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 255, 85, 59).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 255, 85, 59),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 255, 59, 92).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 255, 59, 92),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 255, 59, 167).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 255, 59, 167),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 255, 59, 216).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 255, 59, 216),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 229, 59, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 229, 59, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 173, 59, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 173, 59, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 118, 59, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 118, 59, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 79, 59, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 79, 59, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 59, 101, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 59, 101, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 59, 173, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 59, 173, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 59, 232, 255).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 59, 232, 255),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 59, 255, 216).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 59, 255, 216),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 59, 255, 154).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 59, 255, 154),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 59, 255, 88).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 59, 255, 88),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 92, 255, 59).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 92, 255, 59),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 50, 182, 24).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 50, 182, 24),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 97, 162, 37).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 97, 162, 37),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setModalState(() {
                                                                                setCor(const Color.fromARGB(255, 159, 178, 35).value);
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.circle,
                                                                              color: Color.fromARGB(255, 159, 178, 35),
                                                                              size: 55,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                )
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  debugPrint(
                                                                      categoryNameController
                                                                          .text);
                                                                  setName(
                                                                      categoryNameController
                                                                          .text);

                                                                  return Navigator
                                                                      .pop(
                                                                          context,
                                                                          'ok');
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Fechar',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white60),
                                                                ),
                                                              ),
                                                            ],
                                                            actionsAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons
                                                              .color_lens_sharp,
                                                          color: Color.fromARGB(
                                                              255, 95, 94, 94),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          'Alterar a cor da categoria',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              //color: Color.fromARGB(
                                                              //  255, 192, 190, 190),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  DeleteCategoryAlert(
                                                    editCat: editCat,
                                                    setState: () {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: CategoryIcon(
                                        name: categoriesList[index].name,
                                        entries: index,
                                        icon: IconData(
                                            categoriesList[index].icon,
                                            fontFamily: 'MaterialIcons'),
                                        color:
                                            Color(categoriesList[index].color)),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Categorias padrão',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 5),
              const Text(
                'Editável para usuários premium',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 40),
              CarouselSlider(
                options: CarouselOptions(
                  disableCenter: false,
                  viewportFraction: 0.28,
                  height: 100,
                  enableInfiniteScroll: false,
                  padEnds: false,
                ),
                items: <Widget>[
                  CategoryIcon(
                    entries: 4,
                    name: "Esportes",
                    icon: Icons.directions_bike_rounded,
                    color: Colors.blue,
                  ),
                  CategoryIcon(
                    entries: 4,
                    name: "Perdidos",
                    icon: Icons.block,
                    color: Colors.red,
                  ),
                  CategoryIcon(
                    entries: 4,
                    name: "Nutrição",
                    icon: Icons.restaurant_menu,
                    color: Colors.amber,
                  ),
                  CategoryIcon(
                    entries: 4,
                    name: "Saúde",
                    icon: Icons.healing_rounded,
                    color: Colors.white,
                  ),
                  CategoryIcon(
                    entries: 4,
                    name: "Estudos",
                    icon: Icons.school,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 188, 31, 70),
                        minimumSize: const Size(300, 30)),
                    onPressed: () {
                      selectedIcon = Icons.more_horiz.codePoint;
                      setName("Nome da categoria");
                      setCor(
                        const Color.fromARGB(255, 188, 31, 70).value,
                      );
                      showModalBottomSheet<void>(
                        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setModalState) => Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: 3,
                                              height: 25,
                                              color: Color(cor!)),
                                          const SizedBox(width: 20),
                                          Text(
                                            categoryName,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 192, 190, 190),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        IconData(selectedIcon,
                                            fontFamily: 'MaterialIcons'),
                                        color: Color(cor!),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      categoryNameController.clear();
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          backgroundColor: const Color.fromARGB(
                                              255, 20, 20, 20),
                                          content: TextFormField(
                                              controller:
                                                  categoryNameController,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    188,
                                                                    31,
                                                                    70))),
                                                label: const Text("Categoria"),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              )),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                debugPrint(
                                                    categoryNameController
                                                        .text);
                                                setName(categoryNameController
                                                    .text);

                                                return Navigator.pop(
                                                    context, 'ok');
                                              },
                                              child: const Text('Salvar'),
                                            ),
                                          ],
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                      );
                                    },

                                    //debugPrint("Nome da categoria");

                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.edit_outlined,
                                          color:
                                              Color.fromARGB(255, 95, 94, 94),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Escolha o nome da categoria',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 192, 190, 190),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            SingleChildScrollView(
                                          child: AlertDialog(
                                            scrollable: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10.0),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 20, 20, 20),
                                            content: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Icone da categoria",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white60),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    height: 280,
                                                    width: 450,
                                                    child: GridView.count(
                                                      shrinkWrap: true,
                                                      crossAxisCount: 4,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon =
                                                                  Icons.block
                                                                      .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons.block,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .school_rounded
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .school_rounded,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .directions_bike
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_bike,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .local_activity
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .local_activity,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon =
                                                                  Icons.message
                                                                      .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons.message,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .medication
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons.mediation,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .restaurant_menu
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .restaurant_menu,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .home_rounded
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .home_rounded,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .landscape_rounded
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .landscape_rounded,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .brush_rounded
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .brush_rounded,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .attach_money
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .attach_money,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .more_horiz
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons.more_horiz,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .access_time_rounded
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .access_time_rounded,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .access_alarm
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .access_alarm,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .notifications
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .notifications,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon =
                                                                  Icons.hotel
                                                                      .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons.hotel,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .directions_walk
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_walk,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon =
                                                                  Icons.pool
                                                                      .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons.pool,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .sports_baseball
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .sports_baseball,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .directions_run
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_run,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .sports_football
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .sports_football,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              selectedIcon = Icons
                                                                  .sports_volleyball_sharp
                                                                  .codePoint;
                                                              Navigator.pop(
                                                                  context);
                                                              setModalState(
                                                                  () {});
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .sports_volleyball_sharp,
                                                              size: 45,
                                                              color: Colors
                                                                  .white60,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  debugPrint(
                                                      categoryNameController
                                                          .text);
                                                  setName(categoryNameController
                                                      .text);

                                                  return Navigator.pop(
                                                      context, 'ok');
                                                },
                                                child: const Text(
                                                  'Fechar',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white60),
                                                ),
                                              ),
                                            ],
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.interests_sharp,
                                          color:
                                              Color.fromARGB(255, 95, 94, 94),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Escolha o icone da categoria',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 192, 190, 190),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            SingleChildScrollView(
                                          child: AlertDialog(
                                            scrollable: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10.0),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 20, 20, 20),
                                            content: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Cor da categoria",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white60),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    height: 280,
                                                    width: 450,
                                                    //TODO aqui
                                                    child: GridViewColors(
                                                      setModalState: (p0) {
                                                        setModalState(() {
                                                          setCor(p0);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  debugPrint(
                                                      categoryNameController
                                                          .text);
                                                  setName(categoryNameController
                                                      .text);

                                                  return Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Fechar',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white60),
                                                ),
                                              ),
                                            ],
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.color_lens_sharp,
                                          color:
                                              Color.fromARGB(255, 95, 94, 94),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Escolha a cor da categoria',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              //color: Color.fromARGB(
                                              //  255, 192, 190, 190),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        var cat = CategoryModel(
                                            name: categoryName,
                                            icon: selectedIcon,
                                            color: cor!);
                                        repository.saveCategory(
                                            categoryName, cat);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'CRIAR CATEGORIA',
                                        style: TextStyle(
                                            //color: Colors.pink,

                                            color: Color(cor!),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(" NOVA CATEGORIA")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
