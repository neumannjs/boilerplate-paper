if FORMAT:match 'latex' or  FORMAT:match 'json' then
    function Para(el)
        if pandoc.utils.equals(pandoc.Str 'TODO:', el.content[1]) then 
            return {
                pandoc.RawBlock('tex', '\\begin{tcolorbox}[colback=yellow,boxrule=0pt,sharp corners]'),
                el,
                pandoc.RawBlock('tex', '\\end{tcolorbox}')
            }
        end
        return el
    end
end