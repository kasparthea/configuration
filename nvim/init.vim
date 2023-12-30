let mapleader =" "
source ~/.local/share/nvim/site/autoload/plug.vim
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'owozsh/Amora'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'chrisbra/Colorizer'
call plug#end()

filetype on
set number relativenumber
set encoding=utf-8
set wildmode=longest,list,full
" sets right split
set spr
" sets below split
set sb
set guicursor=
" shows that leader is pressed
set showcmd

" enable autosave plugin
let g:auto_save = 1
" airline shape?
let g:airline_powerline_fonts = 1

" have transparent terminal with dracula vim scheme
let g:dracula_colorterm = 0
" show hidden files in nerdtree, remember about spaces when assigning value
let NERDTreeShowHidden = 1
colorscheme dracula

" Fixes for navigating split windows
" ctrl w was painfull
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-n> :NERDTreeToggle<CR>
" turn off search highlightning
map <leader>h :set hlsearch!<CR>
" vertical split
nnoremap <leader>V :vs<CR>
" vertical split with space for entering a filename
nnoremap <leader>v :vs<Space>
" make adding newlines easier
nmap <Enter> o<Esc>
" faster command mode
nnoremap ; :
" easier exit from vim in normal mode
nnoremap <leader>q :wq!<CR>
" same but without saving
nnoremap <leader>c :q!<CR>

" because I moved them to a place where vim does not automatically recognise them
autocmd BufEnter xdefaults set syntax=xdefaults
autocmd BufEnter variables set syntax=zsh
" setup for C
autocmd BufEnter *.c inoremap ,lf for<Space>(int <++> = <++>; <++> < <++>; <++> += <++>)<CR>{<CR><++><CR>}<++>
autocmd BufEnter *.c inoremap ,lb for<Space>(int <++> = <++>; <++> < <++>; <++> -= <++>)<CR>{<CR><++><CR>}<++>
autocmd BufEnter *.c inoremap ,if if<Space>(<++>)<CR>{<CR><++><CR>}<++>
autocmd BufEnter *.c inoremap ,lw while<Space>(<++>)<CR>{<CR><++><CR>}<++>

" setup for latex
autocmd BufEnter *.tex map <F3> :!latexindent %<CR><CR>
autocmd BufEnter *.c,*.tex inoremap ,, <Esc>/<++><Enter>"_c4l
autocmd BufEnter *.tex inoremap ,.= \geq<Space>
autocmd BufEnter *.tex inoremap ,= \leq<Space>
autocmd BufEnter *.tex inoremap ,mb \mathbb{}<++><Esc>T{i
autocmd BufEnter *.tex inoremap ,bd \begin{document}<CR><CR>\end{document}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,bl \begin{itemize}<CR><CR>\end{itemize}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,bs \begin{split}<CR><CR>\end{split}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,bol \begin{enumerate}<CR><CR>\end{enumerate}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,be \begin{equation*}<CR><CR>\end{equation*}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,bm \begin{math}<CR><CR>\end{math}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,bc \begin{cases}<CR><CR>\end{cases}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,bcs \begin{center}<CR><CR>\end{center}<Space><++><Esc>kI
autocmd BufEnter *.tex inoremap ,' ``"<Space><++><Esc>T`i
autocmd BufEnter *.tex inoremap ,e \emph{}<Space><++><Esc>F}i
autocmd BufEnter *.tex inoremap ,b \textbf{}<Space><++><Esc>F}i
autocmd BufEnter *.tex inoremap ,it \textit{}<Space><++><Esc>F}i
autocmd BufEnter *.tex inoremap ,i \item<Space>
autocmd BufEnter *.tex inoremap ,t \text<Space>
autocmd BufEnter *.tex inoremap ,sq \sqrt[]{<++>}<Space><++><Esc>T[i
autocmd BufEnter *.tex inoremap ,pt \left(<Space><Space>\right)<Space><++><Esc>T(a
autocmd BufEnter *.tex inoremap ,sbt \left[<Space><Space>\right]<Space><++><Esc>T[a
autocmd BufEnter *.tex inoremap ,cbt \left\{<Space><Space>\right\}<Space><++><Esc>T{a
autocmd BufEnter *.tex inoremap ,[ \[<Space><Space>\]<Space><++><Esc>T[a
autocmd BufEnter *.tex inoremap ,i1l \int\limits_{}^{<++>}<Space><++><Space>\<Space>dx<Esc>T_a
autocmd BufEnter *.tex inoremap ,i2l \iint\limits_{}^{<++>}<Space><++><Space>\<Space>dx<Esc>T_a
autocmd BufEnter *.tex inoremap ,l \lim_{\to<Space><++>}<Space><++><Esc>T{i
autocmd BufEnter *.tex inoremap ,8 \infty<Space>
autocmd BufEnter *.tex inoremap ,c \lceil<Space><Space>\rceil<Space><++><Esc>2Tla
autocmd BufEnter *.tex inoremap ,a \langle<Space><Space>\rangle<Space><++><Esc>2Tea
autocmd BufEnter *.tex inoremap ,fl \lfloor<Space>\rfloor<Space><++><Esc>3Toa<Space>
autocmd BufEnter *.tex inoremap ,s \sum\limits_{}^{<++>}<Space><++><Esc>T_a
autocmd BufEnter *.tex inoremap ,p \prod_{}^{<++>}<Space><++><Esc>T_a
autocmd BufEnter *.tex inoremap ,f \frac{}{<++>}<Space><++><Esc>2T{i
autocmd BufEnter *.tex inoremap ,pr \par<CR>
"autocmd BufEnter *.tex inoremap ,pi \setlength{\parindent}{ex}<++><Esc>Fei

" I do not know if the best method
" Well there seems to be some problem with neovim and
" autocmd so i had to change command to make it work
" luke smiths version did not work, same with bufread
" instead of bufenter 
" so no filetype and no bufread either i guess
autocmd BufEnter *.txt inoremap ( ()<left>
" autocmd BufEnter *.txt setlocal spell spelllang=en_gb
" solve wrapping issue, sort of
autocmd BufEnter *.txt set wm=1 
autocmd BufEnter *.txt nmap <leader><Enter> 2<Enter>i

autocmd FileType py let g:deoplete#enable_at_startup = 1
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
