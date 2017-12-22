#!/usr/bin/env perl

use strict;
use Test::More;

use_ok('RDF::TrineX::Compatibility::Attean');

use_ok('RDF::Trine::Node::Literal');

can_ok('RDF::Trine::Node::Literal', 'value');
can_ok('RDF::Trine::Node::Literal', 'language');
#can_ok('RDF::Trine::Node::Literal', 'has_datatype');
can_ok('RDF::Trine::Node::Literal', 'datatype');

subtest 'plain literatal string' => sub {
  my $lit = RDF::Trine::Node::Literal->new('Dahut');

  is($lit->value, 'Dahut', 'Value roundtripped');
#  is($lit->language, 'fr', 'Language roundtripped');
};

subtest 'language string literal' => sub {
  my $lit = RDF::Trine::Node::Literal->new('Dahut', 'fr');

  is($lit->value, 'Dahut', 'Value roundtripped');
  is($lit->language, 'fr', 'Language roundtripped');
};

subtest 'datatype literal' => sub {
  my $lit = RDF::Trine::Node::Literal->new('42', undef, 'http://www.w3.org/2001/XMLSchema#integer');

  is($lit->value, '42', 'Value roundtripped');
  is($lit->datatype->as_string, 'http://www.w3.org/2001/XMLSchema#integer', 'datatype roundtripped');
};
  
  
#is($lit->datatype, 'http://www.w3.org/2001/XMLSchema#langString', 'Got langString data type');

done_testing;
