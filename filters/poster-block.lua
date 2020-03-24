text = require 'text'
table = require 'table'

local location = {'line'}

function Header (elem)
  if elem.level == 2 then
    table.insert(location, 'block')
    return pandoc.RawBlock('latex', '\\begin{block}{\\large {'..pandoc.utils.stringify(elem)..'}}')
  end
end

function HorizontalRule (elem)
  curr_location = table.remove(location)
  if curr_location == 'block' then
    return pandoc.RawBlock('latex', '\\end{block}')
  elseif curr_location == 'column' then
    return pandoc.RawBlock('latex', '\\end{column}')
  elseif curr_location == 'columns' then
    return pandoc.RawBlock('latex', '\\end{columns}')
  elseif curr_location == 'line' then
    return pandoc.RawBlock('latex', '\\bigskip\n{\\usebeamercolor[bg]{headline}\\hrulefill}\n\\bigskip')
  else
     return {}
  end
end

function Table (elem)
  if text.lower(pandoc.utils.stringify(elem.headers[1])) == 'columns' then
    table.insert(location, 'columns')
    table.insert(location, 'column')
    return {
      pandoc.RawBlock('latex', '\\begin{columns}['..pandoc.utils.stringify(elem.rows[1][1])..']'),
      pandoc.RawBlock('latex', '\\begin{column}{0.'..pandoc.utils.stringify(elem.rows[1][2])..'\\textwidth}')
    }
  end
  if text.lower(pandoc.utils.stringify(elem.headers[1])) == 'column' then
    table.insert(location, 'column')
    return {
      pandoc.RawBlock('latex', '\\begin{column}{0.'..pandoc.utils.stringify(elem.rows[1][1])..'\\textwidth}')
    }
  end
end