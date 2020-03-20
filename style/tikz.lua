local function tikz2image(src, filetype, outfile)
    local tmp = os.tmpname()
    local f, err = io.open("./output" .. tmp .. ".tex", 'w')
    if f==nil then
        print(tmp) 
        print("Couldn't open file: "..err)
    end
    f:write(
        "\\documentclass{standalone}\n\\usepackage{standalone}\n\\usepackage{xcolor}\n\\usepackage{tikz}\n\\usetikzlibrary{graphs, graphs.standard, quotes, arrows,shapes,positioning}\n\\usepackage{pgfplots}\n\\usepgfplotslibrary{units}\n\\begin{document}\n\\nopagecolor\n")
    f:write(src)
    f:write("\n\\end{document}\n")
    f:close()
    os.execute("pdflatex -output-directory " .. ".\\output" .. " " ..
                   "./output" .. tmp)
    if filetype == 'pdf' then
        os.rename("./output" .. tmp .. ".pdf", outfile)
    elseif filetype == 'png' then
        os.execute("magick convert  -density 300 -antialias ./output" .. tmp .. ".pdf -quality 100 " .. outfile)
    else
        os.execute("pdf2svg ./output" .. tmp .. ".pdf " .. outfile)
    end
    os.remove("./output" .. tmp .. ".tex")
    os.remove("./output" .. tmp .. ".pdf")
    os.remove("./output" .. tmp .. ".log")
    os.remove("./output" .. tmp .. ".aux")
end

extension_for = {
    html = 'svg',
    html4 = 'svg',
    html5 = 'svg',
    latex = 'pdf',
    beamer = 'pdf',
    docx = 'png',
    revealjs = 'svg'
}

local function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function starts_with(start, str) return str:sub(1, #start) == start end

function RawBlock(el)
    if starts_with("\\begin{tikzpicture}", el.text) or
        starts_with("\\tikzset", el.text) or
        starts_with("\\includestandalone", el.text) then
        local filetype = extension_for[FORMAT] or "svg"
        local fname = "./output/images/" .. pandoc.sha1(el.text) .. "." .. filetype
        if not file_exists(fname) then
            print("Uncached image found, building:" .. fname)
            tikz2image(el.text, filetype, fname)
        end
        return pandoc.Para({pandoc.Image({}, fname)})
    else
        return el
    end
end
