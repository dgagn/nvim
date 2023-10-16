let g:user_emmet_leader_key = "<c-a>"

inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let s:inlay_hints_enabled = 0

nnoremap <leader>ih <cmd>call ToggleInlayHints()<cr>

function! ToggleInlayHints()
  if s:inlay_hints_enabled
    let s:inlay_hints_enabled = 0
    lua require('rust-tools').inlay_hints.unset()
  else
    let s:inlay_hints_enabled = 1
    lua require('rust-tools').inlay_hints.set()
  endif
endfunction

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_smart_case = 1

let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDirectories = ["ultisnips"]

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

