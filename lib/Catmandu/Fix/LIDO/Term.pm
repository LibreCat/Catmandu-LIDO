package Catmandu::Fix::LIDO::Term;

use Catmandu::Fix::LIDO::Utility qw(walk declare_source split_path);

use strict;

use Exporter qw(import);

our @EXPORT_OK = qw(emit_term);

#has path      => ( fix_arg => 1);
#has term      => ( fix_arg => 1 );
#has conceptid => ( fix_opt => 1 );
#has lang      => ( fix_opt => 1, default => sub { 'en' } );
#has pref      => ( fix_opt => 1, default => sub { 'preferred' } );
#has source    => ( fix_opt => 1, default => sub { 'AAT' } );
#has type      => ( fix_opt => 1, default => sub { 'global' } );

##
# Emit the code to generate a LIDO term node that is directly attached to the $path, so you have to provide the name for the term (e.g. category) as part of the path.
# @param $fixer
# @param $root
# @param $path
# @param $term
# @param $conceptid
# @param $lang
# @param $pref
# @param $source
# @param $type
# @return $fixer emit code
sub emit_term {
    my ($fixer, $root, $path, $term, $conceptid, $lang, $pref, $source, $type) = @_;

    my $code = '';

    my $new_path = split_path($path);
    ##
    # term
    my $f_term = $fixer->generate_var();
    $code .= "my ${f_term};";
    $code .= declare_source($fixer, $term, $f_term);

    my $t_root = $fixer->var;
    if (defined ($root)) {
        $t_root = $root;
    }

    ##
    # Create the term for Lido::XML ad the correct path
    $code .= $fixer->emit_create_path(
        $t_root,
        $new_path,
        sub {
            my $p_root = shift;
            my $p_code = '';

            # TODO pref is undefined?

            $p_code .= $fixer->emit_create_path(
                        $p_root,
                        ['term', '$append'],
                        sub {
                            my $term_root = shift;
                            my $term_code = '';

                            $term_code .= "${term_root} = {";

                            if (defined($lang)) {
                                $term_code .= "'lang' => '".$lang."',";
                            }

                            if (defined($pref)) {
                                $term_code .= "'pref' => '".$pref."',";
                            }

                            $term_code .= "'_' => ${f_term}";

                            $term_code .= "};";

                            return $term_code;
                        }
                    );
            ##
            # conceptID
            if (defined($conceptid)) {
                my $f_conceptid = $fixer->generate_var();
                $p_code .= "my ${f_conceptid};";
                $p_code .= declare_source($fixer, $conceptid, $f_conceptid);
                ##
                # Create the conceptID for Lido::XML
                $p_code .= $fixer->emit_create_path(
                    $p_root,
                    ['conceptID', '$append'],
                    sub {
                        my $concept_root = shift;
                        my $c_code = '';

                        $c_code .= "${concept_root} = {";

                        if (defined($pref)) {
                            $c_code .= "'pref' => '".$pref."',";
                        }

                        if (defined($type)) {
                            $c_code .= "'type' => '".$type."',";
                        }

                        if (defined($source)) {
                            $c_code .= "'source' => '".$source."',";
                        }

                        $c_code .= "'_' => ${f_conceptid}";

                        $c_code .= "};";
                        
                        return $c_code;
                    }
                );
            }

            return $p_code;
        }
    );

    return $code;
}

1;

__END__

=pod

=head1 NAME

Catmandu::Fix::LIDO::Term::emit_term

=head1 SYNOPSIS

    emit_term(
        $fixer, # The fixer object from the calling emit function inside the calling Fix (required).
        $root, # The root path (string) from which the path parameter must be created (required).
        $path, # The path (string) for the nameset - must include the name of the nameset node (required).
        $term, # Path (string) to the value of the term component (required).
        $conceptid, # Path (string) to the value of the conceptID component.
        $lang, # xml:lang attribute, string.
        $pref, # pref attribute, string.
        $source, # source attribute, string.
        $type # type attribute, string.
        
    )

=head1 DESCRIPTION

This function will generate the necessary emit code to generate a C<term> node in a given path consisting of C<term> and C<conceptID>. The node is attached directly to the path, so you must specify the name of the term (e.g. category) in the $path.