import paginate

doAssert paginate([], 4) == @[]
doAssert paginate(["a", "b", "c"], 4) == @[@["a", "b", "c"]]
doAssert paginate(["a", "b", "c"], 3) == @[@["a", "b", "c"]]
doAssert paginate(["a", "b", "c"], 2) == @[@["a", "b"], @["c"]]
doAssert paginate(["a", "b", "c"], 1) == @[@["a"], @["b"], @["c"]]

