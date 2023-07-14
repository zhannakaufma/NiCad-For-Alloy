% NiCad tag grammar
include "nicad.grm"

include "alloy.grm"

% Ignore BOM headers from Windows
include "bom.grm"


% Redefinitions to collect source coordinates for function definitions as parsed input,
% and to allow for XML markup of function definitions as output

% Modified to match constructors as well.  Even though the grammar still
% has constructor_declaration in it, this one will match first. - JRC 25mar11
redefine block
	% input format
	[srclinenumber]
	{ [IN] [NL]
	 [expr *] [EX] 
	} [srclinenumber] [NL]
	|
	% Output format
	[not token]
	[opt xml_source_coordinate]
	{ [IN] [NL]
		[expr *] [EX]
	} [NL]
	[opt end_xml_source_coordinate]
end redefine

redefine program
	...
    | 	[repeat block]
end redefine


% Main function - extract and mark up blocks from parsed input program
function main
    replace [program]
	P [program]
    construct Blocks [repeat block]
    	_ [^ P] 			% Extract all blocks from program
	  [convertBlocks] 
    by 
    	Blocks
end function

rule convertBlocks
    import TXLargs [repeat stringlit]
	FileNameString [stringlit]

    % Find each block and match its input source coordinates
    skipping [block]
    replace [block]
	LineNumber [srclinenumber]
	'{
	    Exprs [expr *]
	'} EndLineNumber [srclinenumber]

    % Convert line numbers to strings for XML
    construct LineNumberString [stringlit]
	_ [quote LineNumber] 
    construct EndLineNumberString [stringlit]
	_ [quote EndLineNumber] 

    % Output is XML form with attributes indicating input source coordinates
    construct XmlHeader [xml_source_coordinate]
	'<source file=FileNameString startline=LineNumberString endline=EndLineNumberString>
    by
	XmlHeader 
	{
	    Exprs [unmarkEmbeddedBlocks] 
	'}
	'</source>
end rule

rule unmarkEmbeddedBlocks
    replace [block]
	LineNumber [srclinenumber]
	'{
	    Exprs [expr *]
	'} EndLineNumber [srclinenumber]
    by
	'{
	    Exprs 
	'}
end rule

