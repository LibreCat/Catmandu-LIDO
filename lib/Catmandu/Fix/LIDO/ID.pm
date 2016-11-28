package Catmandu::Fix::LIDO::ID;

use strict;

use Exporter qw(import);
use Data::Dumper qw(Dumper);

use Catmandu::Fix::LIDO::Utility qw(walk declare_source);

our @EXPORT_OK = qw(emit_base_id);

##
# Emit the code that generates a lido id node in a path. The node is attached directly to the path, so you
# must specify the name of the id (e.g. lidoRecID) in the $path.
# @param $fixer
# @param $root
# @param $path
# @param $id
# @param $source
# @param $label
# @param $type
# @return $fixer emit code
sub emit_base_id {
	my ($fixer, $root, $path, $id, $source, $label, $type) = @_;

	my $new_path = $fixer->split_path($path);
    my $code = '';

	my $f_id = $fixer->generate_var();
	$code .= "my ${f_id};";
	$code .= declare_source($fixer, $id, $f_id);

	my $i_root = $fixer->var;
	if (defined($root)) {
		$i_root = $root;
	}

    $code .= $fixer->emit_create_path(
		$i_root,
		$new_path,
		sub {
			my $r_root = shift;
			my $r_code = '';

			$r_code .= "${r_root} = {";

			if (defined($type)) {
				$r_code .= "'type' => '".$type."',";
			}

			if (defined($source)) {
				$r_code .= "'source' => '".$source."',";
			}

			if (defined($label)) {
				$r_code .= "'label' => '".$label."',";
			}

			$r_code .= "'_' => ${f_id}";

			$r_code .= "};";
			
			return $r_code;
		}
	);

    return $code;
};

1;

__END__

=pod

=head1 NAME

Catmandu::Fix::LIDO::ID::emit_id

=head1 SYNOPSIS

    emit_id(
        $fixer, # The fixer object from the calling emit function inside the calling Fix (required).
        $root, # The root path (string) from which the path parameter must be created (required).
		$path, # The path (string) for the id - must include the name of the id node (required).
        $id, # The value of the id node, as a string path (required).
        $source, # Source attribute, string.
		$label, # Label attribute, string.
		$type # Type attribute, string.
    )

=head1 DESCRIPTION

This function will generate the necessary emit code to generate a C<id> node in a given path. The node is attached directly to the path, so you must specify the name of the id (e.g. lidoRecID) in the $path.