ls -1 input*gz | sort -n | xargs -rn1 zcat | perl -Mutf8 -we 'my $s=""; while (<STDIN>) { if (/^<s/) {$s=$_;} if (/ #1->/) { print "</s>\n$s"; } print; }' | parse_cqp.pl | depcqp-append.pl | perl -Mutf8 -we 'while(<>) { if (/^<s/) {$_="";} if (/^(?:\x{a4}|¤)\t([^\t]+)/) {$a=$1; $ a=~ s/"-/" /g; print "<s $a>\n"; s/^(\x{a4}|¤)\t[^\t]+/\x{a4}\t\x{a4}/;} print; }' | zstd -15 -T0 -c > output.cqp.zstd