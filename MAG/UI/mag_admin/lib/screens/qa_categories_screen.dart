import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mag_admin/models/qa_category.dart';
import 'package:mag_admin/models/search_result.dart';
import 'package:mag_admin/providers/qa_category_provider.dart';
import 'package:mag_admin/utils/colors.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/utils/util.dart';
import 'package:mag_admin/widgets/circular_progress_indicator.dart';
import 'package:mag_admin/widgets/form_builder_text_field.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class QACategoriesScreen extends StatefulWidget {
  const QACategoriesScreen({super.key});

  @override
  State<QACategoriesScreen> createState() => _QACategoriesScreenState();
}

class _QACategoriesScreenState extends State<QACategoriesScreen> {
  late final QAcategoryProvider _qaCategoryProvider;
  late Future<SearchResult<QAcategory>> _qaCategoryFuture;
  final GlobalKey<FormBuilderState> _qaCategoryFormKey =
      GlobalKey<FormBuilderState>();

  final FocusNode _focusNode = FocusNode();
  int? categoryId;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _qaCategoryProvider = context.read<QAcategoryProvider>();
    _qaCategoryFuture = _qaCategoryProvider.get();

    _qaCategoryProvider.addListener(() {
      _reloadData();
    });

    super.initState();
  }

  void _reloadData() {
    if (mounted) {
      setState(() {
        _qaCategoryFuture = _qaCategoryProvider.get();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      showBackArrow: true,
      title: "QA Categories",
      child: Stack(
        children: [
          _buildQACategoryForm(context),
        ],
      ),
    );
  }

  Widget _buildQACategoryForm(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Palette.lightPurple.withOpacity(0.2)),
              color: Palette.darkPurple,
            ),
            padding: const EdgeInsets.all(16.0),
            width: 500.0,
            height: 550.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                FormBuilder(
                  key: _qaCategoryFormKey,
                  child: FutureBuilder<SearchResult<QAcategory>>(
                    future: _qaCategoryFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MyProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        var categoriesList = snapshot.data!.result;

                        return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (categoryId != null)
                                        ? IconButton(
                                            onPressed: () {
                                              if (mounted) {
                                                setState(() {
                                                  categoryId = null;
                                                  _qaCategoryFormKey
                                                      .currentState
                                                      ?.fields["name"]
                                                      ?.didChange("");
                                                });
                                              }
                                            },
                                            icon:
                                                const Icon(Icons.clear_rounded))
                                        : Container(),
                                    MyFormBuilderTextField(
                                      name: "name",
                                      labelText: "Category name",
                                      fillColor: Palette.disabledControl,
                                      width: 300,
                                      height: 50,
                                      borderRadius: 50,
                                      focusNode: _focusNode,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(
                                            errorText:
                                                "This field cannot be empty."),
                                      ]),
                                    ),
                                    const SizedBox(width: 5),
                                    GradientButton(
                                        onPressed: () {
                                          (categoryId == null)
                                              ? _addCategory(context)
                                              : _saveCategory(context);
                                        },
                                        width: 80,
                                        height: 30,
                                        borderRadius: 50,
                                        gradient: Palette.buttonGradient,
                                        child: (categoryId == null)
                                            ? const Text("Add",
                                                style: TextStyle(
                                                    color: Palette.white,
                                                    fontWeight:
                                                        FontWeight.w500))
                                            : const Text("Save",
                                                style: TextStyle(
                                                    color: Palette.white,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      children:
                                          _buildCategories(categoriesList),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategories(List<QAcategory> categoriesList) {
    return List.generate(
      categoriesList.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 35,
              padding: const EdgeInsets.all(5.4),
              decoration: BoxDecoration(
                  color: Palette.textFieldPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${categoriesList[index].name}",
                      style: const TextStyle(fontSize: 15)),
                  _buildPopupMenu(categoriesList[index]),
                ],
              )),
        );
      },
    );
  }

  Future<void> _addCategory(BuildContext context) async {
    try {
      if (_qaCategoryFormKey.currentState?.saveAndValidate() == true) {
        var request = Map.from(_qaCategoryFormKey.currentState!.value);
        await _qaCategoryProvider.insert(request);
        Future.delayed(Duration.zero, () {
          if (mounted) {
            showInfoDialog(
                context,
                const Icon(Icons.task_alt,
                    color: Palette.lightPurple, size: 50),
                const Text(
                  "Added successfully!",
                  textAlign: TextAlign.center,
                ));
          }
        });
      }
    } on Exception catch (e) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          showErrorDialog(context, e);
        }
      });
    }
  }

  Future<void> _saveCategory(BuildContext context) async {
    try {
      if (_qaCategoryFormKey.currentState?.saveAndValidate() == true) {
        var request = Map.from(_qaCategoryFormKey.currentState!.value);
        await _qaCategoryProvider.update(categoryId!, request: request);
        Future.delayed(Duration.zero, () {
          if (mounted) {
            showInfoDialog(
                context,
                const Icon(Icons.task_alt,
                    color: Palette.lightPurple, size: 50),
                const Text(
                  "Saved successfully!",
                  textAlign: TextAlign.center,
                ));
          }
        });
      }
    } on Exception catch (e) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          showErrorDialog(context, e);
        }
      });
    }
  }

  Widget _buildPopupMenu(QAcategory category) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: const Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      padding: EdgeInsets.zero,
      color: const Color.fromRGBO(50, 48, 90, 1),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightPurple.withOpacity(0.1),
            leading: buildEditIcon(24),
            title: const Text('Edit',
                style: TextStyle(color: Palette.lightPurple)),
            onTap: () {
              if (mounted) {
                setState(() {
                  categoryId = category.id;
                  _qaCategoryFormKey.currentState?.fields["name"]
                      ?.didChange(category.name);
                });
              }
            },
          ),
        ),
        PopupMenuItem<String>(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title:
                const Text('Delete', style: TextStyle(color: Palette.lightRed)),
            onTap: () {
              Navigator.pop(context);
              showConfirmationDialog(
                  context,
                  const Icon(Icons.warning_rounded,
                      color: Palette.lightRed, size: 55),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      "Are you sure you want to delete this category? This will delete any questions associated with it.",
                      textAlign: TextAlign.center,
                    ),
                  ), () async {
                _qaCategoryProvider.delete(category.id!);
              });
            },
          ),
        ),
      ],
    );
  }
}
