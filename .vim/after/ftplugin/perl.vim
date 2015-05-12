setlocal ts=4 sw=4 sts=4

call system('which perltidy')
if ! v:shell_error
  setlocal equalprg=perltidy
endif
