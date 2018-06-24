# VIM

* [Common shortcuts](#common-shortcuts)
  * [NORMAL mode](#normal-mode)
  * [MOVE commands](#move-commands)
  * [Enter `INSERT` mode](#enter-insert-mode)
  * [`DELETE` then enter `INSERT` mode](#delete-then-enter-insert-mode)
  * [`DELETE` commands](#delete-commands)
  * [`COPY` and `PASTE` commands](#copy-and-paste-commands)
  * [`FILE` info](#file-info)
  * [`FIND` in `FILE`](#find-in-file)
  * [`FIND` in `PROJECT`](#find-in-project)
  * [`FIND` in `LINE`](#find-in-line)
  * [`FIND` and `REPLACE`](#find-and-replace)
  * [`VISUAL` mode](#visual-mode)
  * [Internal help](#internal-help)
  * [`SET` commands](#set-commands)
  * [Work with windows](#work-with-windows)
* [Plugins](#plugins)
  * [Easymotion](#easymotion)
  * [NerdTree](#nerdtree)

## Common shortcuts

### NORMAL mode

```vim
[number]<command><object> or <command>[number]<object>

hjkl (left up down right)
esc or ctrl + [ - normal mode
:<press_tab> - autocomplete some commands
:<start_command> then press ctrl-d - see all commands
:q! - quit from file without save
:wq - quit from file with save
:w - save changes
:w <file_name> - save changes to file with name
:!<external_command> - execute external command
:e <file_name> - edit files
:source <file_path> - read vim script
esc - enter to normal mode
u - undo operation
U - undo all operations in line
ctrl-r - to undo the previous undo command
```

```vim
COMMANDS: i,a,o,r,c,x,d,p
OBJECTS: w,e,b,$,^
```

### MOVE commands

```vim
w - move to start of word (2w, 3w, #w)
e - move to end of word (2e, 3e, 3#)
b - move back to start of word (2b, 3b, #b)
B - move back to start of WORD
0 - move caret to start of line
^ - move caret to start of line
$ - move cart to end of line
gg - move to start of file
G - move to end of file
#G - move to line # where # number of line
% - move caret to next )]}
{ - go to previous empty line
} - go to next empty line
```

### Enter `INSERT` mode

```vim
i - here
I - in start of line
a - after current
A - in end of line
o - move caret to next line
O - move caret to previous line
r - can just edit current symbol
R - enter in REPLACE mode
```

### `DELETE` then enter `INSERT` mode

```vim
cw - delete word
ce - delete from caret to end of word
c$ - delete from caret to end of line
c^ - delete from caret to start of line
```

### `DELETE` commands

```vim
x   - delete right symbol and move caret left
dw  - from caret to end of word WITH space (can use d#w)
de  - from caret to end of word WITHOUT space
d$  - from caret to end of line
d^  - from caret to start of line
di' - delete text in ''
di" - delete text in ""
dd  - delete line (can use #dd)
dt<character> - delete from caret to <character>
```

### `COPY` and `PASTE` commands

```vim
:r <command or file_name> - copy text from output of command of file
p - paste text from buffer
pw - from caret to end of word WITH space (can use d#w)
pe - from caret to end of word WITHOUT space
p$ - from caret to end of line
p^ - from caret to start of line
y - copy selected text to buffer
yw - from caret to end of word WITH space (can use d#w)
ye - from caret to end of word WITHOUT space
y$ - from caret to end of line
y^ - from caret to start of line
Y - copy line to buffer
```

### `FILE` info

```vim
ctrl-g - file status
```

### `FIND` in `FILE`

```vim
* - find current word in file
/<text> - find text in file
?<text> - find text if file backward
:noh - no highlight - use it after complete search
n - go to next
N - go to previous
ctrl-o - go to start of search (can use several time)
ctrl-i - go to ahead
```

### `FIND` in `PROJECT`

```vim
:grep <what> <where>
:grep def *

:vimgrep <what> <where>
:vimgrep def *
:cnext - go to next entry
:cprev - go to prev entry
```

### `FIND` in `LINE`

```vim
f<search_character> - find in line
f<search_character> then ; - find in line then next
F<search_character> - find in line backward
F<search_character> then ; - find in line backward then next
t<search_character> - find in line and set caret before <search_character>
T<search_character> - find in line and set caret after <search_character>
```

### `FIND` and `REPLACE`

```vim
:s/<find_text>/<replace_text> - to first occurrence
:s/<find_text>/<replace_text> - in line
:#,#s/<find_text>/<replace_text>/g - where # - number of lines
:%s/<find_text>/<replace_text>/g - in all file
:%s/<find_text>/<replace_text>/gc - in all file with confirmation
```

### `VISUAL` mode

```vim
v - enter to visual mode
```

```vim
In visual mode you can:
1) Select some text and save it to new file:
  v - enter to visual mode
  : - command mode
  w <file_name> - save selected text to file with name

2) Delete some text:
  v - enter to visual mode
  d - delete selected text
```

### Internal help

```vim
:help
CTRL-W CTRL-W - move between windows
```

```vim
You can use :help command with arguments:
:help w
:help c_CTRL-D
:help insert-index
:help user-manual
```

### `SET` commands

```vim
:set <command>
In some cases if you type `no` before command it disable it

:set number - enable numbers of line
:set expandtab - enable dots instead of tabs
:set tabstop=2 - set tabs or dot width equal 2
:set hlsearch - highlight search
:set incsearch - incremental search (search begin immediately)

:set ic - ignore case
:set noic - no ignore case
:set hls is - means 'hlsearch incsearch'
:nohlsearch - disable highlights
```

### Work with windows

```vim
ctrl+w+n - open new window horizontaly
ctrl+w+hjkl - move cursor to window
ctrl+w+HJKL - move window to side
ctrl+w+q - quit all windows
```

## Plugins

### Easymotion

```vim
<leader_key>s -> <search_character> -> <character_position>
```

### NerdTree

```vim
? - press for help
i - open file in horizontal window
s - open file in vertical window
```
