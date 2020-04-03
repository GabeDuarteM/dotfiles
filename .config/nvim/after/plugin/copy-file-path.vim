function! CopyFilePath()
  let relativePath = @%
  echo 'Copied "' . relativePath . '"'

  call setreg('+', relativePath)
endfunction

command! CopyFilePath call CopyFilePath() 

function! CopyFullFilePath()
  let relativePath = expand('%:p')
  echo 'Copied "' . relativePath . '"'

  call setreg('+', relativePath)
endfunction

command! CopyFullFilePath call CopyFullFilePath() 
