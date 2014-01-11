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
    TOP => '(cn=Babs Jensen)',
    TOP => '(cn=*)',
    TOP => '(!(cn=Tim Howes))',
    TOP => '(&(a=x)(b=y))',
    TOP => '(&(objectClass=Person)(|(sn=Jensen)(cn=Babs J*)))',
    TOP => '(o=univ*of*mich*)',
    TOP => '(cn:1.2.3.4.5:=Fred Flintstone)',
    ) {
    my $rule = .key;
    my $input = .value;
    say "$rule:$input";
    say LDAP::Search::Grammar.parse($input, :rule($rule) );
}

done;
