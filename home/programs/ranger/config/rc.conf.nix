{ config }:

''
  # ===================================================================
  # == Options
  # ===================================================================

  # Use non-default path for file preview script?
  # ranger ships with scope.sh, a script that calls external programs (see
  # README.md for dependencies) to preview images, archives, etc.
  set preview_script ${config.home.homeDirectory + "/" + config.xdg.configFile."ranger/scope.sh".target}

  # Be aware of version control systems and display information.
  set vcs_aware true

  # State of the four backends git, hg, bzr, svn. The possible states are
  # disabled, local (only show local info), enabled (show local and remote
  # information).
  set vcs_backend_git enabled
  set vcs_backend_hg disabled
  set vcs_backend_bzr disabled
  set vcs_backend_svn disabled

  # Use one of the supported image preview protocols
  set preview_images true

  # Set the preview image method. Supported methods:
  #
  # * w3m (default):
  #   Preview images in full color with the external command "w3mimgpreview"?
  #   This requires the console web browser "w3m" and a supported terminal.
  #   It has been successfully tested with "xterm" and "urxvt" without tmux.
  #
  # * iterm2:
  #   Preview images in full color using iTerm2 image previews
  #   (http://iterm2.com/images.html). This requires using iTerm2 compiled
  #   with image preview support.
  #
  #   This feature relies on the dimensions of the terminal's font.  By default, a
  #   width of 8 and height of 11 are used.  To use other values, set the options
  #   iterm2_font_width and iterm2_font_height to the desired values.
  #
  # * terminology:
  #   Previews images in full color in the terminology terminal emulator.
  #   Supports a wide variety of formats, even vector graphics like svg.
  #
  # * urxvt:
  #   Preview images in full color using urxvt image backgrounds. This
  #   requires using urxvt compiled with pixbuf support.
  #
  # * urxvt-full:
  #   The same as urxvt but utilizing not only the preview pane but the
  #   whole terminal window.
  #
  # * kitty:
  #   Preview images in full color using kitty image protocol.
  #   Requires python PIL or pillow library.
  #   If ranger does not share the local filesystem with kitty
  #   the transfer method is changed to encode the whole image;
  #   while slower, this allows remote previews,
  #   for example during an ssh session.
  #   Tmux is unsupported.
  #
  # * ueberzug:
  #   Preview images in full color with the external command "ueberzug".
  #   Images are shown by using a child window.
  #   Only for users who run X11 in GNU/Linux.
  set preview_images_method ueberzug

  # Display the directory name in tabs?
  set dirname_in_tabs true

  # Set a title for the window? Updates both `WM_NAME` and `WM_ICON_NAME`
  set update_title true

  # Set the tmux/screen window-name to "ranger"?
  set update_tmux_title true

  # Shorten the title if it gets long?  The number defines how many
  # directories are displayed at once, 0 turns off this feature.
  set shorten_title 3

  # Show hostname in titlebar?
  set hostname_in_titlebar true

  # Abbreviate $HOME with ~ in the titlebar (first line) of ranger?
  set tilde_in_titlebar true

  # Avoid previewing files larger than this size, in bytes.  Use a value of 0 to
  # disable this feature.
  # set preview_max_size ${builtins.toString (25 * 1024 * 1024)}

  # ===================================================================
  # == Local Options
  # ===================================================================
  # You can set local options that only affect a single directory.

  # Examples:
  setlocal path=~/downloads sort mtime

  # ===================================================================
  # == Define keys for the browser
  # ===================================================================

  # Basic
  map     Q quitall
  map     q quit
  copymap q ZZ ZQ

  map R     reload_cwd
  map F     set freeze_files!
  map <C-r> reset
  map <C-l> redraw_window
  map <C-c> abort
  map <esc> change_mode normal
  map ~ set viewmode!

  map i display_file
  map <A-j> scroll_preview 1
  map <A-k> scroll_preview -1
  map ? help
  map W display_log
  map w taskview_open
  map S shell $SHELL

  map :  console
  map ;  console
  map !  console shell%space
  map @  console -p6 shell  %%s
  map #  console shell -p%space
  map s  console shell%space
  map r  chain draw_possible_programs; console open_with%space
  map f  console find%space
  map cd console cd%space

  map <C-p> chain console; eval fm.ui.console.history_move(-1)

  # Change the line mode
  map Mf linemode filename
  map Mi linemode fileinfo
  map Mm linemode mtime
  map Mh linemode humanreadablemtime
  map Mp linemode permissions
  map Ms linemode sizemtime
  map MH linemode sizehumanreadablemtime
  map Mt linemode metatitle

  # Tagging / Marking
  map t       tag_toggle
  map ut      tag_remove
  map "<any>  tag_toggle tag=%any
  map <Space> mark_files toggle=True
  map v       mark_files all=True toggle=True
  map uv      mark_files all=True val=False
  map V       toggle_visual_mode
  map uV      toggle_visual_mode reverse=True

  # For the nostalgics: Midnight Commander bindings
  map <F1> help
  map <F2> rename_append
  map <F3> display_file
  map <F4> edit
  map <F5> copy
  map <F6> cut
  map <F7> console mkdir%space
  #map <F8> console delete
  map <F8> console trash
  map <F10> exit

  # In case you work on a keyboard with dvorak layout
  map <UP>       move up=1
  map <DOWN>     move down=1
  map <LEFT>     move left=1
  map <RIGHT>    move right=1
  map <HOME>     move to=0
  map <END>      move to=-1
  map <PAGEDOWN> move down=1   pages=True
  map <PAGEUP>   move up=1     pages=True
  map <CR>       move right=1
  map <DELETE>   console trash
  map <INSERT>   console touch%space

  # VIM-like
  copymap <UP>       k
  copymap <DOWN>     j
  copymap <LEFT>     h
  copymap <RIGHT>    l
  copymap <HOME>     gg
  copymap <END>      G
  copymap <PAGEDOWN> <C-F>
  copymap <PAGEUP>   <C-B>

  map J  move down=0.5  pages=True
  map K  move up=0.5    pages=True
  copymap J <C-D>
  copymap K <C-U>

  # Jumping around
  map H     history_go -1
  map L     history_go 1
  map ]     move_parent 1
  map [     move_parent -1
  map }     traverse
  map {     traverse_backwards
  map )     jump_non

  map gh cd ~
  map ge cd /etc
  map gu cd /usr
  map gd cd /dev
  map gl cd -r .
  map gL cd -r %f
  map go cd /opt
  map gv cd /var
  map gm cd /media
  map gi eval fm.cd('/run/media/' + os.getenv('USER'))
  map gM cd /mnt
  map gs cd /srv
  map gp cd /tmp
  map gr cd /
  map gR eval fm.cd(ranger.RANGERDIR)
  map g/ cd /
  map g? cd /nix/store/sqmc2c5p984h0arb26xf2bl0x307x3sx-ranger-1.9.3/share/doc/ranger

  # External Programs
  map E  edit
  map du shell -p du --max-depth=1 -h --apparent-size
  map dU shell -p du --max-depth=1 -h --apparent-size | sort -rh
  map yp yank path
  map yd yank dir
  map yn yank name
  map y. yank name_without_extension

  # Filesystem Operations
  map =  chmod

  map cw console rename%space
  map a  rename_append
  map A  eval fm.open_console('rename ' + fm.thisfile.relative_path.replace("%", "%%"))
  map I  eval fm.open_console('rename ' + fm.thisfile.relative_path.replace("%", "%%"), position=7)

  map pp paste
  map po paste overwrite=True
  map pP paste append=True
  map pO paste overwrite=True append=True
  map pl paste_symlink relative=False
  map pL paste_symlink relative=True
  map phl paste_hardlink
  map pht paste_hardlinked_subtree
  map pd console paste dest=
  map p`<any> paste dest=%any_path
  map p'<any> paste dest=%any_path

  map dD console delete
  map dT console trash

  map dd cut
  map ud uncut
  map da cut mode=add
  map dr cut mode=remove
  map dt cut mode=toggle

  map yy copy
  map uy uncut
  map ya copy mode=add
  map yr copy mode=remove
  map yt copy mode=toggle

  # Temporary workarounds
  map dgg eval fm.cut(dirarg=dict(to=0), narg=quantifier)
  map dG  eval fm.cut(dirarg=dict(to=-1), narg=quantifier)
  map dj  eval fm.cut(dirarg=dict(down=1), narg=quantifier)
  map dk  eval fm.cut(dirarg=dict(up=1), narg=quantifier)
  map ygg eval fm.copy(dirarg=dict(to=0), narg=quantifier)
  map yG  eval fm.copy(dirarg=dict(to=-1), narg=quantifier)
  map yj  eval fm.copy(dirarg=dict(down=1), narg=quantifier)
  map yk  eval fm.copy(dirarg=dict(up=1), narg=quantifier)

  # Searching
  map /  console search%space
  map n  search_next
  map N  search_next forward=False
  map ct search_next order=tag
  map cs search_next order=size
  map ci search_next order=mimetype
  map cc search_next order=ctime
  map cm search_next order=mtime
  map ca search_next order=atime

  # Tabs
  map <C-n>     tab_new
  map <C-w>     tab_close
  map <TAB>     tab_move 1
  map <S-TAB>   tab_move -1
  map <A-Right> tab_move 1
  map <A-Left>  tab_move -1
  map gt        tab_move 1
  map gT        tab_move -1
  map gn        tab_new
  map gc        tab_close
  map uq        tab_restore
  map <a-1>     tab_open 1
  map <a-2>     tab_open 2
  map <a-3>     tab_open 3
  map <a-4>     tab_open 4
  map <a-5>     tab_open 5
  map <a-6>     tab_open 6
  map <a-7>     tab_open 7
  map <a-8>     tab_open 8
  map <a-9>     tab_open 9
  map <a-r>     tab_shift 1
  map <a-l>     tab_shift -1

  # Sorting
  map or set sort_reverse!
  map oz set sort=random
  map os chain set sort=size;      set sort_reverse=False
  map ob chain set sort=basename;  set sort_reverse=False
  map on chain set sort=natural;   set sort_reverse=False
  map om chain set sort=mtime;     set sort_reverse=False
  map oc chain set sort=ctime;     set sort_reverse=False
  map oa chain set sort=atime;     set sort_reverse=False
  map ot chain set sort=type;      set sort_reverse=False
  map oe chain set sort=extension; set sort_reverse=False

  map oS chain set sort=size;      set sort_reverse=True
  map oB chain set sort=basename;  set sort_reverse=True
  map oN chain set sort=natural;   set sort_reverse=True
  map oM chain set sort=mtime;     set sort_reverse=True
  map oC chain set sort=ctime;     set sort_reverse=True
  map oA chain set sort=atime;     set sort_reverse=True
  map oT chain set sort=type;      set sort_reverse=True
  map oE chain set sort=extension; set sort_reverse=True

  map dc get_cumulative_size

  # Settings
  map zc    set collapse_preview!
  map zd    set sort_directories_first!
  map zh    set show_hidden!
  map <C-h> set show_hidden!
  copymap <C-h> <backspace>
  copymap <backspace> <backspace2>
  map zI    set flushinput!
  map zi    set preview_images!
  map zm    set mouse_enabled!
  map zp    set preview_files!
  map zP    set preview_directories!
  map zs    set sort_case_insensitive!
  map zu    set autoupdate_cumulative_size!
  map zv    set use_preview_script!
  map zf    console filter%space
  copymap zf zz

  # Filter stack
  map .d filter_stack add type d
  map .f filter_stack add type f
  map .l filter_stack add type l
  map .m console filter_stack add mime%space
  map .n console filter_stack add name%space
  map .# console filter_stack add hash%space
  map ." filter_stack add duplicate
  map .' filter_stack add unique
  map .| filter_stack add or
  map .& filter_stack add and
  map .! filter_stack add not
  map .r filter_stack rotate
  map .c filter_stack clear
  map .* filter_stack decompose
  map .p filter_stack pop
  map .. filter_stack show

  # Bookmarks
  map `<any>  enter_bookmark %any
  map '<any>  enter_bookmark %any
  map m<any>  set_bookmark %any
  map um<any> unset_bookmark %any

  map m<bg>   draw_bookmarks
  copymap m<bg>  um<bg> `<bg> '<bg>

  # Generate all the chmod bindings with some python help:
  eval for arg in "rwxXst": cmd("map +u{0} shell -f chmod u+{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map +g{0} shell -f chmod g+{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map +o{0} shell -f chmod o+{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map +a{0} shell -f chmod a+{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map +{0}  shell -f chmod u+{0} %s".format(arg))

  eval for arg in "rwxXst": cmd("map -u{0} shell -f chmod u-{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map -g{0} shell -f chmod g-{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map -o{0} shell -f chmod o-{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map -a{0} shell -f chmod a-{0} %s".format(arg))
  eval for arg in "rwxXst": cmd("map -{0}  shell -f chmod u-{0} %s".format(arg))

  # ===================================================================
  # == Define keys for the console
  # ===================================================================
  # Note: Unmapped keys are passed directly to the console.

  # Basic
  cmap <tab>   eval fm.ui.console.tab()
  cmap <s-tab> eval fm.ui.console.tab(-1)
  cmap <ESC>   eval fm.ui.console.close()
  cmap <CR>    eval fm.ui.console.execute()
  cmap <C-l>   redraw_window

  copycmap <ESC> <C-c>
  copycmap <CR>  <C-j>

  # Move around
  cmap <up>    eval fm.ui.console.history_move(-1)
  cmap <down>  eval fm.ui.console.history_move(1)
  cmap <left>  eval fm.ui.console.move(left=1)
  cmap <right> eval fm.ui.console.move(right=1)
  cmap <home>  eval fm.ui.console.move(right=0, absolute=True)
  cmap <end>   eval fm.ui.console.move(right=-1, absolute=True)
  cmap <a-b> eval fm.ui.console.move_word(left=1)
  cmap <a-f> eval fm.ui.console.move_word(right=1)

  copycmap <a-b> <a-left>
  copycmap <a-f> <a-right>

  # Line Editing
  cmap <backspace>  eval fm.ui.console.delete(-1)
  cmap <delete>     eval fm.ui.console.delete(0)
  cmap <C-w>        eval fm.ui.console.delete_word()
  cmap <A-d>        eval fm.ui.console.delete_word(backward=False)
  cmap <C-k>        eval fm.ui.console.delete_rest(1)
  cmap <C-u>        eval fm.ui.console.delete_rest(-1)
  cmap <C-y>        eval fm.ui.console.paste()

  # And of course the emacs way
  copycmap <ESC>       <C-g>
  copycmap <up>        <C-p>
  copycmap <down>      <C-n>
  copycmap <left>      <C-b>
  copycmap <right>     <C-f>
  copycmap <home>      <C-a>
  copycmap <end>       <C-e>
  copycmap <delete>    <C-d>
  copycmap <backspace> <C-h>

  # Note: There are multiple ways to express backspaces.  <backspace> (code 263)
  # and <backspace2> (code 127).  To be sure, use both.
  copycmap <backspace> <backspace2>

  # This special expression allows typing in numerals:
  cmap <allow_quantifiers> false

  # ===================================================================
  # == Pager Keybindings
  # ===================================================================

  # Movement
  pmap  <down>      pager_move  down=1
  pmap  <up>        pager_move  up=1
  pmap  <left>      pager_move  left=4
  pmap  <right>     pager_move  right=4
  pmap  <home>      pager_move  to=0
  pmap  <end>       pager_move  to=-1
  pmap  <pagedown>  pager_move  down=1.0  pages=True
  pmap  <pageup>    pager_move  up=1.0    pages=True
  pmap  <C-d>       pager_move  down=0.5  pages=True
  pmap  <C-u>       pager_move  up=0.5    pages=True

  copypmap <UP>       k  <C-p>
  copypmap <DOWN>     j  <C-n> <CR>
  copypmap <LEFT>     h
  copypmap <RIGHT>    l
  copypmap <HOME>     g
  copypmap <END>      G
  copypmap <C-d>      d
  copypmap <C-u>      u
  copypmap <PAGEDOWN> n  f  <C-F>  <Space>
  copypmap <PAGEUP>   p  b  <C-B>

  # Basic
  pmap     <C-l> redraw_window
  pmap     <ESC> pager_close
  copypmap <ESC> q Q i <F3>
  pmap E      edit_file

  # ===================================================================
  # == Taskview Keybindings
  # ===================================================================

  # Movement
  tmap <up>        taskview_move up=1
  tmap <down>      taskview_move down=1
  tmap <home>      taskview_move to=0
  tmap <end>       taskview_move to=-1
  tmap <pagedown>  taskview_move down=1.0  pages=True
  tmap <pageup>    taskview_move up=1.0    pages=True
  tmap <C-d>       taskview_move down=0.5  pages=True
  tmap <C-u>       taskview_move up=0.5    pages=True

  copytmap <UP>       k  <C-p>
  copytmap <DOWN>     j  <C-n> <CR>
  copytmap <HOME>     g
  copytmap <END>      G
  copytmap <C-u>      u
  copytmap <PAGEDOWN> n  f  <C-F>  <Space>
  copytmap <PAGEUP>   p  b  <C-B>

  # Changing priority and deleting tasks
  tmap J          eval -q fm.ui.taskview.task_move(-1)
  tmap K          eval -q fm.ui.taskview.task_move(0)
  tmap dd         eval -q fm.ui.taskview.task_remove()
  tmap <pagedown> eval -q fm.ui.taskview.task_move(-1)
  tmap <pageup>   eval -q fm.ui.taskview.task_move(0)
  tmap <delete>   eval -q fm.ui.taskview.task_remove()

  # Basic
  tmap <C-l> redraw_window
  tmap <ESC> taskview_close
  copytmap <ESC> q Q w <C-c>
''
