local function starts_with(start, str) return str:sub(1, #start) == start end

local function tikz2image(src, filetype, outfile)
    local tmp = os.tmpname()
    local tmpdir = "../output"
    local debian = false
    if starts_with("/tmp/", tmp) then
        -- Linux
        debian = true
        tmp = tmp:gsub("/tmp", "")
    end
    tmp = tmpdir .. tmp
    local f, err = io.open(tmp .. ".tex", 'w')
    if f==nil then
        print(tmp) 
        print("Couldn't open file: "..err)
    end
    f:write(
        "\\documentclass{standalone}\n\\usepackage{standalone}\n\\usepackage{xcolor}\n\\usepackage{tikz}\n\\usetikzlibrary{graphs, graphs.standard, quotes, arrows,shapes,positioning, fit, calc, backgrounds}\n\\usepackage{pgfplots}\n\\usepgfplotslibrary{units}\n\\begin{document}\n\\nopagecolor\n")
    f:write(src)
    f:write("\n\\end{document}\n")
    f:close()
    if debian then
        print("texliveonfly --terminal_only --arguments='-synctex=1 -interaction=nonstopmode -output-directory=".. tmpdir .. "' " .. tmp)
        os.execute("texliveonfly --terminal_only --arguments='-synctex=1 -interaction=nonstopmode -output-directory=".. tmpdir .. "' " .. tmp)
    else
        os.execute("pdflatex -output-directory " .. tmpdir  .. " " .. tmp)
    end
    if filetype == 'pdf' then
        f, err = os.rename(tmp .. ".pdf", outfile)
        if f==nil then
            print("renaming error: " .. err)
        else
            print("renamed file from " .. tmp .. ".pdf to " .. outfile)
        end
    elseif filetype == 'png' then
        if debian == true then
            print("convert  -density 300 -antialias " .. tmp .. ".pdf -quality 100 " .. outfile)
            os.execute("convert  -density 300 -antialias " .. tmp .. ".pdf -quality 100 " .. outfile)
        else
            os.execute("magick convert  -density 300 -antialias " .. tmp .. ".pdf -quality 100 " .. outfile)
        end
    else
        os.execute("pdf2svg " .. tmp .. ".pdf " .. outfile)
    end
    os.remove(tmp .. ".tex")
    os.remove(tmp .. ".pdf")
    os.remove(tmp .. ".log")
    os.remove(tmp .. ".aux")
    os.remove(tmp .. ".synctex.gz")
end

extension_for = {
    html = 'svg',
    html4 = 'svg',
    html5 = 'svg',
    latex = 'pdf',
    beamer = 'pdf',
    docx = 'png',
    revealjs = 'svg',
    pptx = 'png'
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

function RawBlock(el)
    if starts_with("\\begin{tikzpicture}", el.text) or
        starts_with("\\tikzset", el.text) or
        starts_with("\\includestandalone", el.text) then
        local filetype = extension_for[FORMAT] or "svg"
        local fname = "../output/images/" .. pandoc.sha1(el.text) .. "." .. filetype
        if not file_exists(fname) then
            print("Uncached image found, building:" .. fname)
            tikz2image(el.text, filetype, fname)
        end
        return pandoc.Para({pandoc.Image({}, fname)})
    else
        return el
    end
end
