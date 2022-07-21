import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybag/application/app/transaction/transaction_provider.dart';
import 'package:moneybag/application/auth/auth_provider.dart';
import 'package:moneybag/domain/app/transaction.dart';
import 'package:moneybag/presentation/auth/util/validation_rules.dart';

class TransactionDialogue extends HookConsumerWidget {
  const TransactionDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final profile = ref.watch(authProvider.select((value) => value.profile));
    final amountController = useTextEditingController();
    final note = useTextEditingController();

    final transactionType = useState('income');
    final selectedSource = useState('Cash');
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return AlertDialog(
      title: const Text('New transaction'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Source:',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<String>(
                        isDense: true,
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                            hintText: '0',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple))),
                        items: List<DropdownMenuItem<String>>.from(
                            profile.sources.map((e) => DropdownMenuItem<String>(
                                  value: e.name,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                )))
                          ..add(const DropdownMenuItem<String>(
                            value: '',
                            child: Text('Select one',
                                style: TextStyle(color: Colors.grey)),
                          )),
                        validator: ValidationRules.regular,
                        value: selectedSource.value,
                        onChanged: (source) {
                          selectedSource.value = source ?? '';
                        }))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amount:',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: 70,
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      validator: ValidationRules.money,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(5),
                          hintText: '0',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurple))),
                      enabled: true,
                    ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trans. type:',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<String>(
                        isDense: true,
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                            hintText: '0',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple))),
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'expense',
                            child: Text(
                              'Expense',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'income',
                            child: Text(
                              'Icome',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                        validator: ValidationRules.regular,
                        value: transactionType.value,
                        onChanged: (source) {
                          transactionType.value = source ?? '';
                        }))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: note,
              keyboardType: TextInputType.number,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Note',
                  hintText: 'Note (Optional)',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple))),
              enabled: true,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity.compact),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.watch(transactionProvider.notifier).submit(Transaction(
                        amount: double.parse(amountController.text),
                        time: DateTime.now(),
                        source: selectedSource.value,
                        transactionType: transactionType.value,
                        note: note.text));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
