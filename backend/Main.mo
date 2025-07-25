import Nat "mo:base/Nat";

// functional ordered sets
import OS1 "./OS1"; // every operation takes comparison
import OS2 "./OS2"; // with class returning operations from given comparison & simpler operations

// imperative ordered sets
import IOS1 "./IOS1"; // every operation takes comparison
import IOS2 "./IOS2"; // with class returning operations from given comparison & simpler operations

// object oriented, imperative ordered sets
// constructor takes comparison
import OOS1 "./OOS1"; // with share/unshare methods
import OOS2 "./OOS2"; // no share/unshare, but constructor given initial state.

actor {

  stable var version = 0;
  
  // functional ordered sets
  stable var os1 : OS1.Set<Nat> = OS1.empty<Nat>();
  // every operation takes comparison
  os1 := OS1.add(os1, Nat.compare, version);

  // functional ordered sets
  // with class returning operations from given comparison
  let SetOps = OS2.SetOps<Nat>(Nat.compare);
  stable var os2 : OS2.Set<Nat> = SetOps.empty;
  os2 := SetOps.add(os1, version);

  // imperative ordered sets
  stable let ios1 : IOS1.Set<Nat> = IOS1.empty<Nat>();
  // every operation takes comparison
  IOS1.add(ios1, Nat.compare, version);

  // imperative ordered sets
  // with class returning operations from given comparison
  let ImpSetOps = IOS2.SetOps<Nat>(Nat.compare);
  stable let ios2 : IOS2.Set<Nat> = ImpSetOps.empty();
  ImpSetOps.add(ios1, version);

  // OO imperative sets, with unshare/share, requiring preupgrade method
  // breaks encapsulation
  stable var oos1State = OS1.empty<Nat>();
  let oos1 : OOS1.Set<Nat> = OOS1.Set<Nat>(Nat.compare);
  oos1.unshare(oos1State);
  oos1.add(version);
  // what about binary methods like union?

  system func preupgrade() {
    oos1State := oos1.share(); // save state
  };

  // OO imperative sets wrapping initial state
  // no share/unshare nor preupgrade method
  // breaks encapsulation
  stable let oos2State = { var ref = OS1.empty<Nat>() };
  let oos2 : OOS2.Set<Nat> = OOS2.Set<Nat>(oos2State, Nat.compare);
  oos2.add(version);
  // what about binary methods like union?

  // display current state
  public query func show() : async Text {
    debug_show { os1; os2; ios1; ios2; oos1State; oos2State };
  };
  
  // bump the version counter, so next upgrade add new element to all sets
  version += 1;
};
