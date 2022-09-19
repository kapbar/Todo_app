import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/todo_screen/shop_page/shop_todo_form_model.dart';

class ShopTodoForm extends StatefulWidget {
  const ShopTodoForm({super.key});

  @override
  State<ShopTodoForm> createState() => _ShopTodoFormState();
}

class _ShopTodoFormState extends State<ShopTodoForm> {
  final _model = ShopTodoFormModel();
  @override
  Widget build(BuildContext context) {
    return ShopTodoFormModelProvider(
      model: _model,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.3,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollcontroller) => SingleChildScrollView(
            controller: scrollcontroller,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -11,
                  child: Container(
                    height: 6,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 20),
                      const TextFieldWidget(),
                      const SizedBox(height: 10),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () => ShopTodoFormModelProvider.read(context)?.model.saveTodo(context),
                        child: const Icon(Icons.telegram, size: 40),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ShopTodoFormModelProvider.watch(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        hintText: 'Введите задачу...',
        hintStyle: const TextStyle(color: AppColors.secendary),
        errorText: model?.errorText,
      ),
      onEditingComplete: () => model?.saveTodo(context),
      onChanged: (value) => model?.todoName = value,
    );
  }
}