sig A {
	pair: lone A
}

fact pair {
	all x, y: A | y in x.pair iff  in y.pair
}

fact pair_clone {
	all x, y : A | y in x.pair // y is paired with x
		iff x in y.pair
}

fact pair_clone_2 {
	all a, b : A | b in a.pair 
		iff a in b.pair
}

fact pair_clone_3 {
	all x, y : X | y in x.pair // x is paired with y
		iff x in y.pair
}

fact pair_clone_4 {
	all x, y: A | y in x.pair iff x in y.pair 
		//purposely adding the comment
}

fact pair_clone_5 {
	all y, x : A | y in x.pair iff x in y.pair
}

fact pair_clone_6 {
	all x, y : A | x in y.pair iff y in x.pair
}

fact pair_clone_7 {
	all x, y : A |
		x in y.pair
			iff
				y in x.pair
}

fact pair_clone_8 {
	all x, y : A |
		x in y.pair
}


pred paired [x: A] {
	some x.pair
}

run {} for 5
