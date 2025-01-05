import {
    duoLayer,
    ifApp,
    layer,
    map,
    mapDoubleTap,
    rule,
    toHyper,
    toKey,
    toSleepSystem,
    toSuperHyper,
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
        sd_layer(),
        fn_layer(),
        hyper(),
        system_layer(),

        general_map(),

        app_finder(),
        app_kitty(),
        app_browser()
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);

function general_map() {
    return rule("some general mappings").manipulators([
        ...unix_mapping(),

        map("left_command").to("left_command").toIfAlone("escape"),
        map("'").to("left⌥").toIfAlone("'"),
        map("right_control").to("escape"),
        map("j", "option").to("tab", "command"),
        map("k", "option").to("tab", "⌘⇧"),
        map('h', '⌘').to('[', '⌘⇧'),
        map('l', '⌘').to(']', '⌘⇧'),

        mapDoubleTap('↑').to('↖︎'),
        mapDoubleTap('↓').to('end'),
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_kitty() {
    return rule("kitty", ifApp("^net.kovidgoyal.kitty")).manipulators([
        ...switcher(),
    ]);
}

function app_browser() {
    const browsers = ['Chromium', 'Arc', '^org.mozilla.com.zen.browser', 'Orion', 'Safari'];
    return rule("Browser", ifApp(browsers)).manipulators([
        map("spacebar", "⌃").to('tab', '⌃'),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
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
    let layer = duoLayer("d", "s").threshold(60)
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

function hyper() {
    const aeros = '/opt/homebrew/bin/aerospace'
    const ne = `${aeros} list-workspaces --monitor focused --empty no`
    return rule("quick").manipulators([
        map("'").to(toHyper()).toIfAlone("'"),
        withModifier("Hyper")([
            //map('n').to$('/bin/sh /Users/suvasanketrout/.local/scripts/openSuperProd.sh'),
            map('n').to(",", "⌘⌥⌃"),
            map('spacebar').to(toSuperHyper()),

            map('m').toApp('Activity Monitor'),
            map('f').to$('open /System/Library/CoreServices/Finder.app'),
            map('a').toApp('ghostty'),
            map('s').toApp('zen browser'),
            map('d').toApp('ChatGPT'),
            map('g').toApp('obsidian'),

            map('h').to$(`${ne} | ${aeros} workspace prev`),
            map('l').to$(`${ne} | ${aeros} workspace next`),
            //map('h').to('[', '⌘⇧'),
            //map('l').to(']', '⌘⇧'),
        ]),
    ])
}

function system_layer() {
    let l = layer("`", "System");
    return l.manipulators([
        withModifier("??")({
            h: toKey('[', '⌥'),
            l: toKey(']', '⌥'),
            '⏎': toKey('f', '⌥⇧'),
            s: toKey('s', '⌥⇧'),
            spacebar: toKey('left_shift'),
            x: toKey('⏎', '⌘⌃'),

            1: toKey('1', '⌥'),
            2: toKey('2', '⌥'),
            3: toKey('3', '⌥'),
            4: toKey('4', '⌥'),
            5: toKey('5', '⌥'),

            n: toClearNotifications,
            '\\': toSleepSystem(),
        }),
    ]);
}
