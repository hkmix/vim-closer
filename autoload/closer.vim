if exists("g:closer_autoloaded") | finish | endif
let g:closer_autoloaded=1

if maparg("<Plug>CloserClose") == ""
  inoremap <silent> <SID>CloserClose <C-R>=closer#close()<CR>
  imap <script> <Plug>CloserClose <SID>CloserClose
endif

"
" Enables closer for the current buffer.
"

function! closer#enable()
  let b:closer_flags = '([{'
  let oldmap = maparg('<CR>', 'i')

  if oldmap =~# 'CloserClose'
    " already mapped. maybe the user was playing with `set ft`
  elseif oldmap != ""
    exe "imap <CR> ".oldmap."<Plug>CloserClose"
  else
    imap  <CR> <CR><Plug>CloserClose
  endif
endfunction

"
" Adds a closing bracket if needed.
" Executed after pressing <CR>
"

function! closer#close()
  " supress if it broke off a line (pressed enter not at the end)
  if match(getline('.'), '^\s*$') == -1 | return '' | endif

  let ln = line('.') - 1
  let line = getline(ln)
  let indent = matchstr(line, '^\s*')

  let closetag = s:get_closing(line)
  if closetag == '' | return "" | endif

  " <esc>a will go back to the 0.
  " I dont know why <esc>A is needed at the end, but it seems to fix
  " pressing escape after expansion.
  return "\<Esc>a" .indent . closetag . "\<C-O>O\<Esc>a" . indent . "\<Tab>\<Esc>A"
endfunction

"
" Returns the closing tag for a given line
"
"     get_closing('describe(function() {')
"     => '});'
"
"     get_closing('function x() {')
"     => '}'
"

function! s:get_closing(line)
  let i = -1
  let clo = ''
  while 1
    let i = match(a:line, '[{}()\[\]]', i+1)
    if i == -1 | break | endif
    let ch = a:line[i]
    if ch == '{'
      let clo = '}' . clo
    elseif ch == '}'
      if clo[0] != '}' | return '' | endif
      let clo = clo[1:]
    elseif ch == '('
      let clo = ')' . clo
    elseif ch == ')'
      if clo[0] != ')' | return '' | endif
      let clo = clo[1:]
    elseif ch == '['
      let clo = ']' . clo
    elseif ch == ']'
      if clo[0] != ']' | return '' | endif
      let clo = clo[1:]
    endif
  endwhile
  return clo
endfunction
