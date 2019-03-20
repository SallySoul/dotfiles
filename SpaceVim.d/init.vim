" Dark powered mode of SpaceVim, generated by SpaceVim automatically.
let g:spacevim_enable_debug = 1
let g:spacevim_realtime_leader_guide = 1
call SpaceVim#layers#load('unite')
call SpaceVim#layers#load('colorscheme')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('incsearch')
call SpaceVim#layers#load('lang#perl')
call SpaceVim#layers#load('lang#rust')
call SpaceVim#layers#load('lang#vim')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#java')
call SpaceVim#layers#load('lang#xml')
call SpaceVim#layers#load('tools#screensaver')
call SpaceVim#layers#load('shell')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('VersionControl')
let g:spacevim_enable_vimfiler_welcome = 1
let g:spacevim_enable_debug = 1
let g:deoplete#auto_complete_delay = 150
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_buffer_index_type = 1
let g:neomake_vim_enabled_makers = ['vimlint', 'vint']
if has('python3')
    let g:ctrlp_map = ''
    nnoremap <silent> <C-p> :Denite file_rec<CR>
endif
let g:clang2_placeholder_next = ''
let g:clang2_placeholder_prev = ''

nmap ; :
let g:spacevim_colorscheme = 'onedark'
"let g:spacevim_colorscheme_bg = 'dark'

let g:racer_cmd = "/Users/russell/.cargo/bin/racer"

nmap <space>1 :edit term://zsh<CR>

" other perl stuff
