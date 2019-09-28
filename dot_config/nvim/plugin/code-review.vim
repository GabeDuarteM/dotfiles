function! CodeReview(...)
    " Get the result of git show in a list
    let flist = system('git diff master --name-only -- . ":(exclude)package-lock.json" ":(exclude)yarn.lock"')
    let flist = split(flist, '\n')

    " Create the dictionaries used to populate the quick-fix list
    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction

command! CR call CodeReview()

