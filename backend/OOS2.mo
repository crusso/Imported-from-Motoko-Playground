import OS1 = "OS1";
import Order "mo:base/Order";

module OOSet1 {

  public class Set<T>(state : {var ref : OS1.Set<T> }, cmp : (T, T) -> Order.Order) {
    
    public func add(v : T) {
      state.ref := OS1.add<T>(state.ref, cmp, v);
    };

    public func mem(v : T) : Bool {
      OS1.mem(state.ref, cmp, v);
    };

  };

};
