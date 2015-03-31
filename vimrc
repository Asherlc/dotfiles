call pathogen#infect('bundle/{}')
call pathogen#helptags()
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
:set number
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
