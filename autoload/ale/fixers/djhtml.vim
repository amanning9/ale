" Author: amanning9 <mail@alex-m.co.uk>
" Description: Fixing Django Html files with djhtml.
"
call ale#Set('htmldjango_djhtml_executable', 'djhtml')
call ale#Set('htmldjango_djhtml_use_global', get(g:, 'ale_use_global_executables', 0))
call ale#Set('htmldjango_djhtml_options', '')
call ale#Set('htmldjango_djhtml_change_directory', 1)

function! ale#fixers#djhtml#GetExecutable(buffer) abort
    return ale#htmldjango#FindExecutable(a:buffer, 'htmldjango_djhtml', ['djhtml'])
endfunction

function! ale#fixers#djhtml#Fix(buffer) abort
    let l:executable = ale#fixers#djhtml#GetExecutable(a:buffer)
    let l:cmd = [ale#Escape(l:executable)]

    let l:options = ale#Var(a:buffer, 'htmldjango_djhtml_options')

    if !empty(l:options)
        call add(l:cmd, l:options)
    endif

    call add(l:cmd, '-')

    let l:result = {'command': join(l:cmd, ' ')}

    if ale#Var(a:buffer, 'htmldjango_djhtml_change_directory')
        let l:result.cwd = '%s:h'
    endif

    return l:result
endfunction
