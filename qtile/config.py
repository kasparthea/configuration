from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os

mod = "mod4"
terminal = guess_terminal()

browser = os.environ['BROWSER']
private_browser = os.environ['PRIVATE_BROWSER']
wallpaper = os.environ['WALLPAPER']

keys = [
    # https://docs.qtile.org/en/latest/manual/config/lazy.html
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], 'e', lazy.spawn('emacsclient -c')),
    Key([mod], 'b', lazy.spawn(browser)),
    Key([mod], 'f', lazy.spawn(f'{terminal} -e ranger')),
    Key([mod], 'm', lazy.window.toggle_fullscreen()),
    Key([mod], 'v', lazy.spawn('copyq show')),
    Key([mod, 'shift'], 'b', lazy.spawn(private_browser)),
    Key([mod], "tab", lazy.layout.next(), desc="Move window focus to other window"),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('voldec')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('volup')),
    Key(
        [mod, "shift"],
        "f",
        lazy.spawn('pcmanfm')),
    Key(
        [mod, 'shift'],
        'd',
        lazy.spawn('rofi -show run')),
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down"),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Backspace", lazy.next_screen()),
    # Toggle between different layouts as defined below
    Key([mod], "Space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "s",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn('rofi -show drun'), desc="Spawn a command using a prompt widget"),
    Key([mod], 'period', lazy.screen.next_group()),
    Key([mod], 'comma', lazy.screen.prev_group()),
]


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Bsp(
        border_focus='#50fa7b', border_normal='#101010',
        border_on_single=True, wrap_clients=True,
    ),
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)

extension_defaults = widget_defaults.copy()

battery_theme_path = f'{os.environ["XDG_CONFIG_HOME"]}/qtile/battery-icons'

screens = [
    Screen(
        wallpaper=wallpaper, wallpaper_mode='fill',
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.WindowName(),
                # widget.PulseVolume(),
                widget.Backlight(backlight_name='intel_backlight')
                if os.path.isdir('/sys/class/backlight/intel_backlight') else widget.Backlight(),
                # BAT1 is external battery in my case and I disconnet it sometimes
                # however it seems that after the disconnect the bar has to be restarted manually
                # still better (definitely for now) than just displaying text battery not found or something
                widget.Battery(battery=1, charge_char='C', discharge_char='D', format='{char} {percent:2.0%}')
                if os.path.isdir('/sys/class/power_supply/BAT1') else widget.Spacer(length=0),
                widget.BatteryIcon(battery=1, theme_path=battery_theme_path)
                if os.path.isdir('/sys/class/power_supply/BAT1') else widget.Spacer(length=0),
                # adding None in else, caused the bar to crash and qtile to be stuck on only 1 workspace
                # keyboard shortcuts did not work at all but I could use already running terminal there
                # to edit the config and reload WM to the previous state
                widget.Battery(battery=0, charge_char='C', discharge_char='D', format='{char} {percent:2.0%}'),
                widget.BatteryIcon(battery=0, theme_path=battery_theme_path),
                widget.Clock(format="%Y-%m-%d %H:%M:%S"),
                widget.QuickExit(),
            ],
            24,
            border_width=[2, 2, 2, 2],  # Draw top and bottom borders
            border_color=["ff00ff", "ff00ff", "ff00ff", "ff00ff"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "LG3D"
