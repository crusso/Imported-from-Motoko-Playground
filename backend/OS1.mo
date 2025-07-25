import Order "mo:base/Order"

module OrderedSet1 {

   public type Set<T> = ?(T, Set<T>);

   public func empty<T>() : Set<T> = null;

   public func add<T>(s : Set<T>, cmp : (T, T) -> Order.Order, v : T) : Set<T> {
      switch s {
        case null {?(v, null)};
        case (?(w, r)) {
          switch (cmp(v,w)) {
            case (#less) { ?(v, r)};
            case (#equal) { s };
            case (#greater) { ?(w, add(r, cmp, v)) };
          }
        }
      }
   };

   public func mem<T>(s : Set<T>, cmp : (T, T) -> Order.Order, v : T) : Bool {
      switch s {
        case null { false };
        case (?(w, s)) {
          switch (cmp(v, w)) {
            case (#less) { false };
            case (#equal) { true };
            case (#greater) { mem(s, cmp, v) };
          }
        }
      }
   }

}