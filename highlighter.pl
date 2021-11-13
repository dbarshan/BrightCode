use strict;
use warnings;

my %reserved_words = 	(	
					'#include'	,	'<reserved>#include</reserved>'	, 
					'private'	, 	'<reserved>private</reserved>'	,
					'private:'	, 	'<reserved>private</reserved>:'	, 
					'public'	, 	'<reserved>public</reserved>'	,
					'public:'	, 	'<reserved>public</reserved>:'	,
					'return'	,	'<reserved>return</reserved>'	,
					'if'		,	'<reserved>if</reserved>'		,
					'if('		,	'<reserved>if</reserved>('		,
					'else'		,	'<reserved>else</reserved>'		,
					'else{'		,	'<reserved>else</reserved>{'	,
					'new'		,	'<reserved>new</reserved>'		,
					'new('		,	'<reserved>new</reserved>('		
				   	);
my %keywords = 	(	
					'int'			,	'<keyword>int</keyword>'			,
					'struct'		,	'<keyword>struct</keyword>'			,
					'class'			,	'<keyword>class</keyword>'			,
					'void'			,	'<keyword>void</keyword>'			,
					'bool'			,	'<keyword>bool</keyword>'		
				);
 

my $filename = 'heap.cpp';
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my @content_org;

while (my $line = <$fh>){
	push @content_org, $line;
}
close $fh;

my @content_tab_removed;
foreach my $l (@content_org){
	$l =~ s!\t!<tab>!g;	
	push @content_tab_removed, $l;
}

my @content_tagged;

foreach my $line (@content_tab_removed){
	$line =~ s!int !<keyword>int</keyword> !g;	
	$line =~ s!<tab>int !<tab><keyword>int</keyword> !g;
	$line =~ s!struct !<keyword>struct</keyword> !g;
	$line =~ s!class !<keyword>class</keyword> !g;
	$line =~ s!void !<keyword>void</keyword> !g;
	
	$line =~ s!#include !<reserved>#include</reserved> !g;
	$line =~ s!<tab>private:!<tab><reserved>private</reserved>:!g;
	$line =~ s!<tab>public:!<tab><reserved>public</reserved>:!g;
	$line =~ s!<tab>if!<tab><reserved>if</reserved>!g;
	$line =~ s!<tab>else!<tab><reserved>else</reserved>!g;
	$line =~ s!<tab>else!<tab><reserved>while</reserved>!g;
	$line =~ s!<tab>break!<tab><reserved>break</reserved>!g;
	$line =~ s!<tab>return!<tab><reserved>return</reserved>!g;
	$line =~ s!<tab>while!<tab><reserved>while</reserved>!g;
	

	push @content_tagged, $line;

}

my $output_filename = 'highlighted.cpp';
open (my $oh, '>', $output_filename) or die "Could not open file $output_filename $!";
foreach my $line (@content_tagged) {
   print $oh $line;
}
close $fh;
