let g:user_emmet_leader_key = "<c-e>"

inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

vnoremap s :s/\v

nnoremap Q q
nnoremap q <Nop>

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

let g:UltiSnipsExpandTrigger="<c-0>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:VimuxHeight = "40"

nnoremap <leader>lD <cmd>Telescope diagnostics severity=error<cr>
nnoremap <leader>ld <cmd>Telescope diagnostics<cr>

let g:htmllike_filetypes = ['html', 'astro', 'javascriptreact', 'typescriptreact', 'php', 'jinja.html', 'mustache']

function! IsHTMLLikeFiletype()
  for type in g:htmllike_filetypes
    if &filetype == type
      return 1
    endif
  endfor
  return 0
endfunction

function! TabExpandFunc()
  " Check if an UltiSnips snippet is expandable or if we can jump forwards in a snippet
  if UltiSnips#CanExpandSnippet()
    return "\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
  endif

  if IsHTMLLikeFiletype()
        let l:before_cursor = getline('.')[0:col('.')-2]
        if l:before_cursor =~ '\w\|>\|/\|-' " regex to match word character, >, /, or -
          return "\<Plug>(emmet-expand-abbr)"
        else
          return "\<tab>"
        endif
  endif

  return "\<tab>"
endfunction

function! TabExpandFuncVisual()
  " Add the conditions for visual mode here similar to the above function
  " For now, I'll add the emmet condition based on filetype
  if IsHTMLLikeFiletype()
    return "\<Plug>(emmet-expand-abbr)"
  endif

  return "\<tab>"
endfunction

inoremap <silent><expr> <tab> TabExpandFunc()
xnoremap <silent><expr> <tab> TabExpandFuncVisual()

set autoread

let test#rust#cargotest#test_options = '-- --nocapture'

au BufRead,BufNewFile *.hbs set filetype=mustache
