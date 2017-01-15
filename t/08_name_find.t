use v6.c;

use Test;
use XML::XPath;

plan 6;

my $x = XML::XPath.new(xml => q:to/ENDXML/);
<AAA>
<BCC><BBB/><BBB/><BBB/></BCC>
<DDB><BBB/><BBB/></DDB>
<BEC><CCC/><DBD/></BEC>
</AAA>
ENDXML

my $set;

$set = $x.find('//*[name()="BBB"]');
is $set.nodes.elems, 5 , 'found one node';
is $set.nodes[0].name, 'BBB', 'node name is BBB';

$set = $x.find('//*[starts-with(name(),"B")]');
is $set.nodes.elems, 7 , 'found two nodes';
is $set.nodes[0].name, 'BCC', 'node name is BCC';

$set = $x.find('//*[contains(name(),"C")]');
is $set.nodes.elems, 3 , 'found one node';
is $set.nodes[0].name, 'BCC', 'node name is BCC';

done-testing;
