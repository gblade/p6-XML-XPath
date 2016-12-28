use v6.c;

use Test;
use XML::XPath;
use XML::XPath::Expr;
use XML::XPath::Step;

plan 7;

my $x = XML::XPath.new;
my $expression;

$expression = "/dok";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis     => 'self',
        literal  => 'dok',
    )
), $expression;

$expression = "/*";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis       => 'self',
        literal    => '*',
    )
), $expression;

$expression = "//dok/kap";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis       => 'descendant-or-self',
        literal    => 'dok',
        next => XML::XPath::Step.new(
            axis     => 'child',
            literal  => 'kap',
        )
    )
), $expression;

$expression = "//dok/kap[1]";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis    => 'descendant-or-self',
        literal => 'dok',
        next    => XML::XPath::Step.new(
            axis     => 'child',
            literal  => 'kap',
            predicates => [
                           XML::XPath::Expr.new(
                               operator => '',
                               operand => XML::XPath::Expr.new(
                                   operand => 1,
                               ),
                           ),
                       ],
        )
    )
), $expression;

$expression = "//kap[@title='Nettes Kapitel']/pa";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis       => 'descendant-or-self',
        literal    => 'kap',
        predicates => [
                       XML::XPath::Expr.new(
                           operator => '=',
                           operand => XML::XPath::Step.new(
                               axis    => 'attribute',
                               literal => 'title',
                           ),
                           other-operand => XML::XPath::Expr.new(
                               operator => '',
                               operand  => XML::XPath::Expr.new(
                                   operand => 'Nettes Kapitel',
                               )
                           ),
                       ),
                   ],
        next => XML::XPath::Step.new(
            axis     => 'child',
            literal  => 'pa',
        ),
    )
), $expression;

$expression = "//kap/pa[2]";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis    => 'descendant-or-self',
        literal => 'kap',
        next    => XML::XPath::Step.new(
            axis     => 'child',
            literal  => 'pa',
            predicates => [
                           XML::XPath::Expr.new(
                               operator => '',
                               operand  => XML::XPath::Expr.new(
                                   operand => 2,
                               ),
                           ),
                       ],
        )
    )
), $expression;

$expression = "//kap[2]/pa[@format='bold'][2]";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => '',
    operand => XML::XPath::Step.new(
        axis       => 'descendant-or-self',
        literal    => 'kap',
        predicates => [
                       XML::XPath::Expr.new(
                           operator => '',
                           operand  => XML::XPath::Expr.new(
                               operand => 2,
                           ),
                       ),
                   ],
        next => XML::XPath::Step.new(
            axis       => 'child',
            literal    => 'pa',
            predicates => [
                       XML::XPath::Expr.new(
                           operator => '=',
                           operand => XML::XPath::Step.new(
                               axis    => 'attribute',
                               literal => 'format',
                           ),
                           other-operand => XML::XPath::Expr.new(
                               operator => '',
                               operand  => XML::XPath::Expr.new(
                                   operand => 'bold',
                               )
                           ),
                       ),
                       XML::XPath::Expr.new(
                           operator => '',
                           operand => XML::XPath::Expr.new(
                               operand => 2,
                           )
                       ),
                       ]
        ),
    )
), $expression;

$expression = "child::*";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => "",
    operand  => XML::XPath::Step.new(
        axis    => "child",
        literal => "*",
    )
), $expression;

$expression = "child::pa";
is-deeply $x.parse-xpath($expression),
XML::XPath::Expr.new(
    operator => "",
    operand  => XML::XPath::Step.new(
        axis    => "child",
        literal => "pa",
    )
), $expression;

$expression = "child::text()";
use Data::Dump;
my $xpath = $x.parse-xpath($expression);
say Dump $xpath, :skip-methods(True);
is-deeply $x.parse-xpath($expression),
Any, $expression;
exit;

$expression = ".";
is-deeply $x.parse-xpath($expression),
Any, $expression;

$expression = "./*";
is-deeply $x.parse-xpath($expression),
Any, $expression;

$expression = "./pa";
is-deeply $x.parse-xpath($expression),
Any, $expression;

$expression = "pa";
is-deeply $x.parse-xpath($expression),
Any, $expression;

$expression = "attribute::*";
is-deeply $x.parse-xpath($expression),
Any, $expression;

$expression = "namespace::*";
is-deeply $x.parse-xpath($expression),
Any, $expression;

$expression = "//kap[1]/pa[2]/text()";
is-deeply $x.parse-xpath($expression),
Any, $expression;

