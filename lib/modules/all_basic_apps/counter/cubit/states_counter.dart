abstract class CounterStates{}

class intiStateCounter extends CounterStates{}

class plusStateCounter extends CounterStates{
  final int count;
  plusStateCounter(this.count);
}

class minusStateCounter extends CounterStates{
  final int count;
  minusStateCounter(this.count);
}