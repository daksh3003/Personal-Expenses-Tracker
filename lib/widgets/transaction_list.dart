import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                const Text(
                  'No transactions here. Add one',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Container(
                            padding: EdgeInsets.all(7),
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Theme.of(context).primaryColor,
                      //     width: 2,
                      //   ),
                      // ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactions[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                            DateFormat.yMMMMd()
                                .format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: MediaQuery.of(context).size.width > 450
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: FlatButton.icon(
                                onPressed: () {
                                  deleteTransaction(transactions[index].id);
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text('Delete Transaction'),
                                textColor: Theme.of(context).errorColor,
                              ),
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  deleteTransaction(transactions[index].id);
                                },
                                color: Theme.of(context).errorColor,
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                    )
                  ],
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
