Motions

`w`ord
`W`ord(ignore characters)
`e`nd of word
`E`nd of word(ignore characters)
`b`ackwards
`0` start of the line
`$` end of the line (string end in regex hence $)

# Lesson 1

`i`nsert
`a`ppend
`A`ppend(end of the line)

To insert or append text type:
    `i`{normal} insert text `<Esc>`{normal}     insert before the cursor.
    `A`{normal} append text `<Esc>`{normal}     append after the line.

# Lesson 2

`d`elete (also cuts)
`dd`elete(whole line)(also cuts)
`u`ndo
`U`ndo(whole line)
`Control + R`edo

# Lesson 3

`p`ut
`P`ut(above)
`r`eplace(+ character) 
`R`eplace(override characters)
`c`hange

# Lesson 4
`Control + g` - Show file status

`G`o to line (or end of file)
`gg`o to start of file
`/` forward search
`?` backwards search
    `n`ext occurrence
    `N` previous occurrence
    `\c` at the end ignores casing eg `/ignore\c`
`*` search using word at cursor 

`Control + o`ld location (jumplist)
`Control + i` next location (jumplist)

`%` toggle prev/next matching bracket

`:s`ubstitute.
    `:s/old/new/g`
    `:s/three/the/g`
    `:1,3s/old/new` - line numbers
    `:%s/old/new` - the whole file

    `g` - global, like regex
    `c` - confirm, will ask with a promp to confirm the change

# Lesson 5

`:!` execute a normal shell command within vim

`v`isual mode, can be used to save only the selection with `:w`
`Control + v`isual BLOCK mode

# Lesson 6

`o`pen a line under
`O`pen a line above
`y`ank (copy) (use `p`ut to paste)
`yy`ank(whole line)

# Lesson 7

`Control + w`indow to change between open windows
`Control + d`ownwards the page
`Control + u`pwards the page
`zz` Center cursor in screen

Within the command mode: `Control + d`isplay completion

-----------------------------------------------------------

`S`ubstitute (delete line and start typing)

----------------------------------------------------------

`.` repeat last command
`f`ind letter
`t`ill the char(before)
`T`ill the char(after)


`]d`iagnostic (next)
`[d`iagnostic (prev) 

`gc`omment selection
`gcc`omment (line)
