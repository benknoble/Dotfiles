# Functions

Defined in [functions.bash](/bash/functions.bash)

**`cdls`**

*`cd` and `ls` a directory.* Or cuddles. That works too.

1 argument: `dir` to switch to.

**`trash`**

*`mv` a file to Trash.* Impermanent delete, unless you obsessively empty Trash
like I do.

Variadic: `file[s...]` to trash.

**`aliases`**

*View aliases.* Similar to `alias` without arguments, but paged and with comment
strings. So actually just better.

0 arguments.

**`functions`**

*View functions.* For when you can't function.

0 arguments.

**`findPid`**

*Output PID of specified process.* Good for killing.

1 argument: `process` to find.

**`displayPath`**

*Print PATH entries on new lines.* Easy to read. Page to `less` if you have a busy
PATH, or consider cutting down on it.

0 arguments.

**`mkcd`**

*Make a directory and change to it.* Does *not* burn a CD of your favorite
albums.

1 argument: `dir` to make.

**`editall`**

*Opens all files provided in Vim tabs.* But really, try using buffers and
windows. It works better.

Variadic: `file[s...]` to open.

**`extract`**

*Inflate an archive.* Guesses based on the file extension the correct extraction
method and applies it, failing with a message if not possible.

Variadic: `archive[s...]` to extract.

**`pathadd`**

*Add a directory to the PATH.* Prevents duplicates.

1 argument: `dir` to add.

**`freewrite`**

*Start writing in Vim.* Opens a Markdown file named after the date and drops you
in. 'Cause you're free, free writin'.

0 arguments.

**`getip`**

*Display IP Address.* Does not get you tips.

0 arguments.

**`quote`**

*Quote a string.* Useful if you're having quote problems in bash.

1 arguments: `string` to quote.
