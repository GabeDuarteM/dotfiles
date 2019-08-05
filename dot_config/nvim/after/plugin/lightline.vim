function! FileNameWithIcon() abort
  let fullpath = expand('%:p')
  let pathWithoutRoot = substitute(fullpath, getcwd() . "/", "", "")
  let tcd_blacklist = '\v(help|nerdtree|peekaboo|quickmenu|fzf|magit)'

  return &filetype !~# tcd_blacklist && winwidth(0) > 70
        \ ? pathWithoutRoot . ' ' . WebDevIconsGetFileTypeSymbol() 
        \ : ''
endfunction

function! Line_percent() abort
  return string((100*line('.'))/line('$'))
endfunction

function! Git_branch() abort
  if fugitive#head() !=# ''
    return fugitive#head() .  ' ' . ''
  else
    return ''
  endif
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})

  if get(info, 'error', 0)
    return ''
  endif

  return ''
endfunction

function! LightlineReadonly() abort
  return &readonly ? '' : ''
endfunction

let g:lightline = {}
let g:lightline.colorscheme = 'challenger_deep'
" let g:lightline.active = { 
"       \ 'left': [['mode', 'readonly'], ['git_branch', 'modified', 'filename_with_icon'] ],
"       \ 'right': [ ['lineinfo'], ['status_diagnostic'] ]
"       \ }
let g:lightline.active = { 
      \ 'left': [ [ 'mode', 'readonly', 'lineinfo', 'git_branch'], ['status_diagnostic'] ],
      \ 'right': [ ['filename_with_icon'], ['modified'] ],
      \ }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline#gitdiff#indicator_added = ''
let g:lightline#gitdiff#indicator_deleted = ''
let g:lightline#gitdiff#indicator_modified = ''

let g:lightline.component = {
        \ 'lineinfo': "%2{Line_percent()}",
        \ 'filename_with_icon': '%{FileNameWithIcon()}',
        \ 'git_branch': '%{Git_branch()}',
        \ 'filename_with_parent': '%t',
        \ 'status_diagnostic': '%{StatusDiagnostic()}',
        \ }

let g:lightline.component_function = {
      \ 'readonly': 'LightlineReadonly'
      \ }

