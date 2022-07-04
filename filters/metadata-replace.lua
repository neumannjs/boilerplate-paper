local vars = {}

function get_vars (meta)
  for k, v in pairs(meta) do
    if (v and v.t and v.t == 'MetaInlines') then
      vars["%" .. k .. "%"] = {table.unpack(v)}
    else
      vars["%" .. k .. "%"] = v
    end
  end
end

function replace (el)
  if vars[el.text] then
    return pandoc.Span(vars[el.text])
  else
    return el
  end
end

return {{Meta = get_vars}, {Str = replace}}