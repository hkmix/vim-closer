# vim-closer

Forked version that removes semicolon operations and enables it for all buffers by default.

**Closes brackets.** Perfect companion to [vim-endwise]. Basically, a more conservative version of [auto-pairs] that only works when you press Enter.

## What

Closings are automatically inserted after pressing <kbd>Enter ⏎</kbd>. It supports `(`, `[`, and `{` brackets by default.

```css
.section {⏎
```

```css
.section {
  |
}
```

It tries to automatically figure out whatever braces were opened in the line. This is useful for, say, JavaScript where `});` is commonly seen.

```js
describe('test', function () {⏎
```

```js
describe('test', function () {
  |
})
```

## Install

When using [vim-plug], add this to your `~/.vimrc`:

[vim-plug]: https://github.com/junegunn/vim-plug

```vim
Plug 'hkmix/vim-closer'
```

## Thanks

**vim-closer** © 2015+, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored and maintained by Rico Sta. Cruz with help from contributors ([list][contributors]).

> [ricostacruz.com](http://ricostacruz.com) &nbsp;&middot;&nbsp;
> GitHub [@rstacruz](https://github.com/rstacruz) &nbsp;&middot;&nbsp;
> Twitter [@rstacruz](https://twitter.com/rstacruz)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/vim-closer/contributors
