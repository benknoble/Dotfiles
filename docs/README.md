# Documentation of Dotfiles

## Links to files

- [aliases](/docs/aliases.md)
- [functions](/docs/functions.md)
- [whats installed](/docs/installed.md)
- ...

## Format of documentation

**Aliases** and **functions** will be documented in the order in which they appear as definitions.

**Aliases** will be documented as follows (without the quote block):

> **`alias name`**
>
> *Short description.* This is a longer description if necessary. Aliases should
> also be documented with a single line comment where they are defined

**Example** (real alias)

**`reload`**

*Reload the startup file.* Like the 2nd Matrix.

**Functions** follow the same format.

**Features** will be documented as follows (without the quote block):

> ### Feature name
>
> *Short description.* This is a longer description that explains the feature,
> how to use it, any caveats, &c. It will probably be more than one sentence.
>
> Or even paragraph.

**Installed** features will be documented as a list of features, grouped as
*Brew Formulae*, *Cask Apps*, *Vim Plugins*, and *Other*. For further
documentation of the features, consult the relevant `man`/`:help` pages.
