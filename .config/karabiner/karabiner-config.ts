import {
    duoLayer,
    ifApp,
    map,
    mapDoubleTap,
    rule,
    toKey,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    switcher,
    tapModifiers,
    unix_mapping,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        vim_mode(),

        general_map(),

        app_finder(),
        app_browser(),
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "basic.to_if_held_down_threshold_milliseconds": 10,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);

function general_map() {
    return rule("some general mappings").manipulators([
        ...unix_mapping(),

        map("left_command").to("left_command").toIfAlone("escape"),
        map("right_control").to("escape"),

        mapDoubleTap('↑').to('↖︎'),
        mapDoubleTap('↓').to('end'),
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_browser() {
    const browsers = [
        'Chromium',
        '^net.imput.helium',
        '^app.zen-browser.zen',
        '^com.brave.Browser',
        '^com.vivaldi.Vivaldi',
        '^com.kagi.kagimacOS',
        'Safari',
    ];
    return rule("Browser", ifApp(browsers)).manipulators([
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
            '‹⌃': toKey('s', '⌘⌃'),
        }),
        map("n", "⌃").to("down_arrow"),
        map("p", "⌃").to("up_arrow"),
    ]);
}
function hyper_layer() {
    return rule("hyper_layer").manipulators([
        withModifier("Hyper")([
            map('a').toApp('ghostty'),
            // map('s').to$('/bin/sh ~/.config/aerospace/open_browser.sh'),
            map('d').toApp('Reminders'),
            map('n').toApp('Logseq'),
            map('f').to$('open /System/Library/CoreServices/Finder.app'),
            map('m').toApp('Activity Monitor'),

            map('p').to('c', '⌘⌥'),

            map('l').to(']', '⌘⇧'),
            map('h').to('[', '⌘⇧'),
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
            map("spacebar").to("‹⌘"),

            map("n").to("delete_or_backspace"),
            map("m").to("⌦"),
            map("'").to("z", "⌘"),
        ])
    ]);
}
