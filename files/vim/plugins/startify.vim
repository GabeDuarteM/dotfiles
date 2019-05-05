" Get the list of projects to display on the page
function! s:getProjects()
  let projectPaths = split(glob($PROJECTS_FOLDER.'/*', '\n')) 
  let projects = map(projectPaths, {key, val -> { 'line': fnamemodify(val, ":t"), 'path': val}})

  return projects
endfunction

let g:startify_lists = [
  \ { 'type': function('s:getProjects'), 'header': ['   Projects'] },
  \ { 'type': 'files', 'header': ['   MRU'] },
  \ { 'type': 'dir', 'header': ['   MRU '. getcwd()] },
  \ ]

let g:startify_files_number = 5

