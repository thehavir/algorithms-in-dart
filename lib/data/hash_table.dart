import 'dart:collection';

class Grocery {
  final HashMap<String, int> fruitPriceList = HashMap<String, int>();

  void initializeHashMap() {
    fruitPriceList['apple'] = 23000;
    fruitPriceList['peach'] = 45000;
    fruitPriceList['cherry'] = 30000;
    fruitPriceList['pear'] = 38000;
    fruitPriceList['melon'] = 10000;
    fruitPriceList['cucumber'] = 12000;
  }

  int getFruitPrice(String fruit) {
    return fruitPriceList[fruit] ?? 0;
  }

  void setFruitPrice({
    required String fruit,
    required int price,
  }) {
    fruitPriceList[fruit] = price;
  }
}
