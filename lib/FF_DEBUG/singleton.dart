void singleTonTest() {
  TestB testA = TestB.instance;
  TestB testB = TestB.instance;

  print(testA.hashCode);
  print(testB.hashCode);
}

// 생성자로 싱글톤
class TestA {
  TestA._internal() {
    a = 2;
  }

  static final TestA _sharedInstance = TestA._internal();

  factory TestA() {
    return _sharedInstance;
  }

  int a = 10;
}

// static field 로 싱글톤 : 헷갈림 방지를 위해 이것을 주로 사용
class TestB {
  TestB._privateConstructor() {
    b = 3;
  }

  static final TestB instance = TestB._privateConstructor();

  int b = 2;
}
