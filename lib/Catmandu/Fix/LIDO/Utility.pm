package Catmandu::Fix::LIDO::Utility;

use strict;

use Data::Dumper qw(Dumper);

use Exporter qw(import);
use String::Util qw(trim);

our @EXPORT_OK = qw(walk declare_source split_path);

##
# $fixer->split_path with local fixes
# Loosely adapted from the example in the C Programming Language
sub split_path {
	my ($path) = @_;
	# split on . or /, but not on \. or \/
	my @chars = split(//, trim($path));
	my @splitted;
	my @component;
	foreach my $char (@chars) {
		if ($char eq '.' || $char eq '/') {
			my $previous_char = pop(@component);
			# Check for the previous string; if it is '\', append to @component and remove '\'
			if ($previous_char eq '\\') {
				push(@component, $char);
			} else {
				# Else, join @component and add it to splitted
				push(@component, $previous_char);
				push(@splitted, join('', @component));
				@component = ();
			}
		} else {
			push(@component, $char);
		}
	}
	# Add the joined last @component if it isn't empty
	if ($#component != 0) {
		push (@splitted, join('', @component));
	}
	return \@splitted;
}


##
# For a source $var, that is a path parameter to a fix,
# use walk() to get the value and return the generated
# $perl code.
# @param $fixer
# @param $var
# @param $declared_var
# @return $fixer emit code
sub declare_source {
	my ( $fixer, $var, $declared_var ) = @_;

	my $perl = '';

	my $var_path = split_path ( $var );
	my $var_key = pop @$var_path;
	$perl .= walk($fixer, $var_path, $var_key, $declared_var);
	return $perl;
}

##
# Walk through a path ($path) until at
# $key. Set $h = $val in the fixer code.
# $h must be declared before calling walk()
# This has the effect of assigning $val (the value of the leaf
# node you're walking to) to $h, so you can use $h in your fix.
# @param $fixer
# @param $path
# @param $key
# @param $h
# @return $fixer emit code
sub walk {
	my ($fixer, $path, $key, $h) = @_;

	my $perl = '';
	
	$perl .= $fixer->emit_walk_path(
		$fixer->var,
		$path,
		sub {
			my $var = shift;
			$fixer->emit_get_key(
				$var,
				$key,
				sub {
					my $val = shift;
					"${h} = ${val};";
				}
			);
		}
	);
	
	return $perl;
}

1;