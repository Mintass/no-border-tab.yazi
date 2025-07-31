# no-border-tab.yazi

This simple plugin fixes a visual inconsistency in tab bar styling when the active tab is at either end of the tab list.
> note: mouse event will be disabled!

**original tab line:**
![origin](https://github.com/user-attachments/assets/d71dca24-0858-4245-9d4e-2d8f02ea248f)

**new tab line:**
![new](https://github.com/user-attachments/assets/752c0bb1-de07-430b-a3ed-94d68057bc1f)

## Installation

```sh
ya pkg add Mintass/no-border-tab
```

## Usage

Add this to your `~/.config/yazi/init.lua`:

```lua
require("better-tabs").setup()
```

## License

This plugin is MIT-licensed. For more information check the [LICENSE](LICENSE) file.