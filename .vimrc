set fileformat=unix  " Use Unix-style EOL when creating files.
set fileformats=unix,dos  " Read using Windows-style EOL if necessary.

" Use 4 space indentation. Use spaces instead of tab. 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Display current and relative line numbers.
set number
set relativenumber

set cursorline  " Highlight current line.

set showcmd  " Show command in bottom line.

set ruler  " Show current cursor position in status line.

set sidescroll=1

" Show tab, trailing spaces, and line wraps.
set list
set listchars=tab:»-,trail:~,extends:›,precedes:‹

set showmatch  " Highlight matching brackets.

set hlsearch    " Highlight searches
set ignorecase  " Ignore case when searching.
set smartcase   " Except when using capital letters.

set autoindent  " Indent new lines at same level as current line.

set visualbell  " Use visual bell instead of beeping.

" Allow backspace over autoindent, line breaks, and start of insert.
set backspace=indent,eol,start

set wildmenu  " Improved command-line completion.

set lazyredraw  " Lazy redraw for better performance.

syntax enable " Enable syntax highlighting.

filetype on  " Detect file type based on extention and possibly contents.
filetype plugin on  " Load plugins for specific file types.
filetype indent on  " Load indent files for specific file types.

set splitright " :split right
set splitbelow " :vsplit below
