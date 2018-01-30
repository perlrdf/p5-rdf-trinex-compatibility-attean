#!/usr/bin/env perl

use strict;
use Test::More;
use RDF::Trine qw(iri);

use_ok('RDF::TrineX::Compatibility::Attean');

use_ok('RDF::Trine::Model');

can_ok('RDF::Trine::Model', 'get_quads');

my $testmodel = RDF::Trine::Model->temporary_model;
my $parser = RDF::Trine::Parser->new( 'turtle' );

my $testdata = '<http://example.org/foo> a <http://example.org/Bar> ; <http://example.org/title> "Dahut"@fr ; <http://example.org/something> [ <http://example.org/else> "Foo" ; <http://example.org/pi> 3.14 ] .';

$parser->parse_into_model('http://example.org/', $testdata, $testmodel );

ok(my $iter = $testmodel->get_quads(undef, iri('http://example.org/pi'), undef, undef), 'Query sent ok');
isa_ok($iter, 'RDF::Trine::Iterator');
ok(my $row = $iter->next, 'Got an element from the iterator');
ok(my $lit = $row->object, 'Got the object');
is($lit->value, 3.14, 'Value roundtripped');
isa_ok($lit->datatype, 'Attean::IRI');
is($lit->datatype->value, 'http://www.w3.org/2001/XMLSchema#decimal', 'datatype roundtripped');


done_testing;
