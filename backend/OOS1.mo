import OS1 = "OS1";
import Order "mo:base/Order";

module OOSet1 {

  public class Set<T>(cmp : (T, T) -> Order.Order) {
    
    private var state = OS1.empty<T>();

    public func add(v : T) {
      state := OS1.add<T>(state, cmp, v);
    };

    public func mem(v : T) : Bool {
      OS1.mem(state, cmp, v);
    };

    public func share() : OS1.Set<T> {
      return state;
    };

    public func unshare(newState : OS1.Set<T>) {
      state := newState;
    };

  };

};
