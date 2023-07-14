sig A {
	pair: lone A
}

fact pair {
	all x,y: A | y in x.pair iff x in y.pair
}

fact pair_clone {
	all x,y: A | y in x.pair // y is paired with x
		 iff x in y.pair
}

pred paired [x: A]{
	some x.pair
}

run {} for 5 A
