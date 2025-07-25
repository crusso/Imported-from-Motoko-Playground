import Order "mo:base/Order";

module OrderedSet2 {

  public type Set<T> = ?(T, Set<T>);

  public class SetOps<T>(cmp : (T, T) -> Order.Order) {

    public let empty : Set<T> = null;

    public func add(s : Set<T>, v : T) : Set<T> {
      switch s {
        case null { ?(v, null) };
        case (?(w, r)) {
          switch (cmp(v, w)) {
            case (#less) { ?(v, r) };
            case (#equal) { s };
            case (#greater) { ?(w, add(r, v)) };
          };
        };
      };
    };

    public func mem(s : Set<T>, v : T) : Bool {
      switch s {
        case null { false };
        case (?(w, s)) {
          switch (cmp(v, w)) {
            case (#less) { false };
            case (#equal) { true };
            case (#greater) { mem(s, v) };
          };
        };
      };
    };
  };
};
