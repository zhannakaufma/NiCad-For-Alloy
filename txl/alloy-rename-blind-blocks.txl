% NiCad blind renaming - C blocks
% Jim Cordy, May 2010

% Rev 19.5.20 JRC - Added blind renaming for numeric and string literals

% NiCad tag grammar
include "nicad.grm"

% Using Alloy grammar
include "alloy.grm"

redefine block
    { [IN] [NL]
        [expr *] [EX]
    } [NL]
end redefine

define potential_clone
    [expr]
end define

% Generic blind renaming
include "generic-rename-blind.rul"

% Literal renaming for Alloy
include "alloy-rename-literals.rul"
