function! myspacevim#after() abort
    " We want vimfiler to show us 'dotfiles'
    let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'

    nmap <space>1 :edit term://zsh<CR> 
endfunction
