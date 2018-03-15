use v6;
use LDAP::Search::Grammar;
use Test;

# no real tests yet

for (
    TOP => '(cn=BabsJ*)',
    attr => 'cn',
    item => 'cn=*',
    any => '*',
    any => 'Babs J*',
    escaped => '\\2A',
    TOP => '(cn=Babs Jensen)',
    TOP => '(cn=*)',
    TOP => '(!(cn=Tim Howes))',
    TOP => '(&(a=x)(b=y))',
    TOP => '(&(objectClass=Person)(|(sn=Jensen)(cn=Babs J*)))',
    TOP => '(o=univ*of*mich*)',
    TOP => '(cn:1.2.3.4.5:=Fred Flintstone)',
    escaped => '\2A',
    any => '*\2A',
    TOP => '(cn=*\2A*)',
    TOP => '(filename=C:\5cMyFile)',
    TOP => '(sn=Lu\c4\8di\c4\87)',
    ) {
    my $rule = .key;
    my $input = .value;
    ok LDAP::Search::Grammar.parse($input, :rule($rule)), "parse $rule: $input";
}

done-testing;
