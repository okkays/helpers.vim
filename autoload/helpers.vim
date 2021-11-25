""
" @section Introduction, intro
" Provides helper functions for other okkays plugins.
"

""
" @public
"
" Selects the given arg, visual selection, or word under the cursor.
function! helpers#GetContentArg(arg, is_visual) abort
  if !empty(a:arg)
    return a:arg
  endif
  let l:visual = maktaba#buffer#GetVisualSelection()
  if a:is_visual && !empty(trim(l:visual))
    return l:visual
  endif
  return expand("<cword>")
endfunction

""
" @public
"
" Builds a QuickFix list entry for a line item.
function! helpers#BuildQuickfixEntry(index, line)
  let l:parts = split(a:line, ':')
  return {
        \  "filename": parts[0],
        \  "lnum": get(parts, 1, 0),
        \  "text": get(parts, 2, '')
        \}
endfunction

""
" @public
" Builds a quickfix list out of a list of contents.
" Each line may contain: filename:lnum extra descriptive text
function! helpers#BuildQuickfixList(lines)
  if len(a:lines) == 1
    execute "edit ".a:lines[0]
  else
    call setqflist(map(copy(a:lines), function('helpers#BuildQuickfixEntry')))
    copen
    cc
  endif
endfunction

