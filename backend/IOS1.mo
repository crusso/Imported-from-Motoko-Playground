import Order "mo:base/Order";

module ImpOrderedSet1 {

  type List<T> = ?{ head : T; var tail : List<T> };
  public type Set<T> = { var list : List<T> };

  public func empty<T>() : Set<T> = { var list = null };

  public func add<T>(s : Set<T>, cmp : (T, T) -> Order.Order, v : T) : () {
    func ins(l : List<T>) : List<T> {
      switch l {
        case null { ?{ head = v; var tail = null } };
        case (?r) {
          switch (cmp(v, r.head)) {
            case (#less) { ?{ head = v; var tail = l } };
            case (#equal) { l };
            case (#greater) { r.tail := ins(r.tail); l };
          };
        };
      };
    };
    s.list := ins(s.list);
  };

  public func mem<T>(s : Set<T>, cmp : (T, T) -> Order.Order, v : T) : Bool {
    func mem(l : List<T>) : Bool {
      switch l {
        case null { false };
        case (?r) {
          switch (cmp(v, r.head)) {
            case (#less) { false };
            case (#equal) { true };
            case (#greater) { mem(r.tail) };
          };
        };
      };
    };
    mem(s.list);
  };

};
