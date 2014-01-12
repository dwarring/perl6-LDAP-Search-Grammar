use v6;

##use Grammar::Tracer;

grammar LDAP::Search::Grammar {
    rule TOP {^ ~ $ <filter> }

    rule filter { '(' ~ ')' <filtercomp> }

    proto rule filtercomp {*}
    rule filtercomp:sym<and>  { '&' <filterlist> }
    rule filtercomp:sym<or>   { '|' <filterlist> }
    rule filtercomp:sym<not>  { '!' <filter> }
    rule filtercomp:sym<item> { <item> }
 
    rule filterlist { <filter>+ }

    proto rule item {*}
    proto token filtertype {*}
    token filtertype:sym<equal>   {'='}
    token filtertype:sym<approx>  {'~='}
    token filtertype:sym<greater> {'>='}
    token filtertype:sym<less>    {'<='}
    rule item:sym<substring>      { <attr> '=' <any> }
    rule item:sym<extensible>     { <attr> <dnattrs>? <matchingrule>? ':=' <value>
				  | <dnattrs>? <matchingrule> ':=' <value> }
    token any                     { ['*' | <value>]+ }
    rule attr                     { <oid> <attr-opts>* }
    rule attr-opts                { ';' <key-char>+}
    token key-char                { <alnum> | '-' }
    rule dnattrs                  { ':dn' }
    rule matchingrule             { ':'<!before '='> <oid> }
    token oid                     { ['.'|<digit>]+ | <alpha>+}
    rule value                    { [<normal>|<escaped>]+ }
    token normal                  { <- [ \x00 '(' ')' '*' \\ ]>  }
    token escaped                 { \\ <xdigit> <xdigit> }
}

