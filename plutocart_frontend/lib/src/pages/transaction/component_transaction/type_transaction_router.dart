class TypeTransactionType {
  List<Map<String, dynamic>> listTypeTransaction = [];

  Map<String, dynamic> transactionDataIncome = {
    'transactiontype': 1,
    'typeName': 'Add Income',
  };
  Map<String, dynamic> transactionDataExpense = {
    'transactiontype': 2,
    'typeName': 'Add Expenses',
  };
  Map<String, dynamic> transactionDataGoal = {
    'transactiontype': 3,
    'typeName': 'Add Goal',
  };
  Map<String, dynamic> transactionDataDebt = {
    'transactiontype': 4,
    'typeName': 'Add Debt',
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
