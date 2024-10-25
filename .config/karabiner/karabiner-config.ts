import {
    duoLayer,
    ifApp,
    layer,
    map,
    mapDoubleTap,
    rule,
    to$,
    toApp,
    toKey,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    historyNavi,
    switcher,
    tabNavi,
    tapModifiers,
    unix_mapping,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        sd_layer(),
        fn_layer(),
        quick_stuff(),

        general_map(),
        launchapp_layer(),

        app_finder(),
        app_superprod(),
        app_kitty(),
        app_chromium(),
        app_firefox(),
        app_arc(),
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);

function general_map() {
    return rule("some general mappings").manipulators([
        map("left_command").to("left_command").toIfAlone("escape"),
        map("'").to("left⌥").toIfAlone("'"),
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

function app_superprod() {
    return rule("superprod", ifApp("^com.super-productivity.app")).manipulators([
        map("w", "⌘").to("f1", "⌘⌥"),
    ]);
}

function app_kitty() {
    return rule("kitty", ifApp("^net.kovidgoyal.kitty")).manipulators([
        ...tabNavi(),
        ...switcher(),
        ...tapModifiers({
            'l⇧': toKey('p', '⌃'),
            'r⇧': toKey('n', '⌃'),
        })
    ]);
}

function app_chromium() {
    return rule("brave", ifApp("^org.chromium.Chromium")).manipulators([
        ...tabNavi(),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        }),
        //map('f', '⌃').to('t', '⌘')
    ]);
}
function app_firefox() {
    return rule("firefox", ifApp("^org.mozilla.firefox")).manipulators([
        ...unix_mapping(),
        ...tabNavi(),
        ...historyNavi(),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        }),
        map('h', '⌘⇧').to('home', '⌥')
    ]);
}
function app_arc() {
    return rule("arc", ifApp("^company.thebrowser.Browser")).manipulators([
        ...unix_mapping(),
        ...tabNavi(),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('j', '⌘⌥'),
        })
    ]);
}
function fn_layer() {
    let layer = duoLayer("f", "a");
    return layer.manipulators([
        withModifier("??")({
            spacebar: toKey('play_or_pause'),
            h: toKey("vk_consumer_previous"),
            j: toKey("volume_down"),
            k: toKey("volume_up"),
            l: toKey("vk_consumer_next"),
            "'": toKey("display_brightness_increment"),
            ";": toKey("display_brightness_decrement"),
        }),
    ]);
}
function sd_layer() {
    let layer = duoLayer("d", "s").threshold(100)
    return layer.manipulators([
        withModifier("??")({
            h: toKey("←"),
            j: toKey("↓"),
            k: toKey("↑"),
            l: toKey("→"),

            spacebar: toKey("‹⌥"),
            f: toKey("‹⌘"),

            y: toKey(4, "⇧"),
            u: toKey(5, "⇧"),
            i: toKey(6, "⇧"),
            o: toKey(7, "⇧"),
            p: toKey(8, "⇧"),

            b: toKey(1, "⇧"),
            n: toKey(2, "⇧"),
            m: toKey(3, "⇧"),

            "'": toKey("⌫"),
            ";": toKey("⌦"),
            r: toKey("z", "<⌘"),
        }),
    ]);
}

function quick_stuff() {
    return layer('`', 'quick').manipulators({
        '␣': toKey("f1", "⌘⌥"),
        '⏎': toKey("f1", "⌘"),
        j: toKey("f3", "⌘⌥⌃⇧"),
        k: toKey("f2", "⌘⌥⌃⇧"),
        l: toKey("f1", "⌘⌥⌃⇧"),
        h: toKey("f4", "⌘⌥⌃⇧"),
    })
}
function launchapp_layer() {
    return layer('spacebar').manipulators({
        n: toApp('Obsidian'),
        a: toApp('Arc'),
        m: toApp('Activity Monitor'),
        f: to$('open /System/Library/CoreServices/Finder.app'),
        1: to$('open /Applications/kitty.app'),
        2: toApp('Orion'),

        ',': toApp('System Settings'),
    })
}
