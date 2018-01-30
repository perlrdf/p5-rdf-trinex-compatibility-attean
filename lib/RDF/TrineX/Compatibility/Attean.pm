use 5.010001;
use strict;
use warnings;

package RDF::TrineX::Compatibility::Attean;
no warnings 'redefine';

our $AUTHORITY = 'cpan:KJETILK';
our $VERSION   = '0.001';

use Attean;
use Attean::IRI;

package RDF::Trine::Node::Resource {
  sub abs { return $_[0]->uri }
};

package RDF::Trine::Node::Literal {
  
  sub value { return $_[0]->literal_value }
  
  sub language { return $_[0]->literal_value_language }
  
  sub datatype { # A bit of extra logic to support RDF 1.1 semantics
	 my $self = shift;
	 my $string;
	 if ($self->has_datatype) {
		$string = $self->literal_datatype;
	 } else {
		if ($self->has_language) {
		  $string = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#langString';
		} else {
		  $string = 'http://www.w3.org/2001/XMLSchema#string';
		}
	 }
	 return Attean::IRI->new($string);
  }
};

package RDF::Trine::Model {

  sub get_quads {
	 my $self = shift;
	 return $self->get_statements(@_);
  }

};
  
1;

__END__

=pod

=encoding utf-8

=head1 NAME

RDF::TrineX::Compatibility::Attean - Compatibility layer between Attean and RDF::Trine

=head1 SYNOPSIS

In modules that have new L<Attean> methods, but otherwise uses L<RDF::Trine>, just go:

  use RDF::TrineX::Compatibility::Attean;


=head1 DESCRIPTION

For now, only certain methods of L<Attean> nodes are supported. They
are added to the respective L<RDF::Trine> nodes by this module. They
are:

=over

=item * C<RDF::Trine::Node::Resource::abs>

=item * C<RDF::Trine::Node::Literal::literal_value>

=item * C<RDF::Trine::Node::Literal::literal_value_language>

=item * C<RDF::Trine::Node::Literal::literal_datatype>

=back

=head1 TODO

I'm unsure on how C<RDF::Trine::Node::Literal::has_datatype> should be
treated. Attean implements RDF 1.1, where all literals have a
datatype, so to Attean, C<has_datatype> would always be true, but that
would be surprising to Trine users.



=head1 BUGS

Please report any bugs or things you miss from L<Attean> here:
L<https://github.com/kjetilk/p5-rdf-trinex-compatibility-attean/issues>.

=head1 SEE ALSO

=head1 AUTHOR

Kjetil Kjernsmo E<lt>kjetilk@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2017 by Kjetil Kjernsmo.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
