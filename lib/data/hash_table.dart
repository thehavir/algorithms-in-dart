/// The default constructor of `Map` class in dart, returns a `HashMap` that it
/// is a hash table.
class Grocery {
  final Map<String, int> _fruitPriceList = <String, int>{};

  void _initializeHashMap() {
    _fruitPriceList['apple'] = 23000;
    _fruitPriceList['peach'] = 45000;
    _fruitPriceList['cherry'] = 30000;
    _fruitPriceList['pear'] = 38000;
    _fruitPriceList['melon'] = 10000;
    _fruitPriceList['cucumber'] = 12000;
  }

  int _getFruitPrice(String fruit) => _fruitPriceList[fruit] ?? 0;

  void _setFruitPrice({
    required String fruit,
    required int price,
  }) {
    _fruitPriceList[fruit] = price;
  }
}
