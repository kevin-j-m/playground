require "anbt-sql-formatter/formatter"

class SqlFormatter
  def self.format(sql)
    new.format(sql)
  end

  def initialize
    @formatter = AnbtSql::Formatter.new(rule)
  end

  def format(sql)
    @formatter.format(sql)
  end

  private

  def rule
    AnbtSql::Rule.new.tap do |rule|
      rules(rule)
    end
  end

  def rules(rule)
    rule.in_values_num = 2
  end
end

# keyword
## none

#    rule.keyword = AnbtSql::Rule::KEYWORD_NONE

# irb(main):001:0> puts SqlFormatter.format("SELECT * from FOOS WHERE A = true AND B = 'test';")
# SELECT
#         *
#     from
#         FOOS
#     WHERE
#         A = true
#         AND B = 'test'
# ;
# Casing is preserved from original. SELECT is uppercase. from is lowercase.

## uppercase

#    rule.keyword = AnbtSql::Rule::KEYWORD_UPPER_CASE
# irb(main):001:0> puts SqlFormatter.format("SELECT * from FOOS;")
# SELECT
#         *
#     FROM
#         FOOS
# ;

## lowercase
#    rule.keyword = AnbtSql::Rule::KEYWORD_LOWER_CASE
# irb(main):001:0> puts SqlFormatter.format("SELECT * from FOOS;")
# select
#         *
#     from
#         FOOS
# ;

# indent_string
    # rule.indent_string = "<->"
# irb(main):001:0> puts SqlFormatter.format("SELECT * from FOOS;")
# SELECT
# <-><->*
# <->FROM
# <-><->FOOS
# ;
# Talk about how this was helpful when outputting on the web. Using a special
# character.

# function_names
## with no changes
# irb(main):001:0> puts SqlFormatter.format("SELECT COALESCE(status, 'unknown') from FOOS;")
# SELECT
#         COALESCE (
#             status
#             ,'unknown'
#         )
#     FROM
#         FOOS
# ;
## adding as a function
#     rule.function_names << "COALESCE"
# irb(main):001:0> puts SqlFormatter.format("SELECT COALESCE(status, 'unknown') from FOOS;")
# SELECT
#         COALESCE( status ,'unknown' )
#     FROM
#         FOOS
# ;

# space_after_comma
#     rule.function_names << "COALESCE"
#     rule.space_after_comma = true
# irb(main):001:0> puts SqlFormatter.format("SELECT coalesce(status, 'unknown') from FOOS;")
# SELECT
#         COALESCE( status , 'unknown' )
#     FROM
#         FOOS
# ;

 # nl: New Line
 # x: the keyword
# With no setting
#
# irb(main):001:0> puts SqlFormatter.format("select * from foos join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos JOIN bars
#             ON foos.id = bars.foo_id
#
# kw_plus1_indent_x_nl
# Indent another level and make a newline after the keyword
#     rule.kw_plus1_indent_x_nl << "JOIN"
# irb(main):001:0> puts SqlFormatter.format("select * from foos join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos JOIN
#             bars
#                 ON foos.id = bars.foo_id

# kw_minus1_indent_nl_x_plus1_indent
# Push the keyword back another level of indentation, then have a newline that
# is indented further than the keyword.
#     rule.kw_minus1_indent_nl_x_plus1_indent << "JOIN"
# irb(main):001:0> puts SqlFormatter.format("select * from foos join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos
#     JOIN
#         bars
#             ON foos.id = bars.foo_id

# kw_nl_x
# Put the keyword on a newline on the same level of indentation as the prior
# line.
#     rule.kw_nl_x << "JOIN"
# irb(main):001:0> puts SqlFormatter.format("select * from foos join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos
#         JOIN bars
#             ON foos.id = bars.foo_id

# kw_nl_x_plus1_indent
# Put keyword on a newline and have it indented further right than the prior
# line.
#     rule.kw_nl_x_plus1_indent << "JOIN"
# irb(main):001:0> puts SqlFormatter.format("select * from foos join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos
#             JOIN bars
#             ON foos.id = bars.foo_id

# kw_multi_words
# with no changes
# irb(main):001:0> puts SqlFormatter.format("select * from foos inner join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos INNER JOIN bars
#             ON foos.id = bars.foo_id
#
#    rule.kw_multi_words << "INNER JOIN"
#    rule.kw_nl_x << "INNER JOIN"
# irb(main):001:0> puts SqlFormatter.format("select * from foos inner join bars on foos.id = bars.foo_id")
# SELECT
#         *
#     FROM
#         foos
#         INNER JOIN bars
#             ON foos.id = bars.foo_id

# in_values_num
# Default
# irb(main):002:0> puts SqlFormatter.format("select * from foos where baz in ('a', 'b', 'c', 'd')")
# SELECT
#         *
#     FROM
#         foos
#     WHERE
#         baz IN (
#             'a'
#             ,'b'
#             ,'c'
#             ,'d'
#         )
#    rule.in_values_num = nil
# irb(main):001:0> puts SqlFormatter.format("select * from foos where baz in ('a', 'b', 'c', 'd')")
# SELECT
#         *
#     FROM
#         foos
#     WHERE
#         baz IN (
#             'a'
#             ,'b'
#             ,'c'
#             ,'d'
#         )
#     rule.in_values_num = AnbtSql::Rule::ONELINE_IN_VALUES_NUM
# irb(main):001:0> puts SqlFormatter.format("select * from foos where baz in ('a', 'b', 'c', 'd')")
# SELECT
#         *
#     FROM
#         foos
#     WHERE
#         baz IN (
#             'a' ,'b' ,'c' ,'d'
#         )
#    rule.in_values_num = 1
# irb(main):001:0> puts SqlFormatter.format("select * from foos where baz in ('a', 'b', 'c', 'd')")
# SELECT
#         *
#     FROM
#         foos
#     WHERE
#         baz IN (
#             'a'
#             ,'b'
#             ,'c'
#             ,'d'
#         )
#    rule.in_values_num = 2
# irb(main):001:0> puts SqlFormatter.format("select * from foos where baz in ('a', 'b', 'c', 'd')")
# SELECT
#         *
#     FROM
#         foos
#     WHERE
#         baz IN (
#             'a' ,'b'
#             ,'c' ,'d'
#         )

# For all of these, link to the source code to see the keywords/functions that
# are part of the defaults.
