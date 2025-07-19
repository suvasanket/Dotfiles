import {
    duoLayer,
    ifApp,
    map,
    mapDoubleTap,
    rule,
    toKey,
    toHyper,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    switcher,
    tapModifiers,
    toClearNotifications,
    unix_mapping,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        vim_mode(),
        system_layer(),

        general_map(),
        hyper_layer(),

        app_finder(),
        app_browser(),
        app_ms_todo()
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
        'basic.to_if_held_down_threshold_milliseconds': 20,
    }
);

function general_map() {
    return rule("some general mappings").manipulators([
        ...unix_mapping(),

        map("left_command").to("left_command").toIfAlone("escape"),
        map("right_control").to("escape"),
        map("j", "option").to("tab", "command"),
        map("k", "option").to("tab", "⌘⇧"),

        mapDoubleTap('↑').to('↖︎'),
        mapDoubleTap('↓').to('end'),
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_ms_todo() {
    return rule("mstodo", ifApp("^com.microsoft.to-do-mac")).manipulators([
        map("1", "⌃").to("1", "⌘⌥"),
        map("2", "⌃").to("2", "⌘⌥"),
        map("3", "⌃").to("3", "⌘⌥"),
        map("4", "⌃").to("4", "⌘⌥"),
        map("5", "⌃").to("5", "⌘⌥"),
        map("6", "⌃").to("6", "⌘⌥"),

        map("n", "⌃").to("↓"),
        map("p", "⌃").to("↑"),
    ]);
}

function app_browser() {
    const browsers = [
        'Chromium',
        '^company.thebrowser.Browser',
        '^org.mozilla.com.zen.browser',
        '^com.brave.Browser',
        'Orion',
        'Safari',
    ];
    return rule("Browser", ifApp(browsers)).manipulators([
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        })
    ]);
}
function hyper_layer() {
    return rule("hyper_layer").manipulators([
        map(";").toIfHeldDown(toHyper()).toIfAlone(";"),

        withModifier("Hyper")([
            map('a').toApp('ghostty'),
            // map('s').to$('/bin/zsh/ /Users/suvasanketrout/.config/aerospace/open_browser.sh'),
            map('d').toApp('obsidian'),
            map('f').to$('open /System/Library/CoreServices/Finder.app'),
            map('m').toApp('Activity Monitor'),
            map('j').toApp('Microsoft To Do'),

            map('c').to('c', '⌘⌥'),
            map('l').to('⇥', '⌘'),
            map('h').to('⇥', '⌘⇧'),
            // map('spacebar').to('f11', '⌘⌥'),
            // map('j').to('f12', '⌘⌥'),
            // map('y').to('f10', '⌘⌥'),
        ]),
    ])
}

function vim_mode() {
    let layer = duoLayer("s", "d")
    return layer.manipulators([
        withModifier("control")([
            map("h").to("⌫"),
            map("u").to("⌫" ,"‹⌘"),
            map("w").to("⌫" ,"‹⌥")
        ]),
        withModifier("??")([
            map("h").to("←"),
            map("j").to("↓"),
            map("k").to("↑"),
            map("l").to("→"),

            map("f").to("‹⌥"),
            map("a").to("‹⌘"),
            map("spacebar").to("‹⇧"),

            map("n").to("delete_or_backspace"),
            map("m").to("⌦"),
            map("'").to("z", "⌘"),
        ])
    ]);
}

function system_layer() {
    return duoLayer("z", "x").manipulators([
        withModifier("??")([
            map('l').to(']', '⌥'),
            map('h').to('[', '⌥'),
            map('j').to('tab', '⌘⇧'),
            map('k').to('tab', '⌘'),
            map('spacebar').to('left_shift'),

            map("delete_or_backspace").to(toClearNotifications),
            map("\\").toSleepSystem(),

            map("]").to("volume_up"),
            map("[").to("volume_down"),
            map("p").to("mute"),
            map("o").to("vk_consumer_next"),
            map("i").to('play_or_pause'),
            map("u").to("vk_consumer_previous"),
            map("=").to("display_brightness_increment"),
            map("-").to("display_brightness_decrement"),
        ]),
    ]);
}
