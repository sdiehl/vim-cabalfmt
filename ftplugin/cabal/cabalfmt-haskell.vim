if !exists("g:cabalfmt_command")
  let g:cabalfmt_command = "cabal-fmt"
endif
if !exists("g:cabalfmt_options")
  let g:cabalfmt_options = [""]
endif
if !exists("g:cabalfmt_disable")
  let g:cabalfmt_disable = 0
endif
if !exists("b:cabalfmt_disable")
  " Inherit buffer level flag from global flag (default 0)
  let b:cabalfmt_disable = g:cabalfmt_disable
endif

function! s:OverwriteBuffer(output)
  if &modifiable
    let l:curw=winsaveview()
    try | silent undojoin | catch | endtry
    let splitted = split(a:output, '\n')
    if line('$') > len(splitted)
      execute len(splitted) .',$delete'
    endif
    call setline(1, splitted)
    call winrestview(l:curw)
  else
    echom "Cannot write to non-modifiable buffer"
  endif
endfunction

function! s:CabalHaskell()
  if executable(g:cabalfmt_command)
    call s:RunCabal()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "cabalfmt executable not found"
  endif
endfunction

function! s:CabalSave()
  if (b:cabalfmt_disable == 1)
  else
    call s:CabalHaskell()
  endif
  if exists("bufname")
    write
  endif
endfunction

function! s:RunCabal()
  if exists("bufname")
    let output = system(g:cabalfmt_command . " " . join(g:cabalfmt_options, ' ') . " " . bufname("%"))
  else
    let stdin=join(getline(1, '$'), "\n")
    let output = system(g:cabalfmt_command . " " . join(g:cabalfmt_options, ' '), stdin)
  endif
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    if exists("bufname")
      write
    endif
  endif
endfunction

function! RunCabal()
  call s:CabalHaskell()
endfunction

function! ToggleCabal()
  if b:cabalfmt_disable == 1
    let b:cabalfmt_disable = 0
    echo "Cabal formatting enabled for " . bufname("%")
  else
    let b:cabalfmt_disable = 1
    echo "Cabal formatting disabled for " . bufname("%")
  endif
endfunction

function! DisableCabal()
    let b:cabalfmt_disable = 1
    echo "Cabal formatting disabled for " . bufname("%")
endfunction

function! EnableCabal()
    let b:cabalfmt_disable = 0
    echo "Cabal formatting enabled for " . bufname("%")
endfunction

augroup cabalfmt-haskell
  autocmd!
  autocmd BufWritePost *.cabal call s:CabalSave()
augroup END
