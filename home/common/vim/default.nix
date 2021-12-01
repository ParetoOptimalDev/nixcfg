{ config, pkgs, ... }:

{
  home = {
    sessionVariables =
      {
        EDITOR = "vim";
      };
  };

  programs.vim =
    let
      vimConfigDir = config.home.homeDirectory + "/.vim";
    in
    {
      enable = true;
      extraConfig = ''
        " Show the line and column number of the cursor position
        set ruler

        " Display the incomplete commands in the bottom right-hand side of your screen.
        set showcmd

        " Display completion matches on your status line
        set wildmenu

        " Show a few lines of context around the cursor
        set scrolloff=5

        " Highlight search matches
        set hlsearch

        " Enable incremental searching
        set incsearch

        " Don't line wrap mid-word.
        set linebreak

        " Copy the indentation from the current line.
        set autoindent

        " Enable smart autoindenting.
        set smartindent

        " Enable smart tabs
        set smarttab

        " Set spell check to British English
        autocmd FileType text setlocal spell spelllang=en_gb


        "
        " KEYMAPS
        "

        " Remap leader key
        let mapleader = ","

        " Open terminal inside vim
        map <Leader>tt :terminal<CR>
        map <Leader>tv :vertical terminal<CR>

        " Splits and tabbed files
        set splitbelow splitright

        " Remap splits navigation to just CTRL + hjkl
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l

        " Make adjusing split sizes a bit more friendly
        noremap <silent> <C-Left> :vertical resize +3<CR>
        noremap <silent> <C-Right> :vertical resize -3<CR>
        noremap <silent> <C-Up> :resize +3<CR>
        noremap <silent> <C-Down> :resize -3<CR>

        " Change 2 split windows from vert to horiz or horiz to vert
        map <Leader>th <C-w>t<C-w>H
        map <Leader>tk <C-w>t<C-w>K

        " Removes pipes | that act as seperators on splits
        set fillchars+=vert:\

        " Insert shebang at the beginning
        map <F2> <Esc>ggO#!/usr/bin/env


        "
        " MARKDOWN
        "

        " Treat all .md files as markdown
        autocmd BufNewFile,BufRead *.md set filetype=markdown

        " Set spell check to British English
        autocmd FileType markdown setlocal spell spelllang=en_gb

        " Set text width
        autocmd FileType markdown setlocal textwidth=100

        " Treat fenced languages as such
        let g:markdown_fenced_languages = ['bash=sh', 'sh', 'html', 'groovy', 'java', 'js=javascript', 'python', 'rust', 'vim']


        "
        " TEMPLATES
        "
        if has("autocmd")
          augroup templates
            autocmd BufNewFile *.sh 0r ~/.config/vim/templates/skeleton.sh
          augroup END
        endif


        "
        " PLUGINS
        "

        " lightline
        set laststatus=2
        "set noshowmode " disabled since ranger-vim seems to break lightline sometimes
        set shortmess+=F
        let g:lightline = {
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ],
        \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \   },
        \   'tab': {
        \     'active': [ 'filetype', 'filename', 'modified' ],
        \     'inactive': [ 'filetype', 'filename', 'modified' ]
        \   },
        \   'component_function': {
        \     'gitbranch': 'FugitiveHead',
        \     'filetype': 'LightlineWebDevIconsFiletype',
        \     'fileformat': 'LightlineWebDevIconsFileformat'
        \   },
        \   'tab_component_function': {
        \     'filetype': 'LightlineTabWebDevIconsFiletype'
        \   }
        \ }

        function! LightlineWebDevIconsFiletype()
          return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '''
        endfunction

        function! LightlineWebDevIconsFileformat()
          return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : '''
        endfunction

        function! LightlineTabWebDevIconsFiletype(n)
          let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
          return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
        endfunction

        " ranger
        map <leader>rr :RangerEdit<cr>
        map <leader>rv :RangerVSplit<cr>
        map <leader>rs :RangerSplit<cr>
        map <leader>rt :RangerTab<cr>
        map <leader>ri :RangerInsert<cr>
        map <leader>ra :RangerAppend<cr>
        map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
        map <leader>rd :RangerCD<cr>
        map <leader>rld :RangerLCD<cr>

        " vimwiki
        set nocompatible

        filetype plugin on
        let g:vimwiki_global_ext = 0
        syntax on

        let nextcloud_notes = {}
        let nextcloud_notes.path = '~/Nextcloud/Notes/'
        let nextcloud_notes.syntax = 'markdown'
        let nextcloud_notes.ext = 'txt'
        let nextcloud_notes.list_margin = 0
        let g:vimwiki_list = [nextcloud_notes]
        let g:vimwiki_dir_link = 'index'

        autocmd FileType vimwiki setlocal spell spelllang=de_ch

        function! VimwikiFindIncompleteTasks()
          lvimgrep /- \[ \]/ %:p
          lopen
        endfunction

        function! VimwikiFindAllIncompleteTasks()
          VimwikiSearch /- \[ \]/
          lopen
        endfunction

        :autocmd FileType vimwiki map wa :call VimwikiFindAllIncompleteTasks()<CR>
        :autocmd FileType vimwiki map wx :call VimwikiFindIncompleteTasks()<CR>

        function! ToggleCalendar()
          execute ":Calendar"
          if exists("g:calendar_open")
            if g:calendar_open == 1
              execute "q"
              unlet g:calendar_open
            else
              g:calendar_open = 1
            end
          else
            let g:calendar_open = 1
          end
        endfunction
        :autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>

        au BufNewFile ~/Nextcloud/Notes/diary/*.txt :silent 0r !${vimConfigDir}/bin/generate-vimwiki-diary-template.py '%'
      '';
      plugins = with pkgs.vimPlugins; [
        direnv-vim
        elm-vim
        fzf-vim
        lightline-vim
        nerdcommenter
        ranger-vim
        vim-css-color
        vim-devicons
        vim-fugitive
        vim-nix
        vim-startify
        vim-surround

        # Vimwiki
        vimwiki
        mattn-calendar-vim
      ];
      settings = {
        # Use spaces instead of tabs
        expandtab = true;

        # Save 1,000 items in history
        history = 1000;

        # Ignore case when searching
        ignorecase = true;

        # Turn on line numbering
        number = true;

        # Enable relative line numbers
        relativenumber = true;

        # Make a tab equal to 4 spaces
        shiftwidth = 4;
        tabstop = 4;

        # Override the 'ignorecase' option if the search pattern contains upper case characters.
        smartcase = true;
      };
    };
}
