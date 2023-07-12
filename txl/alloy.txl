% TXL Alloy 5 grammar
% Simple null program to test the grammar

% TXL Java 8 Grammar
include "alloy.grm"

% Just parse
function main
    replace [program] 
        P [program]
    by
	P
end function