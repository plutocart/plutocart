class TypeTransactionType {
  List<Map<String, dynamic>> listTypeTransaction = [];

  Map<String, dynamic> transactionDataIncome = {
    'transactiontype': 1,
    'typeName': 'Transaction Income',
  };
  Map<String, dynamic> transactionDataExpense = {
    'transactiontype': 2,
    'typeName': 'Transaction Expenses',
  };
  Map<String, dynamic> transactionDataGoal = {
    'transactiontype': 3,
    'typeName': 'Transaction Goal',
  };
  Map<String, dynamic> transactionDataDebt = {
    'transactiontype': 4,
    'typeName': 'Transaction Debt',
  };

  // Private constructor
  TypeTransactionType._privateConstructor() {
    listTypeTransaction.add(transactionDataIncome);
    listTypeTransaction.add(transactionDataExpense);
    listTypeTransaction.add(transactionDataGoal);
    listTypeTransaction.add(transactionDataDebt);
    // Add other transactions if needed
  }

  // Instance of TypeTransactionType
  static final TypeTransactionType _instance =
      TypeTransactionType._privateConstructor();

  // Getter to access the instance
  factory TypeTransactionType() {
    return _instance;
  }
}
